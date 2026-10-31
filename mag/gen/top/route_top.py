# route_top.py -- top-level router for tt_um_shriharinarayan_sar_adc (m2/m3/m4 grid A*, C core)
import gdstk, numpy as np, math, struct, subprocess, sys, itertools, json, re
G=0.05; TW,TH=161.0,225.76
NX=int(round(TW/G))+1; NY=int(round(TH/G))+1
LAY=['m2','m3','m4']; DIRS=[0,1,0]            # m2 vertical, m3 horizontal, m4 vertical
GDSL={(67,20):'li',(67,44):'mcon',(68,20):'m1',(68,44):'via1',(69,20):'m2',(69,44):'via2',(70,20):'m3',(70,44):'via3',(71,20):'m4',(89,44):'capm'}
CONN={'mcon':('li','m1'),'via1':('m1','m2'),'via2':('m2','m3'),'via3':('m3','m4'),'via3c':('capm','m4')}
SP={'m2':.14,'m3':.3,'m4':.3}
SIG={'m2':.1,'m3':.15,'m4':.15}          # signal half widths
PWR={'m2':.4,'m3':.4,'m4':.4}            # power half widths
VPAD={'m2':.195,'m3':.25,'m4':.25}       # signal via pad half sizes (max over via2/via3)
shapes=[]   # (layer,x1,y1,x2,y2,net)
def S(l,x1,y1,x2,y2,net,gid=None): shapes.append((l,min(x1,x2),min(y1,y2),max(x1,x2),max(y1,y2),net,gid))
# ---------------- analog blocks (flattened GDS) + connectivity ----------------
lib=gdstk.read_gds('../ana_flat.gds'); top=lib.top_level()[0]
raw=[]
for p in top.polygons:
    k=(p.layer,p.datatype)
    if k not in GDSL: continue
    (x1,y1),(x2,y2)=p.bounding_box(); raw.append([GDSL[k],x1,y1,x2,y2])
def touch(a,b): return a[1]<=b[3] and b[1]<=a[3] and a[2]<=b[4] and b[2]<=a[4]
par=list(range(len(raw)))
def find(a):
    while par[a]!=a: par[a]=par[par[a]]; a=par[a]
    return a
def union(a,b):
    a,b=find(a),find(b)
    if a!=b: par[a]=b
caps=[r for r in raw if r[0]=='capm']
for r in raw:
    if r[0]=='via3' and any(touch(r,c) for c in caps if abs(c[1]-r[1])<40): r[0]='via3c'
