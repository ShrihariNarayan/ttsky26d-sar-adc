# Monte Carlo comparator-offset scripts (archived 2026-10-21)

Run from `xschem/simulation/` (they `.include` the PDK by absolute path and the comparator
subcircuit by relative path; copy the files back there to rerun).

## Files
- `mc_offset.spice`: the base script. It uses `tt_mm` (MC_MM_SWITCH=1), `setseed 8`, and `reset` per chip in a `dowhile` loop. Each chip and CM value gets a 12-step bisection on the input difference. It prints `run N cm C off_mV X`.
  Loop state lives in `set` variables, with `destroy all` after every tran.
- `comp_sub.spice`: the comparator subckt, extracted from the testbench netlist (sim-mode, with ad/as).
- `sub_<V>.spice`: sizing variants, made by sed from `comp_sub.spice`. `mc_<V>.spice` is the matching run script (±50 mV window, 13 steps). `mc_<V>.txt` holds the raw results.
- **Pin-order trap:** the `x1` instance must follow the `.subckt` line of the netlist actually used, which follows the *symbol* (`inp VDD inn clk VSS X Y`), not the LVS netlist.

## Variants and results (20 chips each)
| Set | Architecture / CM | Change | Result |
|---|---|---|---|
| V0 | old, CM 0/0.6/1.0 | LVT W=8 as built | σ 34 / 11.5 / 7.3 mV, CM spread avg 28 mV |
| V1 | old | latch M3–M6 4× area | no change |
| V2 | old | weak tail M7 1/0.5 | worse at CM 0 |
| V3 | old | V1 + V2 | worse |
| E1 | old | reset switches S1–S4 16× (2/0.6) | CM-0 σ 34 → 21 |
| E2 | old | input pair 4× (16/1) | CM-1.0 σ 7.3 → 3.8 |
| E3 | old | everything enlarged | CM-0 σ still 24 mV, which means the problem is the architecture |
| S0 | new fixed-Vcm, CM 0.4/0.5/0.6 | std-Vt input W=8/L=0.5 | σ 5.0 / 4.6 / 4.4 mV |
| **S1** | new | S0 + reset switches 2/0.6 (**ADOPTED**) | σ 4.6 / 4.4 / 4.3 mV, spread 0.85 mV |
| S2 | new | S1 + input 16/1 | σ 2.5 / 2.3 / 2.2 mV (rejected: 4× gate C on the top plate) |

## Summary one-liner
```
awk '/^run/{r=$2;c=$4;o=$6;n[c]++;s[c]+=o;q[c]+=o*o;if(o>49.9||o<-49.9)p[c]++;if(!(r in mx)||o>mx[r])mx[r]=o;if(!(r in mn)||o<mn[r])mn[r]=o} END{for(c in n){m=s[c]/n[c];printf "CM %-4s sigma %6.2f mV  mean %6.2f  pinned %d\n",c,sqrt(q[c]/n[c]-m*m),m,p[c]+0}; for(r in mx){d=mx[r]-mn[r];sd+=d;if(d>dmax)dmax=d;k++}; printf "CM spread per chip: avg %.2f mV  max %.2f mV\n",sd/k,dmax}' mc_S1.txt
```
