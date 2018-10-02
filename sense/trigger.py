#!/usr/bin/python

import serial
import re
import liblo

target = liblo.Address(7771)

def dirt():
    print "kick"
    liblo.send(target,
               "/play",
               0,0,
               1, # cps
               "gabba", 
               float(0.0), # offset
               float(0.0), # start
               1.0, # end
               1.0, # speed
               0.5, # pan
               0.5, # velocity
               "", # vowel_s
               float(0.0), # cutoff
               float(0.0), # resonance
               float(0.0), # accelerate
               float(0.0), # shape
               0, # ?
               1.0, # gain
               0, # cutgroup
               
               float(0.0), # delay
               -1.0, # delaytime
               -1.0, # delayfeedback

               float(0.0), # crush
               0, # coarse
               float(0.0), # hcutoff
               float(0.0), # hresonance
               float(0.0), # bandf
               float(0.0), # bandq
               "r", # unit_name
               1.0, # sample_loop
               float(0.0), # sample_n
               -1.0, # attack
               float(0.0), # hold
               -1.0,  # release
               0
               )


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
                dirt()

            