B=2.0; buck={}
for idx,(l,x1,y1,x2,y2) in enumerate(raw):
    for bi in range(int(x1//B),int(x2//B)+1):
        for bj in range(int(y1//B),int(y2//B)+1): buck.setdefault((bi,bj),[]).append(idx)
def related(la,lb):
    if la==lb: return la not in ('capm',)
    for v,ls in CONN.items():
        if (la==v and lb in ls) or (lb==v and la in ls): return True
    return False
for lst in buck.values():
    for a,b in itertools.combinations(lst,2):
        if related(raw[a][0],raw[b][0]) and touch(raw[a],raw[b]): union(a,b)
# label points -> nets
OFF={'cdac':(77.2,48.5),'bootstrap_switch':(128.26,9.0),'decap':(80.0,9.0),'vcm_gen':(10.0,9.0),'comparator':(45.0,75.0),'decap2':(8.5,100.0)}
NETMAP={'comparator':{'inp':'vtop','inn':'vcm','outp':'comp','outn':'compn','VDD':'VDD','VSS':'VSS','clk':'clk'},
        'cdac':{**{f'dn{k}':f'dn{k}' for k in range(8)},'Vref':'Vref','VSS':'VSS','vtop':'vtop','VDD':'VDD'},
        'bootstrap_switch':{'phi':'phi','vin':'vin','vout':'vtop','VDD':'VDD','VSS':'VSS'},
        'vcm_gen':{'vcm':'vcm','Vref':'Vref','VSS':'VSS'},'decap':{'Vref':'Vref','VSS':'VSS'},'decap2':{'Vref':'Vref','VSS':'VSS','vcm':'vcm','VSSB':'VSS'}}
LMAP={'metal1':'m1','metal2':'m2','metal3':'m3','metal4':'m4','via1':'via1','via2':'via2'}
compnet={}
for c,(ox,oy) in OFF.items():
    for ln in open(f'../{c}.mag'):
        t=ln.split()
        if not t or t[0]!='rlabel' or t[-1] not in NETMAP[c]: continue
        net=NETMAP[c][t[-1]]; x=ox+(int(t[2])+int(t[4]))/400; y=oy+(int(t[3])+int(t[5]))/400
        LL={'metal1':('m1',),'metal2':('m2',),'via1':('m2',),'via2':('m2','m3'),'metal4':('m4',)}[t[1]]
        hits=[i for i,r in enumerate(raw) if r[0] in LL and r[1]-1e-3<=x<=r[3]+1e-3 and r[2]-1e-3<=y<=r[4]+1e-3]
        if not hits: print('NO SHAPE for',c,t[-1],file=sys.stderr); continue
        for h in hits:
            r=find(h)
            if compnet.get(r,net)!=net: print('CONFLICT',c,t[-1],compnet[r],file=sys.stderr)
            compnet[r]=net
for i,r in enumerate(raw):
    S(r[0].replace('via3c','via3'),r[1],r[2],r[3],r[4],compnet.get(find(i),f'_a{find(i)}'),('a',find(i)) if find(i) in compnet else None)
# decap Vref: m1 spine only -> via1 + m2 tabs (net Vref)
EXTRA=[]
def via1(x,y,net): EXTRA.append(('via1',x-.13,y-.13,x+.13,y+.13)); S('m2',x-.13,y-.16,x+.13,y+.16,net,'dVref'); S('m1',x-.13,y-.16,x+.13,y+.16,net)
for yv in (29.05,40.0): via1(80.0+43.88,yv,'Vref'); S('m2',80.0+43.75,yv-.16,80.0+44.6,yv+.16,'Vref','dVref'); EXTRA.append(('m2',80.0+43.75,yv-.16,80.0+44.6,yv+.16))
# ---------------- sar_logic ----------------
LX,LY=75.0,148.0
lg=gdstk.read_gds('../sar_logic.gds').top_level()[0]
lef=open('/mnt/user-data/uploads/ttsky26d-sar-adc/lef/sar_logic.lef').read()
lpins={}
for m in re.finditer(r'PIN (\S+)\n(.*?)END \1',lef,re.S):
    r=re.search(r'LAYER met2 ;\s*RECT ([\d.]+) ([\d.]+) ([\d.]+) ([\d.]+)',m.group(2))
    if r: lpins[m.group(1)]=[float(v) for v in r.groups()]
LNET={'comp':'comp','phi':'phi','clk':'clk','rst_n':'rst_n','done':'done',**{f'dn[{k}]':f'dn{k}' for k in range(8)},**{f'code[{k}]':f'code{k}' for k in range(8)}}
for pn,(a,b,c2,d) in lpins.items(): S('m2',LX+a,LY+b,LX+c2,LY+d,LNET[pn],('lp',pn))
for p in lg.get_polygons():
    k=(p.layer,p.datatype)
    if k not in ((69,20),(70,20),(71,20)): continue
    (x1,y1),(x2,y2)=p.bounding_box(); l=GDSL[k]
    own=None
    if l=='m2':
        for pn,(a,b,c2,d) in lpins.items():
            if touch(('',x1,y1,x2,y2),('',a,b,c2,d)): own=LNET[pn]
    S(l,LX+x1,LY+y1,LX+x2,LY+y2,own or 'LOGIC')
for l in ('m3','m4'): S(l,LX,LY,LX+70,LY+70,'LOGIC')
S('m2',LX,LY+2.1,LX+70,LY+67.9,'LOGIC')
# logic power stripes extended down out of the block (m4)
for (x1,x2,net) in ((18.28,19.88,'VDD'),(21.58,23.18,'VSS')):
    S('m4',LX+x1,141.0,LX+x2,LY+2.48+1.0,net,('ext',net)); EXTRA.append(('m4',LX+x1,141.0,LX+x2,LY+2.48+1.0))
# ---------------- tile pins / stripes ----------------
TOP={'clk':143.98,'rst_n':141.22,'uio_out[0]':72.22,**{f'uo_out[{k}]':94.30-2.76*k for k in range(8)}}
TOP.update({f'uio_out[{k}]':72.22-2.76*k for k in range(1,8)}); TOP.update({f'uio_oe[{k}]':50.14-2.76*k for k in range(8)})
TNET={'clk':'clk','rst_n':'rst_n','uio_out[0]':'done',**{f'uo_out[{k}]':f'code{k}' for k in range(8)},**{f'uio_out[{k}]':'VSS' for k in range(1,8)},**{f'uio_oe[{k}]':'VSS' for k in range(1,8)},'uio_oe[0]':'VDD'}
for pn,x in TOP.items(): S('m4',x-.3,223.6,x+.3,225.76,TNET[pn],('tp',pn)); EXTRA.append(('m4',x-.3,223.6,x+.3,225.76))
ALLTOP=[3.067+2.76*0]  # other top pins: obstacles
for k in range(43):
    x=30.67+2.76*k+0.15
    if all(abs(x-v)>.5 for v in TOP.values()) and x<150: S('m4',x-.15,224.76,x+.15,225.76,'_tp%d'%k)
S('m4',152.26-.45,0,152.26+.45,1.0,'vin','ua0'); S('m4',132.94-.45,0,132.94+.45,1.0,'Vref','ua1')
for k,x in enumerate((113.62,94.30,74.98,55.66,36.34,17.02)): S('m4',x-.45,0,x+.45,1.0,'_ua%d'%(k+2))
S('m4',1,5,3,220.76,'VDD','VDPWR'); S('m4',4,5,6,220.76,'VSS','VGND')
S('m2',75.4,47.9,142.8,112.5,'BLK'); S('m2',140,47.9,145.0,112.5,'BLK'); S('m3',140,47.9,145.0,112.5,'BLK')   # keep foreign m2 off the CDAC array
# ---------------- rasterisation ----------------
def rng(x1,x2,e,N):
    i1=max(0,math.ceil((x1-e)/G-1e-6)); i2=min(N-1,math.floor((x2+e)/G+1e-6)); return i1,i2
def spf(s,l):
    return .4 if l in ('m3','m4') and min(s[3]-s[1],s[4]-s[2])>3.0 else SP[l]
def blockers(l,vias=False):   # shapes that block layer l, with their spacing
    out=[]
    for s in shapes:
        if s[0]==l: out.append((s,spf(s,l)))
        elif vias and ((s[0]=='via2' and l in ('m2','m3')) or (s[0]=='via3' and l in ('m3','m4'))): out.append((s,.12))
        elif s[0]=='capm':
            if l=='m3': out.append((s,1.34))
            if l=='m4': out.append((s,.3))
    return out
def count_map(l,e_extra,flt=None,vias=False):
    D=np.zeros((NX+1,NY+1),np.int32)
    for (s,sp) in blockers(l,vias):
        if flt and not flt(s): continue
        i1,i2=rng(s[1],s[3],sp+e_extra,NX); j1,j2=rng(s[2],s[4],sp+e_extra,NY)
        if i1>i2 or j1>j2: continue
        D[i1,j1]+=1; D[i2+1,j1]-=1; D[i1,j2+1]-=1; D[i2+1,j2+1]+=1
    return D.cumsum(0).cumsum(1)[:NX,:NY]
CM={}
def maps(cls):
    if cls not in CM:
        hw=SIG if cls=='sig' else PWR; vp=VPAD if cls=='sig' else PWR
        CM[cls]={l:(count_map(l,hw[l]),count_map(l,vp[l],vias=True)) for l in LAY}
    return CM[cls]
def add_to_maps(s):
    for cls,m in CM.items():
        hw=SIG if cls=='sig' else PWR; vp=VPAD if cls=='sig' else PWR
        if s[0] not in LAY: continue
        for k,e in ((0,hw[s[0]]),(1,vp[s[0]])):
            i1,i2=rng(s[1],s[3],spf(s,s[0])+e,NX); j1,j2=rng(s[2],s[4],spf(s,s[0])+e,NY)
            m[s[0]][k][i1:i2+1,j1:j2+1]+=1
# ---------------- routing ----------------
POWER={'VDD','VSS'}
def own_count(net,l,e,win):
    i0,j0,i1,j1=win; A=np.zeros((i1-i0+1,j1-j0+1),np.int32)
    for s in shapes:
        if s[5]!=net or s[0]!=l: continue
        a1,a2=rng(s[1],s[3],spf(s,l)+e,NX); b1,b2=rng(s[2],s[4],spf(s,l)+e,NY)
        a1=max(a1,i0); a2=min(a2,i1); b1=max(b1,j0); b2=min(b2,j1)
        if a1<=a2 and b1<=b2: A[a1-i0:a2-i0+1,b1-j0:b2-j0+1]+=1
    return A
def inside_pts(rects,win,hw=0.0):
    i0,j0,i1,j1=win; M=np.zeros((i1-i0+1,j1-j0+1),bool)
    for (x1,y1,x2,y2) in rects:
        ix=min(hw,max(0,(x2-x1)/2-G)); iy=min(hw,max(0,(y2-y1)/2-G)); x1+=ix; x2-=ix; y1+=iy; y2-=iy
        a1=max(i0,math.ceil(x1/G-1e-6)); a2=min(i1,math.floor(x2/G+1e-6)); b1=max(j0,math.ceil(y1/G-1e-6)); b2=min(j1,math.floor(y2/G+1e-6))
        if a1<=a2 and b1<=b2: M[a1-i0:a2-i0+1,b1-j0:b2-j0+1]=True
    return M
newshapes=[]
def emit_rect(l,x1,y1,x2,y2,net):
    s=(l,min(x1,x2),min(y1,y2),max(x1,x2),max(y1,y2),net,None); shapes.append(s); newshapes.append(s); add_to_maps(s)
def emit_via(kind,x,y,net,pw):
    if kind=='via2':
        if pw: h=.4; emit_rect('m2',x-h,y-h,x+h,y+h,net); emit_rect('m3',x-h,y-h,x+h,y+h,net); newshapes.append(('via2',x-.3,y-.3,x+.3,y+.3,net))
        else: emit_rect('m2',x-.195,y-.16,x+.195,y+.16,net); emit_rect('m3',x-.175,y-.175,x+.175,y+.175,net); newshapes.append(('via2',x-.15,y-.15,x+.15,y+.15,net))
    else:
        if pw: h=.4; emit_rect('m3',x-h,y-h,x+h,y+h,net); emit_rect('m4',x-h,y-h,x+h,y+h,net); newshapes.append(('via3',x-.3,y-.3,x+.3,y+.3,net))
        else: emit_rect('m3',x-.25,y-.25,x+.25,y+.25,net); emit_rect('m4',x-.25,y-.25,x+.25,y+.25,net); newshapes.append(('via3',x-.16,y-.16,x+.16,y+.16,net))
# per-net keep-outs: vtop and vcm may not cross the comparator; each enters only through a
# narrow vertical m2 corridor straight down onto its own input pin (comparator bbox 44.74..72.55 x 74.74..97.85)
CMPBOX=(44.74,74.74,72.55,97.85)
NETKO={'vtop':[('all',)+CMPBOX,('open_m2',51.85,88.9,52.65,99.0)],
       'vcm' :[('all',)+CMPBOX,('open_m2',56.15,88.9,56.95,99.0)]}
def ko_mask(net,l,win):
    i0,j0,i1,j1=win; M=np.zeros((i1-i0+1,j1-j0+1),bool)
    for k in NETKO.get(net,[]):
        kind,x1,y1,x2,y2=k
        a1=max(i0,int(x1/G)); a2=min(i1,int(x2/G)+1); b1=max(j0,int(y1/G)); b2=min(j1,int(y2/G)+1)
        if a1>a2 or b1>b2: continue
        if kind=='all': M[a1-i0:a2-i0+1,b1-j0:b2-j0+1]=True
        elif kind=='open_m2' and l=='m2': M[a1-i0:a2-i0+1,b1-j0:b2-j0+1]=False
    return M
def route_net(net,groups,margin=25.0):
    """groups: list of lists of (layer, rect) terminal shapes; connects all groups into one tree"""
    cls='pwr' if net in POWER else 'sig'; hw=PWR if cls=='pwr' else SIG
    mp=maps(cls)
    tree=[groups[0]]; rem=groups[1:]; ok=True
    while rem:
        allr=[r for g in tree+rem for (_,r) in g]
        x1=min(r[0] for r in allr)-margin; y1=min(r[1] for r in allr)-margin; x2=max(r[2] for r in allr)+margin; y2=max(r[3] for r in allr)+margin
        win=(max(0,int(x1/G)),max(0,int(y1/G)),min(NX-1,int(x2/G)),min(NY-1,int(y2/G)))
        i0,j0,i1,j1=win; W,H=i1-i0+1,j1-j0+1
        fl=np.zeros((3,W,H),np.uint8)
        for li,l in enumerate(LAY):
            wb=(mp[l][0][i0:i1+1,j0:j1+1]-own_count(net,l,hw[l],win))>0
            vb=(mp[l][1][i0:i1+1,j0:j1+1]-own_count(net,l,(PWR if cls=='pwr' else VPAD)[l],win))>0
            # tile border
            e=int(math.ceil((hw[l]+.2)/G)); wb[:max(0,e-i0),:]=True; wb[max(0,NX-e-i0):,:]=True; wb[:,:max(0,e-j0)]=True; wb[:,max(0,NY-e-j0):]=True
            K=ko_mask(net,l,win); wb=wb|K; vb=vb|K
            fl[li]=wb.astype(np.uint8)|(vb.astype(np.uint8)<<1)
            fl[li]|=((inside_pts([r for g in tree for (ll,r) in g if ll==l],win,hw[l])&~wb).astype(np.uint8)<<3)
        tmask=[]
        for gi,g in enumerate(rem):
            for li,l in enumerate(LAY):
                m=inside_pts([r for (ll,r) in g if ll==l],win,hw[l])&~(fl[li]&1).astype(bool)
                fl[li]|=(m.astype(np.uint8)<<2)
        tbs=[]
        for g in rem:
            xs=[r for (_,r) in g]
            tbs.append((max(0,int(min(r[0] for r in xs)/G)-i0),max(0,int(min(r[1] for r in xs)/G)-j0),min(W-1,int(max(r[2] for r in xs)/G)-i0),min(H-1,int(max(r[3] for r in xs)/G)-j0)))
        if not (fl&8).any(): print('  no source pts',net,file=sys.stderr); return False
        if not (fl&4).any(): print('  no target pts',net,[g[0] for g in rem],file=sys.stderr); return False
        with open('/tmp/route_rin.bin','wb') as f:
            f.write(struct.pack('7i',W,H,3,2,6,60,len(tbs)))
            for t in tbs: f.write(struct.pack('4i',*t))
            f.write(struct.pack('3i',*DIRS)); f.write(np.ascontiguousarray(fl).tobytes())
        r=subprocess.run(['./astar','/tmp/route_rin.bin','/tmp/route_rout.bin'],capture_output=True,text=True)
        print('  ',net,r.stderr.strip(),file=sys.stderr,flush=True)
        d=open('/tmp/route_rout.bin','rb').read(); n=struct.unpack('i',d[:4])[0]
        if n==0: return False
        path=np.frombuffer(d[4:],np.int32).reshape(n,3); path=[(int(l),int(i)+i0,int(j)+j0) for l,i,j in path]
        # which group was reached?
        el,ei,ej=path[0]; reached=None
        for gi,g in enumerate(rem):
            if any(ll==LAY[el] and r[0]-1e-6<=ei*G<=r[2]+1e-6 and r[1]-1e-6<=ej*G<=r[3]+1e-6 for (ll,r) in g): reached=gi; break
        newg=[]
        # emit path
        k=0; pw=(cls=='pwr')
        while k<len(path)-1:
            a,b=path[k],path[k+1]
            if a[0]!=b[0]:
                lo=min(a[0],b[0]); emit_via('via2' if lo==0 else 'via3',a[1]*G,a[2]*G,net,pw); k+=1; continue
            d=(b[1]-a[1],b[2]-a[2]); m=k+1
            while m<len(path)-1 and path[m+1][0]==a[0] and (path[m+1][1]-path[m][1],path[m+1][2]-path[m][2])==d: m+=1
            e=path[m]; l=LAY[a[0]]; h=hw[l]
            emit_rect(l,min(a[1],e[1])*G-h,min(a[2],e[2])*G-h,max(a[1],e[1])*G+h,max(a[2],e[2])*G+h,net); k=m
        for s in newshapes[-200:]:
            if s[5]==net and s[0] in LAY: newg.append((s[0],(s[1],s[2],s[3],s[4])))
        if reached is None: print('  ?? reached unknown',file=sys.stderr); reached=0
        tree.append(rem.pop(reached)+newg)
    return True

def groups_of(net):
    g={}
    for s in shapes:
        if s[5]==net and s[6] is not None and s[0] in LAY: g.setdefault(s[6],[]).append((s[0],(s[1],s[2],s[3],s[4])))
    return list(g.values())
if __name__=='__main__':
    order=sys.argv[1].split(',')
    res={}
    for net in order:
        gs=groups_of(net)
        print(net,'groups',len(gs),[len(g) for g in gs],file=sys.stderr,flush=True)
        if len(gs)<2: continue
        # start from the biggest group? start from the first analog group
        res[net]=route_net(net,gs)
    print('RESULT',res,file=sys.stderr)
    # same-net gap fill (magic spacing rules are net-agnostic)
    for it in range(3):
        add=[]
        for a in [s for s in newshapes if s[0] in LAY]:
            sp=SP[a[0]]+.1
            for b in shapes:
                if b is a or b[0]!=a[0] or b[5]!=a[5]: continue
                if b[1]>a[3]+sp or a[1]>b[3]+sp or b[2]>a[4]+sp or a[2]>b[4]+sp: continue
                ox=min(a[3],b[3])-max(a[1],b[1]); oy=min(a[4],b[4])-max(a[2],b[2])
                if ox>=0 and oy>=0: continue
                if ox>0: r=(max(a[1],b[1]),min(a[4],b[4]),min(a[3],b[3]),max(a[2],b[2]))
                elif oy>0: r=(min(a[3],b[3]),max(a[2],b[2]),max(a[1],b[1]),min(a[4],b[4]))
                else: r=(min(a[3],b[3]),min(a[4],b[4]),max(a[1],b[1]),max(a[2],b[2]))
                x1,y1,x2,y2=min(r[0],r[2]),min(r[1],r[3]),max(r[0],r[2]),max(r[1],r[3])
                w=SP[a[0]]  # make bridge at least min width
                if x2-x1<w: c=(x1+x2)/2; x1,x2=c-w/2,c+w/2
                if y2-y1<w: c=(y1+y2)/2; y1,y2=c-w/2,c+w/2
                add.append((a[0],x1,y1,x2,y2,a[5]))
        print('fill',it,len(add),file=sys.stderr)
        if not add: break
        for r in add: emit_rect(*r)
    json.dump([list(s[:6]) for s in newshapes]+[[*e,'x'] for e in EXTRA],open('routes.json','w'))
