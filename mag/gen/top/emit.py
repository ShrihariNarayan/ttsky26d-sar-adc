import json
BB={'comparator':(-0.265,-0.265),'cdac':(-1.8,-0.6),'bootstrap_switch':(-0.55,-0.265),'vcm_gen':(-0.265,-0.4),'decap':(-0.77,-0.265),'decap2':(-0.77,-0.265)}
OFF={'cdac':(77.2,48.5),'bootstrap_switch':(128.26,9.0),'decap':(80.0,9.0),'vcm_gen':(10.0,9.0),'comparator':(45.0,75.0),'decap2':(8.5,100.0)}
f=lambda v:f'{v:.3f}um'
L=['gds readonly true','gds rescale false','gds read sar_logic.gds','load tt_um_shriharinarayan_sar_adc','select clear']
for c,(ox,oy) in OFF.items():
    bx,by=BB[c]; L+=[f'box {f(ox+bx)} {f(oy+by)} {f(ox+bx)} {f(oy+by)}',f'getcell {c}']
lm={'m1':'metal1','m2':'metal2','m3':'metal3','m4':'metal4','via1':'via1','via2':'via2','via3':'via3'}
for l,x1,y1,x2,y2,n in json.load(open('r/routes.json')):
    L+=[f'box {f(x1)} {f(y1)} {f(x2)} {f(y2)}',f'paint {lm[l]}']
L+=['select clear','save tt_um_shriharinarayan_sar_adc','puts EMITTED']
open('r/emit.tcl','w').write('\n'.join(L)+'\nquit -noprompt\n')
