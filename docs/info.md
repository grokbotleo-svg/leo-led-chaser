## How it works

An 8-bit one-hot pattern rotates by one position on every tick, so a single lit LED appears to run across the 8 outputs. A 22-bit divider slows the ~12 MHz board clock down to a few steps per second. Input ui[0] selects the rotation direction, and ui[2:1] selects one of four stepping speeds.

## How to test

After reset, LED 0 lights up and the lit LED starts rotating. Flip ui[0] to reverse the direction. Change ui[2:1] between 00 and 11 to make the chaser run slower or faster.

## External hardware

Works directly with the 8 LEDs on the Tiny Tapeout demo board; no extra hardware is required.
