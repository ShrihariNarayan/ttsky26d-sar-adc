# mk_core.py -- turn the full-tile PEX netlist into an "adc_core" subckt with the schematic's pin order
import re,sys
src=open(sys.argv[1]).read(); out=sys.argv[2]
head,top=src.split('.subckt tt_um_shriharinarayan_sar_adc',1)
body=top.split('\n',1)[1]
lines=body.split('\n'); i=0
while lines[i].startswith('+'): i+=1           # drop the tile port continuation lines
body='\n'.join(lines[i:])
M={'ua[0]':'vin','ua[1]':'Vref','VDPWR':'VDD','VGND':'VSS','sar_logic_0/phi':'phi','sar_logic_0/comp':'comp',**{f'cdac_0/dn{k}':f'dn{k}' for k in range(8)}}
def sub(ln):
    t=ln.split()
    if not t or t[0].startswith('*') or t[0]=='.ends': return ln
    return ' '.join(M.get(x,x) for x in t)
body='\n'.join(sub(l) for l in body.split('\n'))
# nets of the top level that touch no device (tile pins, logic-abstract wells...) only carry
# capacitors -> give each a 1 Gohm DC path to VSS so the operating point is not singular
ports={'phi','clk','vin','comp','VDD','VSS','Vref'}|{f'dn{k}' for k in range(8)}
dev=set(); capn=set(); cur=None
for ln in body.split('\n'):
    t=ln.split()
    if not t: continue
    if t[0][0] in 'Xx': cur='X'; dev.update(t[1:-1]); continue
    if t[0]=='+' and cur=='X': dev.update(t[1:]); continue
    cur=None
    if t[0][0] in 'Cc': capn.update(t[1:3])
float_nodes=sorted(capn-dev-ports-{'0'})
ties='\n'.join(f'Rtie{n} {x} VSS 1G' for n,x in enumerate(float_nodes))
body=body.replace('.ends',ties+'\n.ends',1)
hdr='.subckt adc_core phi clk vin comp dn7 VDD dn6 dn5 VSS dn4 dn3 dn2 dn1 Vref dn0\n'
open(out,'w').write('* adc_core_pex.spice -- post-layout (C-only PEX, Magic) netlist of the full tile analog core,\n* generated from tt_um_shriharinarayan_sar_adc by mk_core.py. Pin order = xschem adc_core.\n'+head+hdr+body)
