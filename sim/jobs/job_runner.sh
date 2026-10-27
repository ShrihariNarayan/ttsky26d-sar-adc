#!/bin/bash
# job_runner.sh -- runs job scripts that Claude drops into sim/jobs/queue/, so simulations run on this
# Mac (8 cores, reference ngspice) without manual starts. Start ONCE inside the Docker container:
#     cd /foss/designs/ttsky26d-sar-adc/sim/jobs && nohup bash job_runner.sh > /dev/null 2>&1 &
# Jobs run from sim/ in name order. Names starting with "x_" use all cores and run alone;
# other jobs run up to MAXPAR at a time. Results: done/<job>.log and done/<job>.rc.
# Heartbeat (timestamp) in ./heartbeat every 30 s. To stop: touch STOP
cd "$(dirname "$0")"
mkdir -p queue running done
MAXPAR=${MAXPAR:-3}
echo "$(date '+%F %T') runner started (pid $$)" >> runner.log
while true; do
  date '+%F %T' > heartbeat
  nrun=$(ls running/*.job 2>/dev/null | wc -l)
  xrun=$(ls running/x_*.job 2>/dev/null | wc -l)
  j=$(ls queue/*.job 2>/dev/null | sort | head -1)
  if [ -n "$j" ] && [ "$xrun" -eq 0 ]; then
    b=$(basename "$j" .job)
    if { [[ $b == x_* ]] && [ "$nrun" -eq 0 ]; } || { [[ $b != x_* ]] && [ "$nrun" -lt "$MAXPAR" ]; }; then
      mv "$j" "running/$b.job"
      echo "$(date '+%F %T') start $b" >> runner.log
      ( cd .. && bash "jobs/running/$b.job" > "jobs/done/$b.log" 2>&1; rc=$?
        cd jobs && echo $rc > "done/$b.rc" && mv "running/$b.job" "done/$b.job"
        echo "$(date '+%F %T') end $b rc=$rc" >> runner.log ) &
      sleep 2; continue
    fi
  fi
  if [ -f STOP ]; then echo "$(date '+%F %T') stop requested" >> runner.log; rm -f STOP; exit 0; fi
  sleep 30
done
