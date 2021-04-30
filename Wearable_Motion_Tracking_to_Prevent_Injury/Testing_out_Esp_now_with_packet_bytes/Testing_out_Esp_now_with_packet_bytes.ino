#include <esp_now.h>
#include <WiFi.h>
#include "BluetoothSerial.h"
/*
#if !defined(CONFIG_BT_ENABLED) || !defined(CONFIG_BLUEDROID_ENABLED)
#error Bluetooth is not enabled! Please run `make menuconfig` to and enable it
#endif
*/
BluetoothSerial ESP_BT; //Initalized BT that will be connect the whole system to a Bluetooth serial monitor.
uint8_t broadcastAddress[] = {0x7C, 0x9E, 0xBD, 0xD3, 0x02, 0xC4};

typedef struct struct_message {
   uint8_t teapotPacket[14];
   
} struct_message;

// Create a struct_message called myData
struct_message myData;


// callback function that will be executed when data is received
void OnDataRecv(const uint8_t * mac, const uint8_t *incomingData, int len) {
  memcpy(&myData, incomingData, sizeof(myData));
ESP_BT.write(myData.teapotPacket, 14);
}

void setup() {
  //----------------WIFI and BT initalizng stuff--------------------------------
ESP_BT.begin("PRJECT_WEARABLE");   
Serial.begin(115200);
   // Set device as a Wi-Fi Station
  WiFi.mode(WIFI_STA);

  // Init ESP-NOW
  if (esp_now_init() != ESP_OK) {
    return;
  }
// Once ESPNow is successfully Init, we will register for Send CB to
  // get the status of Trasnmitted packet
 
  
  // Once ESPNow is successfully Init, we will register for recv CB to
  // get recv packer info
  esp_now_register_recv_cb(OnDataRecv);

    // Register peer
  esp_now_peer_info_t peerInfo;
  memcpy(peerInfo.peer_addr, broadcastAddress, 6);
  peerInfo.channel = 0;  
  peerInfo.encrypt = false;
  
  // Add peer        
  if (esp_now_add_peer(&peerInfo) != ESP_OK){
    return;
  }
}
void loop() {

//Serial.write(myData.teapotPacket, 14);

    


  delay(40);
}
