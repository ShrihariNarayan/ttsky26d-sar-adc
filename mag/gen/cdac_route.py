# cdac_route.py -- phase 2: lanes/tabs for the bottom plates + generic pcell terminal extraction + m2/m3 A* router
import re, heapq, itertools, math, sys
import numpy as np
U=200.0
def parse_mag(fn):
    lab=[]; m1=[]; bb=None; cur=None
    for ln in open(fn):
        if ln.startswith('<< '): cur=ln.strip()[3:-3]; continue
        t=ln.split()
        if not t: continue
        if t[0]=='rect' and cur=='metal1': m1.append(tuple(int(v)/U for v in t[1:5]))
        if t[0]=='rlabel': lab.append((t[-1],t[1],int(t[2])/U,int(t[3])/U))
        if t[0]=='string' and t[1]=='FIXED_BBOX': bb=tuple(int(v)/U for v in t[2:6])
    return lab,m1,bb
inst=[]
txt=open('cdac.mag').read()
for m in re.finditer(r'use (\S+)\s+(\S+)\ntimestamp \d+\ntransform (.*)\n',txt):
    a,b,c,d,e,f=[int(v) for v in m.group(3).split()]
    inst.append((m.group(2),m.group(1),c/U,f/U))
rects=[]; term={}
def R(l,x1,y1,x2,y2,net): rects.append((l,min(x1,x2),min(y1,y2),max(x1,x2),max(y1,y2),net))
def via1(x,y,net,t=True):
    R('via1',x-.13,y-.13,x+.13,y+.13,net); R('m2',x-.13,y-.16,x+.13,y+.16,net); R('m1',x-.13,y-.16,x+.13,y+.16,net)
    if t: term.setdefault(net,[]).append((x,y))
def via2(x,y,net):
    R('via2',x-.15,y-.15,x+.15,y+.15,net); R('m2',x-.195,y-.16,x+.195,y+.16,net); R('m3',x-.175,y-.175,x+.175,y+.175,net)
bpts=[]
for (name,cell,cx,cy) in inst:
    lab,m1,bb=parse_mag(cell+'.mag'); hw=bb[2]
    k=name[2:]; dev=name[:2]
    nets={'D':'b'+k,'G':'dn'+k,'S':'Vref' if dev=='MP' else 'VSS','B':'Vref' if dev=='MP' else 'VSS'}
    ds=sorted([l for l in lab if l[0][0] in 'DS'],key=lambda l:l[2])
    if len(ds)>=2 and ds[0][0][1:].isdigit():   # nf fingers -> nf+1 strips; the generator labels only nf of them
        pitch=ds[1][2]-ds[0][2]; last=ds[-1]
        lab=lab+[('S' if last[0][0]=='D' else 'D','x',last[2]+pitch,last[3])]
    for (ln,layer,lx,ly) in lab:
        net=nets[ln[0]]
        if ln[0] in 'DS':
            via1(cx+lx,cy+ly,net)
        elif ln[0]=='G':
            rs=[r for r in m1 if abs((r[0]+r[2])/2-lx)<.2 and abs((r[1]+r[3])/2-ly)<.12 and (r[3]-r[1])<.6]
            x1=min(r[0] for r in rs); x2=max(r[2] for r in rs); y1=min(r[1] for r in rs); y2=max(r[3] for r in rs)
            xc=(x1+x2)/2; w=max(x2-x1,.32)
            if ly>0: y2=max(y2,y1+.32)
            else: y1=min(y1,y2-.32)
            R('m1',cx+xc-w/2,cy+y1,cx+xc+w/2,cy+y2,net)
            via1(cx+xc,cy+(y1+y2)/2,net)
            # mirrored (unlabelled) gate pad on the other side: enlarge for met1.6 area only
            rs2=[r for r in m1 if abs((r[0]+r[2])/2-lx)<.2 and abs((r[1]+r[3])/2+ly)<.12 and (r[3]-r[1])<.6]
            if rs2 and not any(l2[0]=='G' and abs(l2[2]-lx)<.05 and abs(l2[3]+ly)<.05 for l2 in lab):
                a1=min(r[0] for r in rs2); a2=max(r[2] for r in rs2); b1=min(r[1] for r in rs2); b2=max(r[3] for r in rs2)
                if -ly>0: b2=max(b2,b1+.32)
                else: b1=min(b1,b2-.32)
                R('m1',cx+(a1+a2)/2-w/2,cy+b1,cx+(a1+a2)/2+w/2,cy+b2,net)
        elif ln[0]=='B':
            for sx in (-hw,hw):
                px,py=cx+sx,cy
                if any(abs(px-a)<.1 and abs(py-b)<.5 and n==net for a,b,n in bpts): continue
                bpts.append((px,py,net))
                R('mcon',px-.085,py-.085,px+.085,py+.085,net); R('m1',px-.17,py-.19,px+.17,py+.19,net); via1(px,py,net)
