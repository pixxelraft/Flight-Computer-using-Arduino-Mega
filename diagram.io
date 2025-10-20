{
  "version": 1,
  "author": "sayed umair ali",
  "editor": "wokwi",
  "parts": [
    { "type": "wokwi-arduino-mega", "id": "mega", "top": 48.6, "left": 140.4, "attrs": {} },
    {
      "type": "wokwi-slide-potentiometer",
      "id": "pot1",
      "top": 110.6,
      "left": 565.4,
      "attrs": { "travelLength": "30" }
    },
    { "type": "wokwi-mpu6050", "id": "imu1", "top": 3.82, "left": 59.92, "attrs": {} },
    { "type": "wokwi-microsd-card", "id": "sd1", "top": 115.43, "left": -9.53, "attrs": {} },
    {
      "type": "wokwi-lcd2004",
      "id": "lcd1",
      "top": -166.4,
      "left": 332,
      "attrs": { "pins": "i2c" }
    },
    { "type": "wokwi-led", "id": "led1", "top": 15.6, "left": -15.4, "attrs": { "color": "red" } },
    {
      "type": "wokwi-resistor",
      "id": "r1",
      "top": -82.45,
      "left": 38.4,
      "attrs": { "value": "220" }
    }
  ],
  "connections": [
    [ "lcd1:GND", "mega:GND.1", "black", [ "h0" ] ],
    [ "lcd1:VCC", "mega:5V", "red", [ "h0" ] ],
    [ "lcd1:SDA", "mega:20", "green", [ "h-9.6", "v134.6", "h153.6" ] ],
    [ "lcd1:SCL", "mega:21", "green", [ "h-19.2", "v134.7", "h19.2" ] ],
    [ "imu1:GND", "mega:GND.2", "black", [ "v259.2", "h192.08" ] ],
    [ "imu1:VCC", "mega:5V", "red", [ "v240", "h172.88" ] ],
    [ "imu1:SDA", "mega:20", "blue", [ "v28.8", "h355.28" ] ],
    [ "imu1:SCL", "mega:21", "blue", [ "v9.6", "h374.48" ] ],
    [ "sd1:GND", "mega:GND.3", "black", [ "h38.4", "v144.11", "h220.8" ] ],
    [ "sd1:VCC", "mega:5V", "red", [ "h28.8", "v96.14", "h211.2" ] ],
    [ "pot1:VCC", "mega:5V", "red", [ "h-28.8", "v105.6", "h-240" ] ],
    [ "pot1:GND", "mega:GND.3", "black", [ "v153.6", "h-455.6" ] ],
    [ "mega:A0", "pot1:SIG", "green", [ "v45.3", "h227.1" ] ],
    [ "sd1:DO", "mega:50", "green", [ "h28.8", "v201.71", "h432" ] ],
    [ "sd1:DI", "mega:51", "green", [ "h19.2", "v172.71", "h432" ] ],
    [ "sd1:CS", "mega:53", "green", [ "h9.6", "v144.06", "h441.6" ] ],
    [ "sd1:SCK", "mega:52", "green", [ "h0", "v134.39", "h422.4" ] ],
    [ "r1:2", "mega:GND.1", "black", [ "v28.8", "h162" ] ],
    [ "led1:C", "r1:1", "green", [ "v0", "h-18.8", "v-124.8" ] ],
    [ "led1:A", "mega:13", "green", [ "v28.8", "h259.2" ] ]
  ],
  "dependencies": {}
}
