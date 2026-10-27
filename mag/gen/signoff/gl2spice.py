import re,sys
gl=open(sys.argv[1]).read(); lib=open(sys.argv[2]).read()
order=sys.argv[3].split()           # port order wanted for .subckt sar_logic
pins={m.group(1):m.group(2).split() for m in re.finditer(r'^\.subckt\s+(\S+)\s+(.*)$',lib,re.M)}
def net(n):
    n=n.strip()
    if n.startswith('\\'): n=n[1:].strip()
    return n.replace(' ','')
out=['.subckt sar_logic '+' '.join(order)]; miss=set(); k=0
for m in re.finditer(r'^\s*(sky130_\w+)\s+(\S+)\s*\((.*?)\);',gl,re.M|re.S):
    cell,inst,body=m.groups()
    conn={p:net(n) for p,n in re.findall(r'\.(\w+)\s*\(\s*(.*?)\s*\)\s*(?:,|$)',body,re.S)}
    if cell not in pins: miss.add(cell); continue
    nets=[conn.get(p,'NC_%s_%s'%(inst,p)) for p in pins[cell]]
    for p in pins[cell]:
        if p not in conn:
            if p=='VPB': nets[pins[cell].index(p)]=conn.get('VPWR','VPWR')
            if p=='VNB': nets[pins[cell].index(p)]=conn.get('VGND','VGND')
    out.append('X%s %s %s'%(re.sub(r'\W','_',inst),' '.join(nets),cell)); k+=1
out.append('.ends'); open(sys.argv[4],'w').write('\n'.join(out)+'\n')
print('instances',k,'missing cells',sorted(miss))
