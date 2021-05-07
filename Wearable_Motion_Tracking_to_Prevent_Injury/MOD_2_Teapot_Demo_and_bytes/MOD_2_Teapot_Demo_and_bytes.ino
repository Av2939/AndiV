//This code is for Mod 2 (Spine), the MAC Address for this ESP-32 is 84:CC:A8:12:30:5C


#include "I2Cdev.h"
#include <esp_now.h>
#include <WiFi.h>
#include "BluetoothSerial.h"
#include "MPU6050_6Axis_MotionApps_V6_12.h"
#include "Wire.h"

#if !defined(CONFIG_BT_ENABLED) || !defined(CONFIG_BLUEDROID_ENABLED)
#error Bluetooth is not enabled! Please run `make menuconfig` to and enable it
#endif


int analogPin = A13;
uint8_t broadcastAddress[] = {0x7C, 0x9E, 0xBD, 0xD3, 0x02, 0xC4};

typedef struct struct_message {
   uint8_t teapotPacket[8];
   float BATT;
} struct_message;

typedef struct struct_Message {
   
   char control;
   
} struct_Message;


// Creates a struct_message called myData that recieves data from Mod 1 (Thigh)
struct_message myData;

//This struct sends data to Mod 1 (Spine), this is to activate the Buzzer and LED
struct_Message sendData;


uint8_t Combined[19]; //The data pactet that is sent over BT to Processing

char val; //To control the LED and Buzzer for both modules 

char batt; //Battery values for Mod 2
char BATT; //Battery values for Mod 1

// callback function that will be executed when data is received
void OnDataRecv(const uint8_t * mac, const uint8_t *incomingData, int len) {
  memcpy(&myData, incomingData, sizeof(myData));

}
MPU6050 mpu;
#define OUTPUT_TEAPOT

#define INTERRUPT_PIN 2  // use pin 2 on Arduino Uno & most boards
bool blinkState = false;

// MPU control/status vars
bool dmpReady = false;  // set true if DMP init was successful
uint8_t mpuIntStatus;   // holds actual interrupt status byte from MPU
uint8_t devStatus;      // return status after each device operation (0 = success, !0 = error)
uint16_t packetSize;    // expected DMP packet size (default is 42 bytes)
uint16_t fifoCount;     // count of all bytes currently in FIFO
uint8_t fifoBuffer[64]; // FIFO storage buffer

// orientation/motion vars
Quaternion q;           // [w, x, y, z]         quaternion container
VectorInt16 aa;         // [x, y, z]            accel sensor measurements
VectorInt16 gy;         // [x, y, z]            gyro sensor measurements
VectorInt16 aaReal;     // [x, y, z]            gravity-free accel sensor measurements
VectorInt16 aaWorld;    // [x, y, z]            world-frame accel sensor measurements
VectorFloat gravity;    // [x, y, z]            gravity vector
float euler[3];         // [psi, theta, phi]    Euler angle container
float ypr[3];           // [yaw, pitch, roll]   yaw/pitch/roll container and gravity vector

// packet structure for InvenSense teapot demo in other words, Module 2
uint8_t teapotPacket[14] = { '$', 0x02, 0, 0, 0, 0, 0, 0, 0, 0, 0x00, 0x00, '\r', '\n' };


// ================================================================
// ===               INTERRUPT DETECTION ROUTINE                ===
// ================================================================

volatile bool mpuInterrupt = false;     // indicates whether MPU interrupt pin has gone high
void dmpDataReady() {
  mpuInterrupt = true;
}

