# route_cmp.py -- generate wiring for cell "comparator": fixed shapes + 2-layer (m2/m3) A* router.
import heapq, itertools, math, random, sys
import numpy as np
G=0.05                                    # grid step (um)
X0,Y0,X1,Y1=-1.5,-1.5,30.0,24.5
NX=int(round((X1-X0)/G))+1; NY=int(round((Y1-Y0)/G))+1
def gx(x): return int(round((x-X0)/G))
def gy(y): return int(round((y-Y0)/G))
def ux(i): return X0+i*G
def uy(j): return Y0+j*G
# ---------------- devices ----------------
# type: hw,hh, strips[(dx,'D'|'S')], strip_half, gate pads top [(dx)], gate_y, padhalf_x, bottom pads
T={
 'n1':dict(hw=.79,hh=1.285,st=[(-.22,'D'),(.22,'S')],sh=.5,gy=.775,gx=[0],px=.145,bot=[0]),
 'S' :dict(hw=1.015,hh=1.785,st=[(-.445,'D'),(.445,'S')],sh=1.0,gy=1.275,gx=[0],px=.28,bot=[0]),
 'n2':dict(hw=.79,hh=1.785,st=[(-.22,'D'),(.22,'S')],sh=1.0,gy=1.275,gx=[0],px=.145,bot=[0]),
 'p2':dict(hw=.79,hh=1.83,st=[(-.22,'D'),(.22,'S')],sh=1.0,gy=1.32,gx=[0],px=.145,bot=[0]),
 'p1':dict(hw=.79,hh=1.33,st=[(-.22,'D'),(.22,'S')],sh=.5,gy=.82,gx=[0],px=.145,bot=[0]),
 'p7':dict(hw=.79,hh=2.83,st=[(-.22,'D'),(.22,'S')],sh=2.0,gy=2.32,gx=[0],px=.145,bot=[0]),
 'p4':dict(hw=2.15,hh=1.83,st=[(-1.58,'D'),(-.79,'S'),(0,'D'),(.79,'S'),(1.58,'D')],sh=1.0,gy=1.32,gx=[-1.185,-.395,.395,1.185],px=.23,bot=[-1.185]),
}
# name, type, ll x, ll y, D, G, S, B
D=[('MIN','n1',0,0,'ckb','clk','VSS','VSS'),('MIP','p2',0,5.6,'ckb','clk','VDD','VDD'),
 ('S1','S',2.5,0,'P','ckb','VSS','VSS'),('S3','S',5.03,0,'X','ckb','VSS','VSS'),
 ('M5','n1',7.56,0,'X','Y','VSS','VSS'),('M6','n1',9.64,0,'Y','X','VSS','VSS'),
 ('S4','S',11.72,0,'Y','ckb','VSS','VSS'),('S2','S',14.25,0,'Q','ckb','VSS','VSS'),
 ('M3','p2',7.81,5.6,'X','Y','P','VDD'),('M4','p2',9.39,5.6,'Y','X','Q','VDD'),
 ('M1','p4',5.09,11.26,'P','inp','T','T'),('M2','p4',9.39,11.26,'Q','inn','T','T'),
 ('M7','p7',8.6,16.92,'T','ckb','VDD','VDD')]
lat=[('MI2N','n1','Xb','X','VSS'),('MI2P','p2','Xb','X','VDD'),('MA3','n2','outp','Yb','na'),('MA1','p1','outp','Yb','VDD'),
     ('MA4','n2','na','outn','VSS'),('MA2','p1','outp','outn','VDD'),('MB4','n2','nb','outp','VSS'),('MB2','p1','outn','outp','VDD'),
     ('MB3','n2','outn','Xb','nb'),('MB1','p1','outn','Xb','VDD'),('MI1N','n1','Yb','Y','VSS'),('MI1P','p2','Yb','Y','VDD')]
x=17.8
for i in range(0,12,2):
    for k,(n,t,d,g,s) in enumerate(lat[i:i+2]):
        D.append((n,t,x,0 if t[0]=='n' else 5.6,d,g,s,'VSS' if t[0]=='n' else 'VDD'))
    x+=1.58
# ---------------- shapes ----------------
rects=[]   # (layer, x1,y1,x2,y2, net)
def R(l,x1,y1,x2,y2,net): rects.append((l,min(x1,x2),min(y1,y2),max(x1,x2),max(y1,y2),net))
term={}    # net -> list of (x,y) access points on m2 (via1 pad centres)
def via1(x,y,net):
    R('via1',x-.13,y-.13,x+.13,y+.13,net); R('m2',x-.13,y-.16,x+.13,y+.16,net); R('m1',x-.13,y-.16,x+.13,y+.16,net)
    term.setdefault(net,[]).append((x,y))
