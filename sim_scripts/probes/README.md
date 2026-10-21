# Probe scripts (archived 2026-10-21)
- `np.ctl`: noise-estimate probe. Appended to the comparator testbench netlist, it measures the amplification time `tp` (clk → P = 0.5 V) and tail voltage `vt`. Run with and without +10 fF on P/Q to get C_PQ ≈ 10 fF·t0/(t1−t0) (~19–26 fF). Noise from Razavi eq. 15 came out at ≈ 0.7–1.0 mV rms.
- `probe.ctl`: A/B probe used to find the standalone-script pin-order bug. It samples y, x, T, ckb and clk at fixed times.
- `corner_id.spice`: raw PMOS/NMOS drive per corner at −40 °C (W=1, L=0.15, |Vgs|=1.0, |Vds|=0.5). It showed that in this PDK install `sf` behaves as **slow PMOS / fast NMOS**, despite the header saying "Slow N / Fast P".
  - tt: P 9.2 µA, N 39.1 µA
  - ss: P 6.4, N 22.4
  - sf: P 6.3, N 65.2
  - fs: P 15.0, N 18.6
  - ff: P 13.7, N 60.7
