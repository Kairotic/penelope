#!/usr/bin/python

import serial
import re
import liblo
import time
import math

target = liblo.Address(7771)

#samplesets = [
#    "can",
#    "cp",
#    "dr",
#    "kurt",
#    "psr",
#    "hi",
#    "lo",
#    "clap",
#    "onoff",
#    "sb",
#    "arpy",
#    "rs"
#]

def dirt(name, n=0.0, speed=1.0, vowel="", crush=0,cutoff=0.0,resonance=0.0):
    now = time.time()
    sec = math.floor(now)
    usec = math.floor((now - sec)*1000000)
    liblo.send(target,
               "/play",
               int(sec),int(usec),
               1.0, # cps
               name, 
               float(0.0), # offset
               float(0.0), # start
               1.0, # end
               speed, # speed
               0.5, # pan
               0.5, # velocity
               vowel, # vowel_s
               float(cutoff), # cutoff
               float(resonance), # resonance
               float(0.0), # accelerate
               float(0.0), # shape
               0, # ?
               1.0, # gain
               0, # cutgroup
               
               float(0.0), # delay
               -1.0, # delaytime
               -1.0, # delayfeedback

               float(crush), # crush
               0, # coarse
               float(0.0), # hcutoff
               float(0.0), # hresonance
               float(0.0), # bandf
               float(0.0), # bandq
               "r", # unit_name
               1.0, # sample_loop
               float(n), # sample_n
               -1.0, # attack
               float(0.0), # hold
               -1.0,  # release
               0
               )


n = 0
co = 4000

dirt("foley",
     n=float(4),
     resonance=0.2,
     cutoff=co
)


#devname = "/dev/serial/by-id/usb-Arduino__www.arduino.cc__0043_557363239393515181E2-if00"
devname = "/dev/serial/by-id/usb-Arduino__www.arduino.cc__0043_95635333930351303240-if00"

#pat = re.compile("(\+|\-)(\d+)\s*([\d\.]+)?\s*([\d\.]+)?")

pat = re.compile("(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)")


with serial.Serial(devname, 9600, timeout=1) as ser:
    print("opened serial port " + ser.name)

    minval = None
    maxval = None
    
    while True:
        l = ser.readline()
        print(l)
        if l:
            print l
            
#            m = re.search(pat, l)
#            if m:
#                if m.group(1) == "+":
#                    n = int(m.group(2))
#                    filtered = int(m.group(3))
#                    baseline = int(m.group(4))
#                    if minval == None or minval > filtered:
#                        minval = filtered
#                    if maxval == None or maxval < filtered:
#                        maxval = filtered
#                    delta = maxval - minval
#                    perc = (filtered - minval) / delta
#                    co = perc * 2000.0
#                    print("%s %d %f %f" % (m.group(1), int(m.group(2)), int(m.group(3)), int(m.group(4))))
#                dirt("foley",
#                     n=float(n),
#                     resonance=0.2,
#                     cutoff=co
#                )

            
