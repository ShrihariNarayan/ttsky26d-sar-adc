# gdschk.py GDS -- checks the two precheck failures directly on the GDS:
#  licon (66/44) cut-to-cut spacing >= 0.17 (distinct cuts) and size 0.17x0.17 (or bars),
#  no licon square interacting with urpm (79/20)
import gdstk,sys,itertools
lib=gdstk.read_gds(sys.argv[1]); c=lib.top_level()[0]
L=[];U=[]
for p in c.get_polygons():
    (x1,y1),(x2,y2)=p.bounding_box(); r=(round(x1,3),round(y1,3),round(x2,3),round(y2,3))
    if (p.layer,p.datatype)==(66,44): L.append(r)
    if (p.layer,p.datatype)==(79,20): U.append(r)
L=sorted(set(L)); bad_sp=0; bad_sz=0
for r in L:
    w,h=r[2]-r[0],r[3]-r[1]
    if min(w,h)<0.169: bad_sz+=1
B={}
for i,r in enumerate(L): B.setdefault((int(r[0]//2),int(r[1]//2)),[]).append(i)
for (bx,by),lst in B.items():
    nb=[j for dx in (-1,0,1) for dy in (-1,0,1) for j in B.get((bx+dx,by+dy),[])]
    for i in lst:
        a=L[i]
        for j in nb:
            if j<=i: continue
            b=L[j]; dx=max(b[0]-a[2],a[0]-b[2]); dy=max(b[1]-a[3],a[1]-b[3])
            if dx<0 and dy<0: bad_sp+=1   # partial overlap of two different cuts
            elif max(dx,dy)<0.1695 and not (dx>=0 and dy>=0 and (dx**2+dy**2)**.5>=0.1695): bad_sp+=1
sq_urpm=sum(1 for r in L if abs((r[2]-r[0])-(r[3]-r[1]))<1e-3 and any(r[0]<=u[2] and u[0]<=r[2] and r[1]<=u[3] and u[1]<=r[3] for u in U))
print(f"{sys.argv[1]}: licon {len(L)} | size<0.17: {bad_sz} | spacing/overlap: {bad_sp} | square licon touching urpm: {sq_urpm} (urpm shapes {len(U)})")
