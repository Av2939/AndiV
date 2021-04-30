
#define BLYNK_PRINT Serial
#include<Wire.h>
#include <BlynkSimpleEsp32.h> 
 int sensorThres;
 int staticThres= 20;
int LED = 2;
int SENSOR = 34;
// Your threshold value


// You should get Auth Token in the Blynk App.
char auth[] = "c_NXb-QS25WrLme4U-u2CsHAw4TXAbxZ";
 
// Your WiFi credentials.
// Set password to "" for open networks.
char ssid[] = "MySpectrumWiFi78-2G";
char pass[] = "scaryrose925";
 

 
void setup()
{
  // Debug console
  Serial.begin(9600);
  Blynk.begin(auth, ssid, pass); 
  Serial.begin(9600);
  Serial.println("Waiting for connections...");

 pinMode(LED, OUTPUT);
 pinMode(SENSOR, INPUT);


 
}

BLYNK_WRITE(V2)
{
  
  sensorThres = param.asInt(); // assigning incoming value from pin V2 to a variable
  // You can also use:
  // String i = param.asStr();
  // double d = param.asDouble();
  
  
}
 
void loop()
{
 
   Blynk.run();
  while (staticThres < sensorThres || staticThres > sensorThres) 
{
staticThres = sensorThres;
}

int analogSensor = analogRead(SENSOR);




  Serial.print("Pin A0: ");
  Serial.println(analogSensor);
  Serial.print("V2 Slider value is: ");
  Serial.println(sensorThres);
  // Checks if it has reached the threshold value
  if (analogSensor > sensorThres)
  {
   
    digitalWrite(LED, HIGH);
    Blynk.notify("GAS IS ON ");
  }
  else
  {
   
    digitalWrite(LED, LOW);
  }


Blynk.virtualWrite(V1, analogSensor);
 delay(20);

}