cen={}
for (n,t,lx,ly,dn,gn,sn,bn) in D:
    p=T[t]; cx=lx+p['hw']; cy=ly+p['hh']; cen[n]=(cx,cy,t)
    for dx,ds in p['st']:
        via1(cx+dx,cy,dn if ds=='D' else sn)
    gy_=cy+p['gy']
    if t=='p4':   # bar across the 4 top gate pads
        R('m1',cx-1.415,gy_-.115,cx+1.415,gy_+.145,gn); via1(cx,gy_+.015,gn)
    else:
        R('m1',cx-max(p['px'],.16),gy_-.115,cx+max(p['px'],.16),gy_+.205,gn); via1(cx,gy_+.045,gn)
    for bx in p['bot']:
        yb=cy-p['gy']
        if p['px']<.2: R('m1',cx+bx-.16,yb-.205,cx+bx+.16,yb+.115,gn)
# rails + ring contacts
def mcon(x,y,net): R('mcon',x-.085,y-.085,x+.085,y+.085,net)
R('m1',0,-.25,27.28,.115,'VSS')
for (n,t,lx,ly,*_ ) in D:
    if t[0] in 'nS': mcon(cen[n][0],0,'VSS')
R('m1',0,9.145,27.28,9.51,'VDD')
for n in ('MIP','M3','M4','MI2P','MI1P'): mcon(cen[n][0],9.26,'VDD')
R('m1',8.6,22.465,10.18,22.83,'VDD'); mcon(9.39,22.58,'VDD')
# T ring contacts (top ring of M1/M2 at y=14.92)
for xx in (9.04,9.74):
    mcon(xx,14.92,'T'); R('m1',xx-.16,14.76,xx+.16,15.08,'T'); via1(xx,14.92,'T')
# rail access pads
for xx in (1.2,4.3,7.0,13.5,16.9,19.5,22.7,25.9): via1(xx,-.07,'VSS')
for xx in (0.4,3.5,6.0,12.0,15.0,18.5,21.7,24.9,27.0): via1(xx,9.33,'VDD')
via1(9.39,22.65,'VDD')
# ---------------- router ----------------
L=['m2','m3']; HW={'m2':.1,'m3':.15}; SP={'m2':.14,'m3':.3}; VP={'m2':.195,'m3':.175}
def mask_for(net):
    blk={}; vblk={}
    for l in L:
        b=np.zeros((NX,NY),bool); vb=np.zeros((NX,NY),bool)
        for (ll,x1,y1,x2,y2,nn) in rects:
            if ll!=l or nn==net: continue
            for arr,e in ((b,HW[l]+SP[l]),(vb,VP[l]+SP[l])):
                i1=max(0,math.ceil((x1-e-X0)/G-1e-6)); i2=min(NX-1,math.floor((x2+e-X0)/G+1e-6))
                j1=max(0,math.ceil((y1-e-Y0)/G-1e-6)); j2=min(NY-1,math.floor((y2+e-Y0)/G+1e-6))
                # strictly-closer-than: exclude boundary
                arr[i1:i2+1,j1:j2+1]=True
        blk[l]=b; vblk[l]=vb
    return blk,vblk
def route(net):
    blk,vblk=mask_for(net)
    pts=term[net]; tree=set(); segs=[]
    first=pts[0]; tree.add((gx(first[0]),gy(first[1]),0))
    remaining=[p for p in pts[1:]]
    while remaining:
        # route to the closest remaining terminal
        targ={(gx(p[0]),gy(p[1]),0):p for p in remaining}
        tx=np.array([k[0] for k in targ]); ty=np.array([k[1] for k in targ])
        def h(i,j): return int(np.min(np.abs(tx-i)+np.abs(ty-j)))
        openh=[]; g={}; par={}
        for s in tree:
            g[s]=0; heapq.heappush(openh,(h(s[0],s[1]),0,s))
        found=None
        while openh:
            f,c,s=heapq.heappop(openh)
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
                if nc<g.get(n,1e18): g[n]=nc; par[n]=s; heapq.heappush(openh,(nc+h(ni,nj),nc,n))
            n=(i,j,1-l)
            if not vblk['m2'][i,j] and not vblk['m3'][i,j]:
                nc=c+40
                if nc<g.get(n,1e18): g[n]=nc; par[n]=s; heapq.heappush(openh,(nc+h(i,j),nc,n))
        if not found: return None
        path=[found]
        while path[-1] in par and path[-1] not in tree: path.append(par[path[-1]])
        path.reverse(); segs.append(path)
        for s in path: tree.add(s)
        remaining.remove(targ[found])
    return segs
