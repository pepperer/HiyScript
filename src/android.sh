#!/bin/bash

#overdraw_command_map = ['on' : 'show',  'off' : 'false', 'deut' : 'show_deuteranomaly']
#overdraw_command_map_preKitKat = ['on' : 'true',  'off' : 'false']

#adb shell service list
# adb shell service check activity
adb shell setprop debug.layout off
#
#adb -s SQR7N17414000089 shell service call activity 1599295570
#adb shell service
#
#adb shell getprop
#
adb  shell setprop debug.hwui.overdraw false
#adb -s SQR7N17414000089 shell service call activity 1599295570
#
adb shell setprop debug.hwui.show_overdraw false
#adb -s SQR7N17414000089 shell service call activity 1599295570

adb shell getprop -T


adb shell screencap /sdcard/screen.png
adb shell service call activity 1599295570
