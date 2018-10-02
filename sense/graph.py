import sys
import time

sys.path.insert(0, "/home/pi/Adafruit_Python_MPR121/Adafruit_MPR121")

import MPR121ROB as MPR121

Filtered = []
Baseline = []

print('Adafruit MPR121 Capacitive Touch Sensor Test')

# Create MPR121 instance.
cap = MPR121.MPR121()

# Initialize communication with MPR121 using default I2C bus of device, and
# default I2C address (0x5A).  On BeagleBone Black will default to I2C bus 0.
if not cap.begin():
    print('Error initializing MPR121.  Check your wiring!')
    sys.exit(1)

cap.set_thresholds(12, 6)

# Alternatively, specify a custom I2C address such as 0x5B (ADDR tied to 3.3V),
# 0x5C (ADDR tied to SDA), or 0x5D (ADDR tied to SCL).
#cap.begin(address=0x5B)

# Also you can specify an optional I2C bus with the bus keyword parameter.
#cap.begin(busnum=1)

# Main loop to print a message every time a pin is touched.
print('Press Ctrl-C to quit.')
last_touched = cap.touched()
try:
    while True:
        current_touched = cap.touched()
        # Check each pin's last and current state to see if it was pressed or released.
        for i in range(12):
            # Each pin is represented by a bit in the touched value.  A value of 1
            # means the pin is being touched, and 0 means it is not being touched.
            pin_bit = 1 << i
            # First check if transitioned from not touched to touched.
            if current_touched & pin_bit and not last_touched & pin_bit:
                print('{0} touched!'.format(i))
            # Next check if transitioned from touched to not touched.
            if not current_touched & pin_bit and last_touched & pin_bit:
                print('{0} released!'.format(i))
        # Update last state and wait a short period before repeating.
        last_touched = current_touched
        time.sleep(0.1)

        # Alternatively, if you only care about checking one or a few pins you can
        # call the is_touched method with a pin number to directly check that pin.
        # This will be a little slower than the above code for checking a lot of pins.
        #if cap.is_touched(0):
        #    print('Pin 0 is being touched!')

        Filtered.extend([cap.filtered_data(0)])
        Baseline.extend([cap.baseline_data(0)])

        # If you're curious or want to see debug info for each pin, uncomment the
        # following lines:
        #print '\t\t\t\t\t\t\t\t\t\t\t\t\t 0x{0:0X}'.format(cap.touched())
        #filtered = [cap.filtered_data(i) for i in range(12)]
        #print('Filt:', '\t'.join(map(str, filtered)))
        #base = [cap.baseline_data(i) for i in range(12)]
        #print('Base:', '\t'.join(map(str, base)))

except KeyboardInterrupt:
    import matplotlib.pyplot as plt
    plt.plot(Filtered, 'r--')
    plt.plot(Baseline, 'bs')
    plt.show()
    sys.exit()