def emit(net,segs):
    for path in segs:
        i=0
        while i<len(path)-1:
            a,b=path[i],path[i+1]
            if a[2]!=b[2]:
                x,y=ux(a[0]),uy(a[1])
                R('via2',x-.15,y-.15,x+.15,y+.15,net); R('m2',x-.195,y-.16,x+.195,y+.16,net); R('m3',x-.175,y-.175,x+.175,y+.175,net)
                i+=1; continue
            d=(b[0]-a[0],b[1]-a[1]); j=i+1
            while j<len(path)-1 and path[j+1][2]==a[2] and (path[j+1][0]-path[j][0],path[j+1][1]-path[j][1])==d: j+=1
            e=path[j]; l=L[a[2]]; hw=HW[l]
            R(l,min(ux(a[0]),ux(e[0]))-hw,min(uy(a[1]),uy(e[1]))-hw,max(ux(a[0]),ux(e[0]))+hw,max(uy(a[1]),uy(e[1]))+hw,net)
            i=j
order=sys.argv[1].split(',') if len(sys.argv)>1 else None
nets=sorted(term,key=lambda n:-len(term[n]))
if order: nets=order+[n for n in nets if n not in order]
base=list(rects); fail=[]
for net in nets:
    if len(term[net])<2: continue
    s=route(net); print("routed",net,s is not None,file=sys.stderr,flush=True)
    if s is None: fail.append(net); print('FAIL',net,file=sys.stderr); continue
    emit(net,s)
# same-net gap fill (avoid notch / spacing violations between same-net shapes)
def fill():
    add=[]
    by={}
    for r in rects:
        if r[0] in ('m2','m3'): by.setdefault((r[0],r[5]),[]).append(r)
    for (l,net),rs in by.items():
        s=SP[l]
        for a,b in itertools.combinations(rs,2):
            ox=min(a[3],b[3])-max(a[1],b[1]); oy=min(a[4],b[4])-max(a[2],b[2])
            if ox>0 and -s<oy<0:  add.append((l,max(a[1],b[1]),min(a[4],b[4]),min(a[3],b[3]),max(a[2],b[2]),net))
            elif oy>0 and -s<ox<0: add.append((l,min(a[3],b[3]),max(a[2],b[2]),max(a[1],b[1]),min(a[4],b[4]),net))
            elif ox<=0 and oy<=0 and ox>-s and oy>-s and not(ox==0 or oy==0):
                add.append((l,min(a[3],b[3]),min(a[4],b[4]),max(a[1],b[1]),max(a[2],b[2]),net))
    for (l,x1,y1,x2,y2,n) in add: R(l,x1,y1,x2,y2,n)
    return len(add)
for _ in range(3):
    if fill()==0: break
print('FAILED:',fail,file=sys.stderr)
# ---------------- Tcl ----------------
lm={'m1':'metal1','m2':'metal2','m3':'metal3','via1':'via1','via2':'via2','mcon':'mcon'}
out=['load comparator','box -50um -50um 200um 200um','select area','erase metal2','erase metal3','erase via1','erase via2','select clear']
f=lambda v:f'{v:.3f}um'
for (l,x1,y1,x2,y2,n) in rects:
    out.append(f'box {f(x1)} {f(y1)} {f(x2)} {f(y2)}'); out.append(f'paint {lm[l]}')
def free_of_m3(x,y,net):
    return not any(r[0]=='m3' and r[5]!=net and r[1]-.05<=x<=r[3]+.05 and r[2]-.05<=y<=r[4]+.05 for r in rects)
for p in ('inp','inn','clk','outp','outn','VDD','VSS'):
    x,y=next(((a,b) for a,b in term[p] if free_of_m3(a,b,p)),term[p][0])
    out+= [f'box {f(x-.05)} {f(y-.05)} {f(x+.05)} {f(y+.05)}', f'label {p} c metal2','port make']
open('wire_comparator.tcl','w').write('\n'.join(out)+'\n')
print('nets',len(nets),'rects',len(rects),file=sys.stderr)
