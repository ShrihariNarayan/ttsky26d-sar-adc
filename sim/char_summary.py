# char_summary.py -- one line per characterization run: settings, ENOB (windowed), power
import re,subprocess,os
for ln in open('char_runs.txt'):
    t=ln.split(); 
    if not t: continue
    tag=t[0]; kv=dict(x.split('=') for x in t[1:]); N=int(kv['N']); ns=250 if N==256 else 400
    dat='fft_ch_%s.dat'%tag; log='fft_ch_%s.log'%tag
    e='-'; p='-'
    if os.path.exists(dat):
        o=subprocess.run(['python3','fft_win.py',dat,str(ns)],capture_output=True,text=True).stdout
        m=re.search(r'SNDR ([\d.-]+) dB ENOB ([\d.-]+)',o); e='%s bit (SNDR %s dB)'%(m.group(2),m.group(1)) if m else 'FAIL'
    if os.path.exists(log):
        m=re.search(r'VDD ([\d.-]+) uA, Vref ([\d.-]+) uA',open(log).read())
        if m: p='VDD %s uA, Vref %s uA'%(m.group(1),m.group(2))
    print('%-14s %-45s ENOB %-26s %s'%(tag,' '.join(t[1:]),e,p))
