#!/usr/bin/python

import serial
import re



devname = "/dev/serial/by-id/usb-Arduino__www.arduino.cc__0043_557363239393515181E2-if00"

pat = re.compile("(\+|\-)(\d+)\s*([\d\.]+)?\s*([\d\.]+)?")

with serial.Serial(devname, 115200, timeout=1) as ser:
    print("opened serial port " + ser.name)

    while True:
        l = ser.readline()
        if l:
            print l
            m = re.search(pat, l)
            if m:
                if m.group(1) == "+":
                    n = int(m.group(2))
                    filtered = int(m.group(3))
                    baseline = int(m.group(4))
                    
                print("%s %d %f %f" % (m.group(1), int(m.group(2)), int(m.group(3)), int(m.group(4))))

            
            
