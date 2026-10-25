// astar.c -- 3-layer grid A* (multi-source, multi-target) for the top-level router.
// input file: int32 NX NY NL, int32 cost_pref cost_non cost_via, int32 ntb, ntb*4 int32 target bboxes (i0 j0 i1 j1),
//             int32 dirs[NL] (0=vertical pref,1=horizontal pref), then NL*NX*NY uint8 flags
// flags: bit0 wire-blocked, bit1 via-blocked (pad), bit2 target, bit3 source
// output file: int32 n, then n*(l,i,j) from target back to source
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
typedef struct { int32_t f; int32_t n; } HE;
static HE *heap; static long hn=0, hcap=0;
static void push(int32_t f,int32_t n){ if(hn>=hcap){hcap=hcap?hcap*2:1<<20; heap=realloc(heap,hcap*sizeof(HE));}
  long i=hn++; while(i>0){long p=(i-1)/2; if(heap[p].f<=f)break; heap[i]=heap[p]; i=p;} heap[i].f=f; heap[i].n=n;}
static HE pop(void){ HE r=heap[0], x=heap[--hn]; long i=0; for(;;){long c=2*i+1; if(c>=hn)break; if(c+1<hn&&heap[c+1].f<heap[c].f)c++; if(heap[c].f>=x.f)break; heap[i]=heap[c]; i=c;} heap[i]=x; return r;}
int main(int argc,char**argv){
  FILE*f=fopen(argv[1],"rb"); int32_t h[6]; fread(h,4,3,f); int NX=h[0],NY=h[1],NL=h[2];
  fread(h,4,3,f); int cp=h[0],cn=h[1],cv=h[2]; int32_t ntb; fread(&ntb,4,1,f);
  int32_t*tb=malloc(16*(ntb>0?ntb:1)); fread(tb,4,4*ntb,f); int32_t dirs[8]; fread(dirs,4,NL,f);
  long N=(long)NX*NY*NL; uint8_t*fl=malloc(N); fread(fl,1,N,f); fclose(f);
  int32_t*g=malloc(N*4); int32_t*par=malloc(N*4); for(long k=0;k<N;k++){g[k]=0x7fffffff;par[k]=-1;}
  #define IDX(l,i,j) (((long)(l)*NX+(i))*NY+(j))
  int mincost=cp<cn?cp:cn;
  #define HEUR(i,j) ({int best=0x7fffffff; for(int t=0;t<ntb;t++){int dx=(i)<tb[4*t]?tb[4*t]-(i):((i)>tb[4*t+2]?(i)-tb[4*t+2]:0); int dy=(j)<tb[4*t+1]?tb[4*t+1]-(j):((j)>tb[4*t+3]?(j)-tb[4*t+3]:0); int d=dx+dy; if(d<best)best=d;} best*mincost;})
  for(int l=0;l<NL;l++)for(int i=0;i<NX;i++)for(int j=0;j<NY;j++){long k=IDX(l,i,j); if(fl[k]&8){g[k]=0; push(HEUR(i,j),(int32_t)k);}}
  long found=-1, expanded=0;
  while(hn){ HE e=pop(); long k=e.n; int l=k/((long)NX*NY); long r=k%((long)NX*NY); int i=r/NY, j=r%NY;
    if(e.f-HEUR(i,j)>g[k]) continue;
    if(fl[k]&4){found=k;break;}
    expanded++;
    int dx[4]={1,-1,0,0}, dy[4]={0,0,1,-1};
    for(int d=0;d<4;d++){int ni=i+dx[d],nj=j+dy[d]; if(ni<0||nj<0||ni>=NX||nj>=NY)continue; long nk=IDX(l,ni,nj);
      if((fl[nk]&1)&&!(fl[nk]&4))continue;
      int pref=(dirs[l]==0)?(dy[d]!=0):(dx[d]!=0); int nc=g[k]+(pref?cp:cn);
      if(nc<g[nk]){g[nk]=nc;par[nk]=k;push(nc+HEUR(ni,nj),(int32_t)nk);} }
    for(int dl=-1;dl<=1;dl+=2){int nl=l+dl; if(nl<0||nl>=NL)continue; long nk=IDX(nl,i,j);
      if((fl[k]&2)||(fl[nk]&2))continue;
      int nc=g[k]+cv; if(nc<g[nk]){g[nk]=nc;par[nk]=k;push(nc+HEUR(i,j),(int32_t)nk);} }
  }
  FILE*o=fopen(argv[2],"wb"); int32_t n=0;
  if(found<0){fwrite(&n,4,1,o);fclose(o);fprintf(stderr,"nopath expanded=%ld\n",expanded);return 0;}
  long k=found; while(k>=0){n++; if(fl[k]&8)break; k=par[k];}
  fwrite(&n,4,1,o); k=found;
  for(int c=0;c<n;c++){int32_t l=k/((long)NX*NY); long r=k%((long)NX*NY); int32_t v[3]={l,(int32_t)(r/NY),(int32_t)(r%NY)}; fwrite(v,4,3,o); k=par[k];}
  fclose(o); fprintf(stderr,"path n=%d cost=%d expanded=%ld\n",n,g[found],expanded); return 0;
}
