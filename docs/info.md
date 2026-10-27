<!---
This file is used to generate your project datasheet.
-->

## How it works

An **8-bit charge-redistribution SAR ADC** with a bootstrapped sample-and-hold. The design is fully custom analog plus a small hardened digital block, in a 1×2 analog tile.

- **Sampling (top-plate).** A bootstrapped NMOS switch, whose gate is lifted to about Vin + VDD by a 0.5 pF MiM boost capacitor, samples the input from `ua[0]` onto the top plate (`vtop`) of the capacitor DAC. Meanwhile the DAC's bottom plates sit at mid-scale.
- **Capacitor DAC.** 256 unit MiM capacitors (2 µm × 2 µm, about 2.44 pF in total) in a 16 × 16 symmetric grouped array, binary-weighted 128/64/…/1 plus one dummy. The bottom plates switch between `Vref` (`ua[1]`) and ground through 16 drivers. The metal-3 bottom-plate sheets under the top-plate straps are notched and equalised, so every bit group sees the same parasitic per unit capacitor.
- **Comparator.** A StrongARM latch with a PMOS input pair followed by an SR latch. It compares `vtop` against a fixed common-mode voltage `Vcm = Vref/2`, made by an on-chip resistor divider (2 × 51 kΩ high-resistance poly) filtered by about 7.4 pF of MiM capacitance.
- **SAR logic.** A Verilog state machine hardened with LibreLane (70 × 70 µm, sky130_fd_sc_hd). It decides one bit per clock. The comparator evaluates on the rising edge of `clk`; the logic acts on the falling edge.
- **Vref decoupling.** About 35 pF of on-chip MOS decoupling capacitance on `Vref`. It keeps the reference stiff against DAC switching and comparator kickback.

One conversion takes **10 clock cycles**: 1 sample, 8 bit decisions, then 1 output cycle with `done` high. At `clk` = 10 MHz this is 1 MS/s. `uo_out[7:0]` holds the result of the last completed conversion and updates when `done` rises.

The design is single-ended because the tile has two analog pins (Vin and Vref). The sample rate is set conservatively by the shuttle's clock and I/O limits rather than by the analog core.

### Simulated performance

All numbers are from ngspice simulation (Gear integration), with Vref = 1.0 V and a 500 Ω pad model on each analog pin. **Post-layout** means the full tile's extracted netlist (parasitic capacitances included). They are not silicon measurements.

| | Schematic | Post-layout |
|---|---|---|
| Resolution | 8 bit, LSB = Vref/256 (3.9 mV at Vref = 1 V) | |
| INL, tt 27 °C | 0.11 LSB max | — |
| INL, 15 corners (tt/ss/ff/sf/fs × −40/27/85 °C) | ≤ 0.26 LSB | **0.04 – 0.16 LSB** |
| DNL, tt, full ramp | +0.26 / −0.24 LSB | **+0.26 / −0.24 LSB** |
| Missing codes | none | **none (all corners)** |
| ENOB, sine test, 400 conversions, Blackman-Harris window | 7.99 | **≈ 8.0** |
| Offset / gain error | about −0.7 LSB / +2 LSB per V | about −1.5 LSB / +3 LSB per V (calibrates out) |
| Analog power, 1 MS/s | | about 15 µW |

**Reading the ENOB figure.** An ideal 8-bit quantizer scores 7.9–8.2 in this finite-length test, so "≈ 8.0" means the linearity errors are too small to measure with it. Transient simulation includes no device noise. To account for it, the post-layout ADC was re-simulated with Gaussian input-referred noise added to every sample (400 conversions, two seeds each, same window):

| Input-referred noise (rms) | Post-layout ENOB (mean of 2 seeds) | Ideal 8-bit quantizer, same noise |
|---|---|---|
| 0 | 8.04 | 8.01 |
| 0.5 mV | 7.90 | 7.87 |
| 0.7 mV | 7.78 | 7.76 |
| 1.0 mV | 7.61 | 7.57 |
| 1.5 mV | 7.18 | 7.25 |

