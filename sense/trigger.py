#!/usr/bin/python

import serial
import re



devname = "/dev/serial/by-id/usb-Arduino__www.arduino.cc__0043_557363239393515181E2-if00"

pat = re.compile("(\d+) (on|off)")

with serial.Serial(devname, 115200, timeout=1) as ser:
    print("opened serial port " + ser.name)

    while True:
        l = ser.readline()
        if l:
            m = re.search(pat, l)
            if m: 
                print m.group(1)
                print m.group(2)
            
            
