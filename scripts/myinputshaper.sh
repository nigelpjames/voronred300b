#!/bin/bash

# process input shaper calibration files if they exist and publish images to klipper config directory for downloaD

if ls /tmp/resonances_x_*.csv >/dev/null 2>&1; then
   python3 ~/klipper/scripts/calibrate_shaper.py /tmp/resonances_x_*.csv -o ~/klipper_config/shaper_calibrate_x.png
else
   echo No ADXL input shaper data file for X axis
   echo Run TEST_RESONANCES AXIS=X first
fi

if ls /tmp/resonances_y_*.csv >/dev/null 2>&1; then
   python3 ~/klipper/scripts/calibrate_shaper.py /tmp/resonances_y_*.csv -o ~/klipper_config/shaper_calibrate_y.png
else
   echo No ADXL input shaper data file for Y axis
   echo Run TEST_RESONANCES AXIS=Y first
fi
