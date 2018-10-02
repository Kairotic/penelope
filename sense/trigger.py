#!/usr/bin/python
import serial

devname = "/dev/serial/by-id/usb-Arduino__www.arduino.cc__0043_557363239393515181E2-if00"

with serial.Serial('/dev/ttyS1', 19200, timeout=1) as ser:
    s = serial.Serial(devname)
    print("opened serial port " + ser.name)

    while true:
        l = ser.readline
        if l:
            print(l)
            
