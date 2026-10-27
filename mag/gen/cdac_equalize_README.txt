CDAC v4 parasitic equalisation (applied to the v2/v3 notched cdac.mag):
- restore_sel.txt : notches refilled with metal3 (b6: 8, b2: 2)  [(i,j,(x1,y1,x2,y2)) in cdac-local um]
- strips_sel.txt  : 1.4 um metal3 strips under the vtop strap inside notches (b5: 5, b4: 14)
Each added one at a time and kept only if flattened DRC stayed 0 (met3.3c large-metal rule).
Result (vtop-to-bottom-plate parasitic per unit cap): b7 0.686, b6 0.687, b5 0.686, b4 0.689, b3 0.699, b2 0.712 fF
Predicted static parasitic error: DNL +0.022/-0.030 LSB, INL 0.04 LSB (was DNL +0.47, INL 0.28).