BluetoothSerial ESP_BT; //Initalized BT that will be connect the whole system to a Bluetooth serial monitor.
void setup() {
  //----------------WIFI and BT initalizng stuff--------------------------------
  
  pinMode(32, OUTPUT); //pin for onboard led on ESP-32

   // Set device as a Wi-Fi Station
  WiFi.mode(WIFI_STA);

  // Init ESP-NOW
  if (esp_now_init() != ESP_OK) {
    return;
  }

  esp_now_register_recv_cb(OnDataRecv); //function that is activated when data is recieved, not used for this project

    // Register peer
  esp_now_peer_info_t peerInfo;
  memcpy(peerInfo.peer_addr, broadcastAddress, 6);
  peerInfo.channel = 0;  
  peerInfo.encrypt = false;
  
  // Add peer        
  if (esp_now_add_peer(&peerInfo) != ESP_OK){
    return;
  }
ESP_BT.begin("Yeet"); 
  
  // join I2C bus (I2Cdev library doesn't do this automatically)
#if I2CDEV_IMPLEMENTATION == I2CDEV_ARDUINO_WIRE
  Wire.begin();
  Wire.setClock(400000); // 400kHz I2C clock. Comment this line if having compilation difficulties
#elif I2CDEV_IMPLEMENTATION == I2CDEV_BUILTIN_FASTWIRE
  Fastwire::setup(400, true);
#endif

 
  Serial.begin(115200);
  //while (!Serial); // wait for Leonardo enumeration, others continue immediately

  

  // initialize device
  Serial.println(F("Initializing I2C devices..."));
  mpu.initialize();
  pinMode(INTERRUPT_PIN, INPUT);

  // verify connection
  Serial.println(F("Testing device connections..."));
  Serial.println(mpu.testConnection() ? F("MPU6050 connection successful") : F("MPU6050 connection failed"));

  // load and configure the DMP
  Serial.println(F("Initializing DMP..."));
  devStatus = mpu.dmpInitialize();

  // supply your own gyro offsets here, scaled for min sensitivity
  mpu.setXGyroOffset(51);
  mpu.setYGyroOffset(8);
  mpu.setZGyroOffset(21);
  mpu.setXAccelOffset(1150);
  mpu.setYAccelOffset(-50);
  mpu.setZAccelOffset(1060);
  // make sure it worked (returns 0 if so)
  if (devStatus == 0) {
    // Calibration Time: generate offsets and calibrate our MPU6050
    mpu.CalibrateAccel(6);
    mpu.CalibrateGyro(6);
    Serial.println();
    mpu.PrintActiveOffsets();
    // turn on the DMP, now that it's ready
    Serial.println(F("Enabling DMP..."));
    mpu.setDMPEnabled(true);

    // enable Arduino interrupt detection
    Serial.print(F("Enabling interrupt detection (Arduino external interrupt "));
    Serial.print(digitalPinToInterrupt(INTERRUPT_PIN));
    Serial.println(F(")..."));
    attachInterrupt(digitalPinToInterrupt(INTERRUPT_PIN), dmpDataReady, RISING);
    mpuIntStatus = mpu.getIntStatus();

    // set our DMP Ready flag so the main loop() function knows it's okay to use it
    Serial.println(F("DMP ready! Waiting for first interrupt..."));
    dmpReady = true;

    // get expected DMP packet size for later comparison
    packetSize = mpu.dmpGetFIFOPacketSize();
  } else {
    
    Serial.print(F("DMP Initialization failed (code "));
    Serial.print(devStatus);
    Serial.println(F(")"));
  }

  // configure LED for output
  pinMode(LED_PIN, OUTPUT);

  
}
void loop() {
      

//Module 2      
if (analogRead(analogPin) > 2397){
 batt = 'a';
}
if ((analogRead(analogPin) < 2397) && (analogRead(analogPin) > 2350) ){
 batt = 'b';
}
if ((analogRead(analogPin) < 2350) && (analogRead(analogPin) > 2300) ){
 batt = 'c';
}
if ((analogRead(analogPin) < 2300) && (analogRead(analogPin) > 2250) ){
 batt = 'd';
}
if ((analogRead(analogPin) < 2250) && (analogRead(analogPin) > 2200) ){
 batt = 'e';
}
if ((analogRead(analogPin) < 2200) && (analogRead(analogPin) > 2150) ){
 batt = 'f';
}
if ((analogRead(analogPin) < 2150) && (analogRead(analogPin) > 2100) ){
 batt = 'g';
}
if ((analogRead(analogPin) < 2100) && (analogRead(analogPin) > 2000) ){
 batt = 'h';
}
if ((analogRead(analogPin) < 2000) && (analogRead(analogPin) > 1950) ){
 batt = 'i';
}
if ((analogRead(analogPin) < 1950) && (analogRead(analogPin) > 1900) ){
 batt = 'j';
}
if (analogRead(analogPin) < 1900){
 batt = 'k';
}

//Module 1
if ((myData.BATT) > 2397){
 BATT = 'a';
}
if (((myData.BATT) < 2397) && ((myData.BATT) > 2350) ){
 BATT = 'b';
}
if (((myData.BATT) < 2350) && ((myData.BATT) > 2300) ){
 BATT = 'c';
}
if (((myData.BATT) < 2300) && ((myData.BATT) > 2250) ){
 BATT = 'd';
}
if (((myData.BATT) < 2250) && ((myData.BATT) > 2200) ){
 BATT = 'e';
}
if (((myData.BATT) < 2200) && ((myData.BATT) > 2150) ){
 BATT = 'f';
}
if (((myData.BATT) < 2150) && ((myData.BATT) > 2100) ){
 BATT = 'g';
}
if (((myData.BATT) < 2100) && ((myData.BATT) > 2000) ){
 BATT = 'h';
}
if (((myData.BATT) < 2000) && ((myData.BATT) > 1950) ){
 BATT = 'i';
}
if (((myData.BATT) < 1950) && ((myData.BATT) > 1900) ){
 BATT = 'j';
}
if ((myData.BATT) < 1900){
  BATT = 'k';
}

Serial.println(myData.BATT);
      
      
 /
  if (mpu.dmpGetCurrentFIFOPacket(fifoBuffer)) { // Get the Latest packet 


    #ifdef OUTPUT_TEAPOT
   
#endif
// At this point we are taking the motion data from Mod 1 that was transmiteed through ESP-NOW
//and copying it into the byte array that will be transmitted through BT
 Combined[9] = myData.teapotPacket[0];
 Combined[10] = myData.teapotPacket[1];
 Combined[11] = myData.teapotPacket[2];
 Combined[12] = myData.teapotPacket[3];
 Combined[13] = myData.teapotPacket[4];
 Combined[14] = myData.teapotPacket[5];
 Combined[15] = myData.teapotPacket[6];
 Combined[16] = myData.teapotPacket[7];

 
 //In this section we are copying the local motion data from Mod 2 and putting it into the 
 //packet byte array that will be transmitted through BT
 
 Combined[0] = teapotPacket[0];
 Combined[1] = teapotPacket[2];
 Combined[2] = teapotPacket[3];
 Combined[3] = teapotPacket[4];
 Combined[4] = teapotPacket[5];
 Combined[5] = teapotPacket[6];
 Combined[6] = teapotPacket[7];
 Combined[7] = teapotPacket[8];
 Combined[8] = teapotPacket[9];

 //This is where the battery percentages of the system get copyed onto the packet byte array that 
 //will get sent to processing over BT
 Combined[17] = batt;
 Combined[18] = BATT;

    
  }



ESP_BT.write(Combined, 19); //write to bluetooth serial   -----------------

val = ESP_BT.read(); //Reads any incoming data from processing, which allows processing to 
//send data i.e a button click, which the system will read and perform an action

sendData.control = val; //This will send any incoming data from processing to Mod 1

if (val=='1'){

  digitalWrite(32, HIGH);
}
else{
  digitalWrite(32, LOW);
}

if (val=='2'){

  digitalWrite(13, HIGH);
}
else{
  digitalWrite(13, LOW);
}
//sends data to Mod 1, in this case its the button clicks from processing i.e buzzer
esp_err_t result = esp_now_send(broadcastAddress, (uint8_t *) &sendData, sizeof(sendData));
  delay(25);
}
