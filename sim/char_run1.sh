#!/bin/bash
# char_run1.sh TAG VAR=VAL... -- one characterization FFT run (v4 post-layout, Gear)
tag=$1; shift
env "$@" OPTS=".options method=gear" bash fft_char.sh adc_core_pex_v4.spice ch_$tag > fft_ch_$tag.log 2>&1