The ADC tracks an ideal quantizer with the same noise to within the test's scatter (about ±0.1 bit). The comparator's estimated input noise is 0.7–1.0 mV rms, so **expect an ENOB of about 7.6–7.8 on silicon**, before board and reference noise.

### Characterization (post-layout, simulated)

**Sample rate (clock sweep; 10 clocks per conversion).** ENOB is windowed over 250 conversions; the 1 MS/s row is the reference.

| Clock / sample rate | tt 27 °C | slow-PMOS corner −40 °C ("sf") | ss 85 °C | Analog power (tt) |
|---|---|---|---|---|
| 10 MHz / 1 MS/s | 8.06 | 7.96 | 8.05 | ≈ 15 µW |
| 20 MHz / 2 MS/s | 7.78 | 7.69 | 7.86 | ≈ 21 µW |
| 25 MHz / 2.5 MS/s | 7.67 | 7.57 | 7.72 | ≈ 24 µW |
| 33 MHz / 3.3 MS/s | 7.44 | 7.54 | 7.36 | ≈ 29 µW |
| 50 MHz / 5 MS/s | 6.88 | 6.92 | 6.58 | ≈ 39 µW |
| 66 MHz / 6.6 MS/s | 6.37 | — | — | ≈ 49 µW |

**Recommended operation:** up to **10 MHz (1 MS/s)** for full 8-bit performance. It is usable up to **25 MHz (2.5 MS/s)** with ENOB ≥ 7.5 at the three corners checked. Above that, ENOB falls gradually; there is no sudden failure.

**Other conditions (1 MS/s, tt 27 °C unless noted; windowed ENOB, 400 conversions):**

| Condition | ENOB |
|---|---|
| Input 72 kHz / 248 kHz / 490 kHz (near Nyquist) | 8.04 / 7.99 / 7.98: flat to Nyquist |
| Amplitude −6 dBFS / −20 dBFS | 6.97 / 4.66 (ideal 7.0 / 4.7): noise floor set by quantization |
| VDD 1.62 V / 1.98 V (±10 %) | 8.05 / 7.83 |
| Vref 0.8 V / 1.2 V | 7.69 / 8.08 |
| Corners ff 85 °C / fs 27 °C / ss −40 °C / sf −40 °C | 7.90 / 8.02 / 8.13 / 8.06 |

**Power.** At 1 MS/s, Vref supplies ≈ 11.2 µA (≈ 9.8 µA of it is the static Vcm divider) and VDD ≈ 2.3 µA (analog only). That is ≈ 15 µW. The SAR logic's power is not included (it is simulated as Verilog).

## How to test

1. Apply **Vref** (0.8–1.2 V; 1.0 V nominal) to `ua[1]` from a low-impedance source. The input range is 0 … Vref.
2. Apply the analog input to `ua[0]`. Use a source impedance of about 1 kΩ or less: the input is sampled onto about 2.4 pF during one clock period.
3. Set the clock to 10 MHz (or slower; up to 25 MHz with slightly reduced ENOB) and pulse `rst_n` low, then high.
4. The ADC converts continuously. On each rising edge of `done` (`uio[0]`), read `code[7:0]` on `uo_out[7:0]`. The ideal code is floor(256 · Vin / Vref).

Suggested checks:
- Offset and gain: apply two DC levels (e.g. 0.1·Vref and 0.9·Vref) and fit a line.
- A slow ramp on `ua[0]` with all codes captured gives the INL/DNL histogram.
- A sine wave near full scale gives the FFT, SNDR and ENOB.

## External hardware

- A clean reference voltage (about 1.0 V) for `ua[1]`, e.g. a precision reference or a buffered DAC.
- A signal source for `ua[0]` (function generator or DAC with an RC filter).
- A logic analyzer or microcontroller to capture `uo_out[7:0]` on `done` (`uio[0]`).
