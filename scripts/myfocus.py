#!/usr/bin/python3
import sys
from ctypes import *

arducam_vcm = CDLL('/home/pi/arducam/Motorized_Focus_Camera/python/lib/libarducam_vcm.so')

arducam_vcm.vcm_init()
focus=310
print("Setting arducam focus to ",focus)
arducam_vcm.vcm_write(focus)
