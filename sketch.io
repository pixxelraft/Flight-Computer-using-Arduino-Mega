#include <Wire.h>
#include <SPI.h>
#include <SD.h>
#include <LiquidCrystal_I2C.h>
#include <Adafruit_MPU6050.h>
#include <Adafruit_Sensor.h>


#define SD_CS_PIN 53         
#define PARACHUTE_PIN 13     
#define ALTIMETER_PIN A0     

LiquidCrystal_I2C lcd(0x27, 20, 4);  
Adafruit_MPU6050 mpu;
File logFile;


enum FlightState {
  PRE_LAUNCH,
  LAUNCHING,
  APOGEE,
  RECOVERY,
  LANDED
};
FlightState currentState = PRE_LAUNCH;
String stateNames[] = {"PRE-LAUNCH", "LAUNCHING", "APOGEE", "RECOVERY", "LANDED"};


float max_altitude = 0;
float previous_altitude = 0;
float current_altitude = 0;

void setup() {
  Serial.begin(115200);
  pinMode(PARACHUTE_PIN, OUTPUT);
  digitalWrite(PARACHUTE_PIN, LOW); 
  pinMode(ALTIMETER_PIN, INPUT);    

  
  lcd.init();
  lcd.backlight();
  
  
  lcd.setCursor(0, 0);
  lcd.print("Welcoming Umair to");
  lcd.setCursor(0, 1);
  lcd.print("Flight Computer!");
  delay(3000); 

  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("Initializing...");

  
  if (!mpu.begin()) {
    Serial.println("Failed to find MPU6050");
    lcd.setCursor(0, 1);
    lcd.print("MPU6050 FAILED");
    while (1) delay(10);
  }

  
  lcd.setCursor(0, 1);
  lcd.print("Init SD card...");
  if (!SD.begin(SD_CS_PIN)) {
    Serial.println("SD Card Failed");
    lcd.print("SD FAILED");
    while (1) delay(10);
  }

  
  logFile = SD.open("LOG.TXT", FILE_WRITE);
  if (logFile) {
    logFile.println("--- Rocket Flight Log ---");
    logFile.println("Time,State,Alt,MaxAlt,AccelZ");
    logFile.close();
  } else {
    lcd.setCursor(0, 1);
    lcd.print("LOG.TXT FAILED");
  }

  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("Ready for Launch");
}

void loop() {
  
  sensors_event_t a, g, temp;
  mpu.getEvent(&a, &g, &temp);
  
  
  int sensorVal = analogRead(ALTIMETER_PIN);
  current_altitude = map(sensorVal, 0, 1023, 0, 10000); 
  
  float accel_z = a.acceleration.z;
  
  
  if (current_altitude > max_altitude) {
    max_altitude = current_altitude;
  }

  
  switch (currentState) {
    case PRE_LAUNCH:
      
      if (accel_z > 15) { 
        currentState = LAUNCHING;
      }
      break;

    case LAUNCHING:
      // If we are still climbing
      if (current_altitude > previous_altitude) {
        previous_altitude = current_altitude;
      } 
      // If we start falling (even by 1 meter)
      else if (current_altitude < previous_altitude) {
        currentState = APOGEE;
      }
      break;

    case APOGEE:
      // Deploy the parachute!
      digitalWrite(PARACHUTE_PIN, HIGH); 

      
      delay(4000); 
      
      
      currentState = RECOVERY;
      break;

    case RECOVERY:
      
      if (current_altitude <= 1.0) {
        currentState = LANDED;
      }
      break;

    case LANDED:
      
      digitalWrite(PARACHUTE_PIN, LOW); 
      break;
  }

  
  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("State: ");
  lcd.print(stateNames[currentState]);

  lcd.setCursor(0, 1);
  lcd.print("Alt: ");
  lcd.print(current_altitude);
  lcd.print(" m");

  lcd.setCursor(0, 2);
  lcd.print("Max Alt: ");
  lcd.print(max_altitude);
  lcd.print(" m");
  
  lcd.setCursor(0, 3);
  lcd.print("Accel Z: ");
  lcd.print(accel_z);

  
  if (currentState != LANDED) {
    logFile = SD.open("LOG.TXT", FILE_WRITE);
    if (logFile) {
      logFile.print(millis()); 
      logFile.print(",");
      logFile.print(stateNames[currentState]);
      logFile.print(",");
      logFile.print(current_altitude);
      logFile.print(",");
      logFile.print(max_altitude);
      logFile.print(",");
      logFile.println(accel_z);
      logFile.close();
    }
  }

  delay(100); 
}
