# cdac_place.py -- phase 1: write Tcl that draws the 16x16 unit-cap array (custom cells, flat) + places the 16 driver pcells
P=4.0                     # cap pitch (um); cap centre (2+4i, 2+4j)
H=1.0                     # half mimcap (2.0 um unit)
def grp(i,j):
    if i<=3 or i>=12: return 'C7'
    if i in (4,5,10,11): return 'C6'
    if j<=3 or j>=12: return 'C5'
    if j in (4,5,10,11): return 'C4'
    if j in (6,9): return 'C3'
    if i in (6,7): return 'C2'
    if i==8: return 'C1'
    return 'C0' if j==7 else 'Cdmy'
blocks={'C7':[(0,3,0,15),(12,15,0,15)],'C6':[(4,5,0,15),(10,11,0,15)],'C5':[(6,9,0,3),(6,9,12,15)],
        'C4':[(6,9,4,5),(6,9,10,11)],'C3':[(6,9,6,6),(6,9,9,9)],'C2':[(6,7,7,8)],'C1':[(8,8,7,8)],'C0':[(9,9,7,7)],'Cdmy':[(9,9,8,8)]}
c=lambda k:2+P*k
out=['load cdac','box -100um -100um 200um 200um','select area','delete','erase *','select clear']
def rect(l,x1,y1,x2,y2): out.extend([f'box {x1:.3f}um {y1:.3f}um {x2:.3f}um {y2:.3f}um',f'paint {l}'])
# bottom plates (met3) per block, with small side extensions for C0 (right) and Cdmy (left) to host a via2
for g,bl in blocks.items():
    for (i1,i2,j1,j2) in bl:
        x1,x2,y1,y2=c(i1)-H-.14,c(i2)+H+.14,c(j1)-H-.14,c(j2)+H+.14
        if g=='C0': x2=c(i2)+H+.62
        if g=='Cdmy': x1=c(i1)-H-.62
        rect('metal3',x1,y1,x2,y2)
# caps: mimcap 2x2 + contact 1.6x1.6 (+met4)
for i in range(16):
    for j in range(16):
        rect('mimcap',c(i)-H,c(j)-H,c(i)+H,c(j)+H)
        rect('mimcc',c(i)-.8,c(j)-.8,c(i)+.8,c(j)+.8)
        rect('metal4',c(i)-.805,c(j)-.805,c(i)+.805,c(j)+.805)
# vtop: met4 row straps + two edge verticals
for j in range(16): rect('metal4',-1.6,c(j)-.3,65.6,c(j)+.3)
rect('metal4',-1.6,-.6,-1.0,62.3); rect('metal4',65.0,-.6,65.6,62.3)
open('cdac_array.tcl','w').write('\n'.join(out)+'\n')
print(sum(len(b) for b in blocks.values()),'blocks')
# sanity: counts
from collections import Counter
print(Counter(grp(i,j) for i in range(16) for j in range(16)))