# ---- bottom-plate access: tabs (top-row groups) and m2 lanes (interior groups) ----
YT=64.75
for net,x1,x2 in (('b7',8,9),('b6',19.5,20.5),('b5',30.5,31.5),('b6',43.5,44.5),('b7',55,56)):
    R('m3',x1,63.0,x2,65.0,net); via2((x1+x2)/2,YT,net); term.setdefault(net,[]).append(((x1+x2)/2,YT))
lanes=[('b5',25.4,[4.0]),('b4',26.2,[20.0,44.0]),('b3',28.0,[26.0,38.0]),('b2',29.0,[32.0]),('b1',34.0,[32.0]),('VSS',36.555,[34.0]),('b0',39.445,[30.0])]
for net,x,ys in lanes:
    for y in ys: via2(x,y,net)
    R('m2',x-.1,min(ys),x+.1,YT,net); R('m2',x-.13,YT-.16,x+.13,YT+.16,net); term.setdefault(net,[]).append((x,YT))
# ---------------- router (m2/m3) ----------------
G=0.05; X0,Y0,X1,Y1=-2.0,64.4,66.0,92.0
NX=int(round((X1-X0)/G))+1; NY=int(round((Y1-Y0)/G))+1
gx=lambda x:int(round((x-X0)/G)); gy=lambda y:int(round((y-Y0)/G)); ux=lambda i:X0+i*G; uy=lambda j:Y0+j*G
L=['m2','m3']; HW={'m2':.1,'m3':.15}; SP={'m2':.14,'m3':.3}; VP={'m2':.195,'m3':.175}
M3MIN=64.55   # keep m3 >= 1.34 um from the top-row MiM caps
def mask_for(net):
    blk={}; vblk={}
    for l in L:
        b=np.zeros((NX,NY),bool); vb=np.zeros((NX,NY),bool)
        for (ll,x1,y1,x2,y2,nn) in rects:
            if ll!=l or nn==net or y2<Y0-1: continue
            for arr,e in ((b,HW[l]+SP[l]),(vb,VP[l]+SP[l])):
                i1=max(0,math.ceil((x1-e-X0)/G-1e-6)); i2=min(NX-1,math.floor((x2+e-X0)/G+1e-6))
                j1=max(0,math.ceil((y1-e-Y0)/G-1e-6)); j2=min(NY-1,math.floor((y2+e-Y0)/G+1e-6))
                if i1<=i2 and j1<=j2: arr[i1:i2+1,j1:j2+1]=True
        blk[l]=b; vblk[l]=vb
    jm=gy(M3MIN); blk['m3'][:,:jm]=True; vblk['m3'][:,:gy(M3MIN+.18)]=True
    return blk,vblk
def route(net):
    blk,vblk=mask_for(net)
    pts=term[net]; tree={(gx(pts[0][0]),gy(pts[0][1]),0)}; segs=[]; rem=list(pts[1:])
    while rem:
        targ={(gx(p[0]),gy(p[1]),0):p for p in rem}; tl=list(targ)
        h=lambda i,j:min(abs(a-i)+abs(b-j) for a,b,_ in tl)
        op=[]; g={}; par={}
        for s in tree: g[s]=0; heapq.heappush(op,(h(s[0],s[1]),0,s))
        found=None
        while op:
            f,c,s=heapq.heappop(op)
            if g.get(s,1e18)<c: continue
            if s in targ: found=s; break
            i,j,l=s
            for di,dj in ((1,0),(-1,0),(0,1),(0,-1)):
                ni,nj=i+di,j+dj
                if not(0<=ni<NX and 0<=nj<NY): continue
                n=(ni,nj,l)
                if blk[L[l]][ni,nj] and n not in targ: continue
                pref=(l==0 and di==0) or (l==1 and dj==0)
                nc=c+(1 if pref else 3)
                if nc<g.get(n,1e18): g[n]=nc; par[n]=s; heapq.heappush(op,(nc+h(ni,nj),nc,n))
            n=(i,j,1-l)
            if not vblk['m2'][i,j] and not vblk['m3'][i,j]:
                nc=c+40
                if nc<g.get(n,1e18): g[n]=nc; par[n]=s; heapq.heappush(op,(nc+h(i,j),nc,n))
        if not found: return None
        path=[found]
        while path[-1] in par and path[-1] not in tree: path.append(par[path[-1]])
        path.reverse(); segs.append(path); tree.update(path); rem.remove(targ[found])
    return segs
