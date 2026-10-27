# mk_ic.py IN OUT -- post-layout netlist with the extracted comparator replaced by an ideal one
# (continuous, no kickback, no load): comp = 1.8 V if vtop > vcm. Orphaned comparator nodes get 1G ties.
import sys,re
t=open(sys.argv[1]).read().split('\n'); out=[]; i=0; orphan=set()
while i<len(t):
    if t[i].startswith('Xcomparator_0 '):
        blk=[t[i]]; i+=1
        while i<len(t) and t[i].startswith('+'): blk.append(t[i]); i+=1
        toks=' '.join(b.lstrip('+') for b in blk).split()
        orphan.update(x for x in toks[1:-1] if x.startswith('comparator_0/'))
        out.append('bcmp comp VSS v = 1.8*u(v(cdac_0/vtop)-v(vcm_gen_0/vcm))')
        out+= [f'Ric{k} {n} VSS 1G' for k,n in enumerate(sorted(orphan))]
        continue
    out.append(t[i]); i+=1
open(sys.argv[2],'w').write('\n'.join(out)); print('ideal comparator; orphan ties',len(orphan))
