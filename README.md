# Arduino Mega Rocket Flight Computer (Telemetry Logger)

This project simulates a basic rocket flight computer using an Arduino Mega in the Wokwi simulator. It tracks the rocket's flight state (pre-launch, launching, apogee, recovery, landed), logs telemetry data to a virtual SD card, and displays live information on an LCD. Altitude is simulated using a slide potentiometer.

## Features ✨

* **Flight State Machine:** Tracks the rocket's progress through different flight phases.
* **Virtual Altimeter:** Uses a slide potentiometer to simulate altitude readings (0-10,000m).
* **Launch Detection:** Uses the MPU6050 accelerometer's Z-axis reading to detect liftoff G-force.
* **Apogee Detection:** Detects the peak altitude by monitoring when the simulated altitude starts decreasing.
* **Parachute Deployment Signal:** Activates an LED at apogee to simulate parachute deployment.
* **SD Card Logging:** Records timestamp, flight state, current altitude, max altitude, and Z-axis acceleration to a `LOG.TXT` file.
* **LCD Display:** Shows real-time flight state, altitude, max altitude, and acceleration.
* **Personalized Welcome Message:** Greets "Umair" upon startup.

## Hardware Simulated (Wokwi) 🛠️

* Arduino Mega 2560
* MPU6050 Accelerometer + Gyroscope (I2C)
* LCD 20x4 (I2C)
* MicroSD Card Module (SPI)
* Slide Potentiometer (Analog Input A0)
* Red LED
* 220 Ohm Resistor

## Setup ⚙️

1.  **Wiring:** Connect the components to the Arduino Mega according to the `sketch.ino` comments or the `diagram.json` file.
    * **I2C:** LCD & MPU6050 share SDA (Pin 20) and SCL (Pin 21).
    * **SPI:** SD Card uses MOSI (Pin 51), MISO (Pin 50), SCK (Pin 52), and CS (Pin 53).
    * **Altimeter:** Potentiometer SIG pin connects to A0.
    * **Parachute LED:** LED Anode connects to Pin 13, Cathode through resistor to GND.
2.  **Libraries:** Create a `libraries.txt` file in your Wokwi project and add the following lines:
    ```
    Adafruit MPU6050
    Adafruit Unified Sensor
    LiquidCrystal_I2C
    SD
    ```
3.  **Code:** Copy the provided `sketch.ino` code into the Wokwi editor.

## How to Run the Simulation 🚀

1.  Click the "Start Simulation" (►) button.
2.  The LCD will display the welcome message for 3 seconds, then "Ready for Launch."
3.  **Launch:** Click the **MPU6050** sensor and drag the **`accelZ` slider** above 1.53g (value > 15 m/s²). The state will change to `LAUNCHING`.
4.  **Ascend:** Click the **Slide Potentiometer** and drag the slider upwards. Watch the altitude increase on the LCD.
5.  **Apogee:** Drag the potentiometer slider downwards slightly. The state will briefly show `APOGEE`, the **LED will turn ON**, and then the state will change to `RECOVERY`. The "APOGEE" state is held for 2 seconds.
6.  **Land:** Drag the potentiometer slider back to the bottom (0). The state will change to `LANDED`, and the LED will turn OFF.
7.  **Review Data:** Go to the "SD Card" tab in Wokwi (next to `sketch.ino`) to view or download the `LOG.TXT` flight log.

## Notes

* This simulation uses a potentiometer for altitude, not a real pressure sensor.
* The launch detection and apogee detection logic are simplified for the simulation environment.