def emit(net,segs):
    for path in segs:
        i=0
        while i<len(path)-1:
            a,b=path[i],path[i+1]
            if a[2]!=b[2]: via2(ux(a[0]),uy(a[1]),net); i+=1; continue
            d=(b[0]-a[0],b[1]-a[1]); j=i+1
            while j<len(path)-1 and path[j+1][2]==a[2] and (path[j+1][0]-path[j][0],path[j+1][1]-path[j][1])==d: j+=1
            e=path[j]; l=L[a[2]]; hw=HW[l]
            R(l,min(ux(a[0]),ux(e[0]))-hw,min(uy(a[1]),uy(e[1]))-hw,max(ux(a[0]),ux(e[0]))+hw,max(uy(a[1]),uy(e[1]))+hw,net); i=j
order=sys.argv[1].split(',') if len(sys.argv)>1 and sys.argv[1] else []
nets=order+[n for n in sorted(term,key=lambda n:-len(term[n])) if n not in order]
fail=[]
for net in nets:
    if len(term[net])<2: continue
    s=route(net); print('routed',net,s is not None,file=sys.stderr,flush=True)
    if s is None: fail.append(net); continue
    emit(net,s)
def fill():
    add=[]; by={}
    for r in rects:
        if r[0] in ('m2','m3'): by.setdefault((r[0],r[5]),[]).append(r)
    for (l,net),rs in by.items():
        s=SP[l]
        for a,b in itertools.combinations(rs,2):
            ox=min(a[3],b[3])-max(a[1],b[1]); oy=min(a[4],b[4])-max(a[2],b[2])
            if ox>0 and -s<oy<0: add.append((l,max(a[1],b[1]),min(a[4],b[4]),min(a[3],b[3]),max(a[2],b[2]),net))
            elif oy>0 and -s<ox<0: add.append((l,min(a[3],b[3]),max(a[2],b[2]),max(a[1],b[1]),min(a[4],b[4]),net))
            elif ox<=0 and oy<=0 and ox>-s and oy>-s and not(ox==0 or oy==0): add.append((l,min(a[3],b[3]),min(a[4],b[4]),max(a[1],b[1]),max(a[2],b[2]),net))
    for r in add: R(*r)
    return len(add)
for _ in range(3):
    if fill()==0: break
print('FAILED:',fail,file=sys.stderr)
lm={'m1':'metal1','m2':'metal2','m3':'metal3','via1':'via1','via2':'via2','mcon':'mcon'}
f=lambda v:f'{v:.3f}um'
out=['load cdac']
for (l,x1,y1,x2,y2,n) in rects: out+=[f'box {f(x1)} {f(y1)} {f(x2)} {f(y2)}',f'paint {lm[l]}']
def free_m3(x,y,net): return not any(r[0]=='m3' and r[5]!=net and r[1]-.05<=x<=r[3]+.05 and r[2]-.05<=y<=r[4]+.05 for r in rects)
for p in ['dn%d'%k for k in range(8)]+['Vref','VSS']:
    x,y=next(((a,b) for a,b in term[p] if free_m3(a,b,p)),term[p][0])
    out+=[f'box {f(x-.05)} {f(y-.05)} {f(x+.05)} {f(y+.05)}',f'label {p} c metal2','port make']
out+=['box -1.35um 30um -1.25um 30.1um','label vtop c metal4','port make']
open('cdac_wire.tcl','w').write('\n'.join(out)+'\n')
