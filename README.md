# voronred300

Klipper configuration backups.

## Description

Backups for Voron 2.4 300mm build based on Fysetc Spider 1.1 MCU.

## Spider 1.1 MCU PIN Assignments

|PIN|Component
|-|-
|FAN0|     Hotend
|FAN1|     Part Fan
|FAN2|     Compartment Fan
|E1 Out|   Chamber Fan
|PA1|      Endstop - X
|PA2|      Endstop - Y
|PA3|      Klicky / Probe
|PB14|     BTT Filament Runout Sensor
|PB13|     N/C
|PA0|      Endstop - Z
|PC0|      Extruder Thermistor
|PC1|      Cabinet Thermistor
|PC2|      N/C
|PC3|      Bed Thermister
|PC9|      Fysetc 12864 beeper
|PD3|      Stealth Neopixels - Spider neopixel port

## Slicer start print gcode

* Prusa Slicer <br>
  ```
  M109 S0 ; Dont insert bed temp gcode
  M190 S0 ; Dont insert extruder temp gcode
  print_start EXTRUDER=[first_layer_temperature[initial_tool]] BED=[first_layer_bed_temperature] FILAMENT=[filament_type]
  ``` 

## Change Log


* Rebuild and install klipper, fluid on clean buster 32bit image (bullseye still has rPi camera issues with new cameralib setup)
* Klipper build/make script and configurations for updating and flashing RP [Input Shaper] and Spider MCU's (scripts/mymakeklipper.sh)
* New macro and helper script to process input shaper data files and generate X & Y graphs to klippy_config directory for review and download (INPUT_SHAPER & scripts/myinputshaper.sh)
* Created hard link to external moonraker database in local ~/klippy_config repository to include in GITHUB backup <br>
```mkdir ~/klippy_config/.moonraker_database_git_mirror;ln ~/klippy_config/.moonraker_database_git_mirror/data.mdb ~/.moonraker_database_git_mirror/data.mdb```
* Added Gucci Voron logo startup and shutdown "splash" screen for Fysetc 12864. Set knob neopixels to red for online, and blue for shutdown.  Switches between splash and normal display group in delayed start gcode 
* Default printer to de-powered Z stepper current state (0.38 A) to reduce impact of crash when performing calibration and other non print related moves. Z stepper currents are only set after normal PRINT_START and calibration procedures are complete. De-powered again in PRINT_END and CANCEL_PRINT macros
* Benchmark and test different probe settings to improve reliability (klicky). First probe is usually the one that is out of wack causing retries. <br>
  ```speed:                     7.5
  lift_speed:                 50.0
  samples:                    3
  samples_result:             median
  sample_retract_dist:        0.8
  samples_tolerance:          0.0085
  samples_tolerance_retries:  6
  ```
* Update CANCEL_PRINT to call out to PRINT_END to finalise print head move and retract filament e.g. do cancel stuff then PRINT_END
* Improve square corner quality - square_corner_velocity: 8.0
* Update PRINT_START to lock klicky probe for QGL, G32 Z, and Bed Mesh operations to remove needless probe unattach/attach action 

[mygithub](https://github.com/nigelpjames)
