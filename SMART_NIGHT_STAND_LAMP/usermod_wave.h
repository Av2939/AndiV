


#pragma once

#include "wled.h"

#define trigPin 21 //defining pins
#define echoPin 19



//Define the 5 brightness levels
//Long press to turn off / on
#define brightness1 51
#define brightness2 102
#define brightness3 153
#define brightness4 204
#define brightness5 255


#ifdef ESP32





class TouchBrightnessControl : public Usermod {

 
 public:

  void setup()

{ 


pinMode(trigPin, OUTPUT);

pinMode(echoPin, INPUT);
}
   

    void loop() {
     delay(10);

        long duration, distance;

digitalWrite(trigPin, LOW);

delayMicroseconds(2);

digitalWrite(trigPin, HIGH);

delayMicroseconds(10);

digitalWrite(trigPin, LOW);

duration = pulseIn(echoPin, HIGH);

distance = (duration/2) / 29.1;
Serial.println(distance);    
if (distance <=35 && distance>3 ){
  toggleOnOff();
  colorUpdated(2);
  delay(700);
}
       //test
       //other test
       //yeet
        
    }
      };
#endif
