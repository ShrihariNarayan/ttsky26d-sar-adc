# cdac_notch.tcl -- notch the merged bottom-plate metal3 under every vtop metal4 strap between caps
# (equalises vtop-to-bottom-plate parasitic per unit cap; MSB weight error +0.57 -> +0.27 LSB).
# Notches kept only where the group stays connected and no via2 is near; top row skipped (tabs).
# Run once from mag/ on the pre-notch cdac.mag (commit 75ed948).
load cdac
box 3.140um 0.860um 4.860um 3.140um
erase metal3
box 3.140um 4.860um 4.860um 7.140um
erase metal3
box 3.140um 8.860um 4.860um 11.140um
erase metal3
box 3.140um 12.860um 4.860um 15.140um
erase metal3
box 3.140um 16.860um 4.860um 19.140um
erase metal3
box 3.140um 20.860um 4.860um 23.140um
erase metal3
box 3.140um 24.860um 4.860um 27.140um
erase metal3
box 3.140um 28.860um 4.860um 31.140um
erase metal3
box 3.140um 32.860um 4.860um 35.140um
erase metal3
box 3.140um 36.860um 4.860um 39.140um
erase metal3
box 3.140um 40.860um 4.860um 43.140um
erase metal3
box 3.140um 44.860um 4.860um 47.140um
erase metal3
box 3.140um 48.860um 4.860um 51.140um
erase metal3
box 3.140um 52.860um 4.860um 55.140um
erase metal3
box 3.140um 56.860um 4.860um 59.140um
erase metal3
box 7.140um 0.860um 8.860um 3.140um
erase metal3
box 7.140um 4.860um 8.860um 7.140um
erase metal3
box 7.140um 8.860um 8.860um 11.140um
erase metal3
box 7.140um 12.860um 8.860um 15.140um
erase metal3
box 7.140um 16.860um 8.860um 19.140um
erase metal3
box 7.140um 20.860um 8.860um 23.140um
erase metal3
box 7.140um 24.860um 8.860um 27.140um
erase metal3
box 7.140um 28.860um 8.860um 31.140um
erase metal3
box 7.140um 32.860um 8.860um 35.140um
erase metal3
box 7.140um 36.860um 8.860um 39.140um
erase metal3
box 7.140um 40.860um 8.860um 43.140um
erase metal3
box 7.140um 44.860um 8.860um 47.140um
erase metal3
box 7.140um 48.860um 8.860um 51.140um
erase metal3
box 7.140um 52.860um 8.860um 55.140um
erase metal3
box 7.140um 56.860um 8.860um 59.140um
erase metal3
box 11.140um 0.860um 12.860um 3.140um
erase metal3
box 11.140um 4.860um 12.860um 7.140um
erase metal3
box 11.140um 8.860um 12.860um 11.140um
erase metal3
box 11.140um 12.860um 12.860um 15.140um
erase metal3
box 11.140um 16.860um 12.860um 19.140um
erase metal3
box 11.140um 20.860um 12.860um 23.140um
erase metal3
box 11.140um 24.860um 12.860um 27.140um
erase metal3
box 11.140um 28.860um 12.860um 31.140um
erase metal3
box 11.140um 32.860um 12.860um 35.140um
erase metal3
box 11.140um 36.860um 12.860um 39.140um
erase metal3
box 11.140um 40.860um 12.860um 43.140um
erase metal3
box 11.140um 44.860um 12.860um 47.140um
erase metal3
box 11.140um 48.860um 12.860um 51.140um
erase metal3
box 11.140um 52.860um 12.860um 55.140um
erase metal3
box 11.140um 56.860um 12.860um 59.140um
erase metal3
box 19.140um 0.860um 20.860um 3.140um
erase metal3
box 19.140um 4.860um 20.860um 7.140um
erase metal3
box 19.140um 8.860um 20.860um 11.140um
erase metal3
box 19.140um 12.860um 20.860um 15.140um
erase metal3
box 19.140um 16.860um 20.860um 19.140um
erase metal3
box 19.140um 20.860um 20.860um 23.140um
erase metal3
box 19.140um 24.860um 20.860um 27.140um
erase metal3
box 19.140um 28.860um 20.860um 31.140um
erase metal3
box 19.140um 32.860um 20.860um 35.140um
erase metal3
box 19.140um 36.860um 20.860um 39.140um
erase metal3
box 19.140um 40.860um 20.860um 43.140um
erase metal3
box 19.140um 44.860um 20.860um 47.140um
erase metal3
box 19.140um 48.860um 20.860um 51.140um
erase metal3
box 19.140um 52.860um 20.860um 55.140um
erase metal3
box 19.140um 56.860um 20.860um 59.140um
erase metal3
box 27.140um 0.860um 28.860um 3.140um
erase metal3
box 27.140um 4.860um 28.860um 7.140um
erase metal3
box 27.140um 8.860um 28.860um 11.140um
erase metal3
box 27.140um 12.860um 28.860um 15.140um
erase metal3
box 27.140um 16.860um 28.860um 19.140um
erase metal3
box 27.140um 20.860um 28.860um 23.140um
erase metal3
box 27.140um 28.860um 28.860um 31.140um
erase metal3
box 27.140um 32.860um 28.860um 35.140um
erase metal3
box 27.140um 40.860um 28.860um 43.140um
erase metal3
box 27.140um 44.860um 28.860um 47.140um
erase metal3
box 27.140um 48.860um 28.860um 51.140um
erase metal3
box 27.140um 52.860um 28.860um 55.140um
erase metal3
box 27.140um 56.860um 28.860um 59.140um
erase metal3
box 31.140um 0.860um 32.860um 3.140um
erase metal3
box 31.140um 4.860um 32.860um 7.140um
erase metal3
box 31.140um 8.860um 32.860um 11.140um
erase metal3
box 31.140um 12.860um 32.860um 15.140um
erase metal3
box 31.140um 16.860um 32.860um 19.140um
erase metal3
box 31.140um 20.860um 32.860um 23.140um
erase metal3
box 31.140um 40.860um 32.860um 43.140um
erase metal3
box 31.140um 44.860um 32.860um 47.140um
erase metal3
box 31.140um 48.860um 32.860um 51.140um
erase metal3
box 31.140um 52.860um 32.860um 55.140um
erase metal3
box 31.140um 56.860um 32.860um 59.140um
erase metal3
box 35.140um 0.860um 36.860um 3.140um
erase metal3
box 35.140um 4.860um 36.860um 7.140um
erase metal3
box 35.140um 8.860um 36.860um 11.140um
erase metal3
box 35.140um 12.860um 36.860um 15.140um
erase metal3
box 35.140um 16.860um 36.860um 19.140um
erase metal3
box 35.140um 20.860um 36.860um 23.140um
erase metal3
box 35.140um 40.860um 36.860um 43.140um
erase metal3
box 35.140um 44.860um 36.860um 47.140um
erase metal3
box 35.140um 48.860um 36.860um 51.140um
erase metal3
box 35.140um 52.860um 36.860um 55.140um
erase metal3
box 35.140um 56.860um 36.860um 59.140um
erase metal3
box 43.140um 0.860um 44.860um 3.140um
erase metal3
box 43.140um 4.860um 44.860um 7.140um
erase metal3
box 43.140um 8.860um 44.860um 11.140um
erase metal3
box 43.140um 12.860um 44.860um 15.140um
erase metal3
box 43.140um 16.860um 44.860um 19.140um
erase metal3
box 43.140um 20.860um 44.860um 23.140um
erase metal3
box 43.140um 24.860um 44.860um 27.140um
erase metal3
box 43.140um 28.860um 44.860um 31.140um
erase metal3
box 43.140um 32.860um 44.860um 35.140um
erase metal3
box 43.140um 36.860um 44.860um 39.140um
erase metal3
box 43.140um 40.860um 44.860um 43.140um
erase metal3
box 43.140um 44.860um 44.860um 47.140um
erase metal3
box 43.140um 48.860um 44.860um 51.140um
erase metal3
box 43.140um 52.860um 44.860um 55.140um
erase metal3
box 43.140um 56.860um 44.860um 59.140um
erase metal3
box 51.140um 0.860um 52.860um 3.140um
erase metal3
box 51.140um 4.860um 52.860um 7.140um
erase metal3
box 51.140um 8.860um 52.860um 11.140um
erase metal3
box 51.140um 12.860um 52.860um 15.140um
erase metal3
box 51.140um 16.860um 52.860um 19.140um
erase metal3
box 51.140um 20.860um 52.860um 23.140um
erase metal3
box 51.140um 24.860um 52.860um 27.140um
erase metal3
box 51.140um 28.860um 52.860um 31.140um
erase metal3
box 51.140um 32.860um 52.860um 35.140um
erase metal3
box 51.140um 36.860um 52.860um 39.140um
erase metal3
box 51.140um 40.860um 52.860um 43.140um
erase metal3
box 51.140um 44.860um 52.860um 47.140um
erase metal3
box 51.140um 48.860um 52.860um 51.140um
erase metal3
box 51.140um 52.860um 52.860um 55.140um
erase metal3
box 51.140um 56.860um 52.860um 59.140um
erase metal3
box 55.140um 0.860um 56.860um 3.140um
erase metal3
box 55.140um 4.860um 56.860um 7.140um
erase metal3
box 55.140um 8.860um 56.860um 11.140um
erase metal3
box 55.140um 12.860um 56.860um 15.140um
erase metal3
box 55.140um 16.860um 56.860um 19.140um
erase metal3
box 55.140um 20.860um 56.860um 23.140um
erase metal3
box 55.140um 24.860um 56.860um 27.140um
erase metal3
box 55.140um 28.860um 56.860um 31.140um
erase metal3
box 55.140um 32.860um 56.860um 35.140um
erase metal3
box 55.140um 36.860um 56.860um 39.140um
erase metal3
box 55.140um 40.860um 56.860um 43.140um
erase metal3
box 55.140um 44.860um 56.860um 47.140um
erase metal3
box 55.140um 48.860um 56.860um 51.140um
erase metal3
box 55.140um 52.860um 56.860um 55.140um
erase metal3
box 55.140um 56.860um 56.860um 59.140um
erase metal3
box 59.140um 0.860um 60.860um 3.140um
erase metal3
box 59.140um 4.860um 60.860um 7.140um
erase metal3
box 59.140um 8.860um 60.860um 11.140um
erase metal3
box 59.140um 12.860um 60.860um 15.140um
erase metal3
box 59.140um 16.860um 60.860um 19.140um
erase metal3
box 59.140um 20.860um 60.860um 23.140um
erase metal3
box 59.140um 24.860um 60.860um 27.140um
erase metal3
box 59.140um 28.860um 60.860um 31.140um
erase metal3
box 59.140um 32.860um 60.860um 35.140um
erase metal3
box 59.140um 36.860um 60.860um 39.140um
erase metal3
box 59.140um 40.860um 60.860um 43.140um
erase metal3
box 59.140um 44.860um 60.860um 47.140um
erase metal3
box 59.140um 48.860um 60.860um 51.140um
erase metal3
box 59.140um 52.860um 60.860um 55.140um
erase metal3
box 59.140um 56.860um 60.860um 59.140um
erase metal3
save cdac
quit -noprompt
