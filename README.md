# RC-Car-Made-with-FPGA
Please use the Raw file for better viewing.

Wiring Configuration:


ESP32 → DE10-Lite FPGA Inputs

Direction   | Label | DE10 GPIO Pin | ESP32 GPIO Pin
Forward     | F     | GPIO[1]       | GPIO 15
Backward    | B     | GPIO[3]       | GPIO 2
Left        | L     | GPIO[5]       | GPIO 4
Right       | R     | GPIO[7]       | GPIO 0

DE10-Lite Outputs → Motor Driver (L298N)

Output Signal   | Label | DE10 GPIO Pin | L298N IN Pin
Output 1        | O1    | GPIO[11]      | IN1
Output 2        | O2    | GPIO[13]      | IN2
Output 3        | O3    | GPIO[17]      | IN3
Output 4        | O4    | GPIO[15]      | IN4

Demonstration: https://youtu.be/Cx431S7MN6c
