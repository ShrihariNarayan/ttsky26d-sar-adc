# block placement in tile coords (um): name -> (bbox lower-left x, y)
import re
U=200
BB={'comparator':(-0.265,-0.265),'cdac':(-1.8,-0.6),'bootstrap_switch':(-0.55,-0.265),'vcm_gen':(-0.265,-0.4),'decap':(-0.77,-0.265)}
# origin offsets (local 0,0 -> tile)
OFF={'cdac':(77.2,48.5),'bootstrap_switch':(128.26,9.0),'decap':(80.0,9.0),'vcm_gen':(10.0,9.0),'comparator':(45.0,75.0)}
def mag_bbox(c):
    t=open(c+'.mag').read()
    m=re.search(r'FIXED_BBOX (\S+) (\S+) (\S+) (\S+)',t)
    return None
def write_ana(fn='ana.mag'):
    L=['magic','tech sky130A','magscale 1 2','timestamp 0']
    for c,(ox,oy) in OFF.items():
        L+=[f'use {c}  {c}_0','timestamp 0',f'transform 1 0 {round(ox*U)} 0 1 {round(oy*U)}','box 0 0 1 1']
    L+=['<< properties >>','<< end >>']
    open(fn,'w').write('\n'.join(L)+'\n')
if __name__=='__main__': write_ana()
