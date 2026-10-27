Sign-off on the submitted GDS (v4, commit d174e3a), run 2026-10-27 (cloud, same PDK files):
  DRC (flattened GDS, Magic drc(full))          : 0
  Antenna (flattened GDS)                       : 0 violations
  licon spacing/size, licon-urpm (gdschk.py)    : 0 / 0 / 0
  LVS, full chip from GDS, transistor level     : Circuits match uniquely
      (479 SAR-logic standard cells vs verilog/gl/sar_logic.v; analog blocks vs lvs/sch_top.spice)
  PEX netlist sim/adc_core_pex_v4.spice         : identical to a fresh extraction of the pushed layout
      (748 capacitors, 893.163 fF total, max difference 0)
  TT precheck (GitHub, gds workflow)            : green
Re-run: cd mag/gen/signoff && bash signoff.sh   (needs gdstk for gdschk.py)
