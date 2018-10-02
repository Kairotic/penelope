#!/usr/bin/python

import serial
import re
import liblo

target = liblo.Address(7771)

def dirt():
    print "kick"
    liblo.send(target,
               "/play",
               "bd", 
               0, # offset
               0, # start
               1, # end
               1, # speed
               0.5, # pan
               0, # velocity
               "", # vowel_s
               0, # cutoff
               0, # resonance
               0, # accelerate
               0, # shape

               1, # gain
               0, # cutgroup
               
               0, # delay
               0, # delaytime
               0, # delayfeedback

               0, # crush
               0, # coarse
               0, # hcutoff
               0, # hresonance
               0, # bandf
               0, # bandq
               "r", # unit_name
               0, # sample_loop
               0, # sample_n
               0, # attack
               0, # hold
               0  # release
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

            
