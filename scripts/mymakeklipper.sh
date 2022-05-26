#!/bin/bash

# exit on any error
set -e

# generate and save configs using make menuconfig for Raspberry PI & Printer MCU setups
rp_mcu=~/klipper_config/scripts/config.rp_mcu
spider_mcu=~/klipper_config/scripts/config.spider_mcu

# usb device for mcu
usb_mcu=/dev/serial/by-id/usb-Klipper_stm32f446xx_26001F000B50563046363120-if00 

echo Stopping Klipper ...
sudo service klipper stop
cd ~/klipper

echo "Updating Klipper on RP MCU [Input Shaper]"

echo Using make override [${rp_mcu}]
make clean KCONFIG_NAME=${rp_mcu}
make menuconfig KCONFIG_NAME=${rp_mcu}
make KCONFIG_NAME=${rp_mcu}
read -p "Review errors and press [Enter] to continue flashing or Ctrl-C to abort"
make flash KCONFIG_NAME=${rp_mcu}
echo "RP MCU [Input Shaper] updated"
echo 

echo "Updating Klipper on Spider MCU"

echo Using make override [${spider_mcu}] to flash ${usb_mcu}
make clean KCONFIG_NAME=${spider_mcu}
make menuconfig KCONFIG_NAME=${spider_mcu}
make KCONFIG_NAME=${spider_mcu}
read -p "Review errors and press [Enter] to continue flashing or Ctrl-C to abort"
make flash KCONFIG_NAME=${spider_mcu} FLASH_DEVICE=${usb_mcu} 
echo "Spider MCU updated"
echo 

echo Starting Klipper ...
sudo service klipper start 
