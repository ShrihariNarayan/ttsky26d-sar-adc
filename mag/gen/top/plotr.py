import json,sys,matplotlib; matplotlib.use('Agg'); import matplotlib.pyplot as plt
import gdstk
from matplotlib.collections import PolyCollection
xl=[float(v) for v in sys.argv[1].split(',')]; out=sys.argv[2]
c=gdstk.read_gds('../ana_flat.gds').top_level()[0]
fig,ax=plt.subplots(figsize=(12,12*(xl[3]-xl[2])/(xl[1]-xl[0])))
P={}
for p in c.polygons: P.setdefault((p.layer,p.datatype),[]).append(p.points)
for k,col in [((69,20),'#f0c0f0'),((70,20),'#c0f0f0'),((71,20),'#c0e0c0'),((89,44),'#dddddd')]:
    ax.add_collection(PolyCollection(P.get(k,[]),facecolor=col,edgecolor='none',alpha=.6))
col={'m2':'magenta','m3':'darkcyan','m4':'green','via2':'k','via3':'k','via1':'k','m1':'b'}
for s in json.load(open('routes.json')):
    l,x1,y1,x2,y2,n=s; ax.add_patch(plt.Rectangle((x1,y1),x2-x1,y2-y1,color=col.get(l,'r'),alpha=.7 if l[0]=='m' else 1))
for s in json.load(open('routes.json')):
    l,x1,y1,x2,y2,n=s
    if l in('m3','m4','m2') and max(x2-x1,y2-y1)>6 and xl[0]<x1<xl[1] and xl[2]<y1<xl[3]: ax.text((x1+x2)/2,(y1+y2)/2,n,fontsize=6,color='r')
ax.add_patch(plt.Rectangle((75,148),70,70,fill=False,ec='k'))
ax.set_xlim(xl[0],xl[1]); ax.set_ylim(xl[2],xl[3]); ax.set_aspect('equal'); ax.grid(alpha=.3)
plt.savefig(out,dpi=100,bbox_inches='tight')
