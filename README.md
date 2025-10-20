# Raspberry Pi Pico TVC Flight Computer (Autonomous Simulation)

This project simulates an advanced rocket flight computer with **Thrust Vector Control (TVC)** for powered landing, running on a Raspberry Pi Pico in the Wokwi simulator. It features an **autonomous flight profile**, simulating launch, ascent, apogee flip, landing burn, hover, and final touchdown using internal physics calculations and PID controllers.

## Features ✨

* **Autonomous Flight:** Press one button to initiate a complete, pre-programmed flight sequence from launch to landing.
* **Internal Physics Simulation:** Models basic vertical motion (thrust, gravity) and rotational motion (gimbal torque, damping).
* **Thrust Vector Control (TVC):** Uses two simulated servo motors to represent engine gimbal, controlled by a PID loop to maintain vertical stability (balancing).
* **Powered Landing Logic:** Uses a second PID loop to control simulated engine throttle (represented by an LED's brightness) to achieve a soft landing profile, including a hover phase.
* **Sensor Fusion Concept:** Includes the structure for a Complementary Filter to calculate tilt angle (though the physical MPU6050 sensor is simulated internally).
* **Flight State Machine:** Tracks the rocket through multiple phases: `UNARMED`, `IGNITION`, `ASCENT`, `APOGEE_FLIP`, `LANDING_BURN`, `HOVER`, `FINAL_DESCENT`, `LANDED`.
* **LCD Telemetry:** Displays real-time state, simulated altitude, target altitude, simulated velocity, simulated tilt angle, gimbal command, and throttle percentage.
* **Personalized Welcome Message:** Greets "Umair" and waits for arming command.

## Hardware Simulated (Wokwi) 🛠️

* Raspberry Pi Pico
* MPU6050 Accelerometer + Gyroscope (I2C - *Note: Sensor values are simulated internally, but the component is wired*)
* HC-SR04 Ultrasonic Distance Sensor (*Note: Sensor values are simulated internally, but the component is wired*)
* LCD 20x4 (I2C)
* Two Servo Motors (Connected to GP16, GP17 for TVC)
* Red LED (Connected to GP13 for Throttle Simulation)
* 220 Ohm Resistor
* Pushbutton (Connected to GP22 for Arming)

## Setup ⚙️

1.  **Wiring:** Connect the components to the Raspberry Pi Pico according to the `sketch.ino` comments or the `diagram.json` file.
    * **I2C:** LCD & MPU6050 share SDA (GP4) and SCL (GP5).
    * **Ultrasonic:** Trig to GP14, Echo to GP15.
    * **Servos:** SIG pins to GP16 and GP17. Power from VBUS (5V).
    * **LED:** Anode to GP13, Cathode through resistor to GND.
    * **Button:** Between GP22 and GND.
2.  **Libraries:** Create a `libraries.txt` file in your Wokwi project and add the following lines:
    ```
    LiquidCrystal_I2C
    Servo
    PID
    ```
    *(Note: MPU6050/Sensor/NewPing libraries are included in the code but commented out/not strictly needed as sensors are simulated internally)*
3.  **Code:** Copy the provided `sketch.ino` code (Autonomous Flight v3.0 with Welcome Message and Landing Fix) into the Wokwi editor.

## How to Run the Simulation 🚀

1.  Click the "Start Simulation" (►) button.
2.  The LCD will display the "Welcome Umair! Click button to arm and Launch!" message.
3.  **Arm & Launch:** Click the **Pushbutton** once.
4.  **Watch:** The simulation will proceed automatically through the flight states:
    * `IGNITION`: Throttle LED goes full bright.
    * `ASCENT`: Altitude climbs, servos actively correct simulated tilt.
    * `APOGEE_FLIP`: Throttle cuts, servos center briefly.
    * `LANDING_BURN`: Throttle reactivates, controlled by PID to slow descent towards 20cm.
    * `HOVER`: Holds ~20cm altitude for 10 seconds, servos actively balance.
    * `FINAL_DESCENT`: Target altitude drops to 2cm, throttle decreases.
    * `LANDED`: Throttle cuts, servos center. Flight complete.
5.  The LCD will continuously update with simulated telemetry throughout the flight.

## Notes

* This simulation focuses on the **control logic** and uses a simplified internal physics model. It does not read the actual MPU6050 or HC-SR04 sensors in Wokwi.
* PID parameters (`Kp`, `Ki`, `Kd`) are tuned for *this specific simulation* and would need significant adjustment for a real rocket.
* The simulation may run slower than real-time due to the computational load.
