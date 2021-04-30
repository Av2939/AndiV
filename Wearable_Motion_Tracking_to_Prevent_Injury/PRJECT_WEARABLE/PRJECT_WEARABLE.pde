// I2C device class (I2Cdev) demonstration Processing sketch for MPU6050 DMP output
import peasy.*;
import processing.serial.*;
import processing.opengl.*;
import toxi.geom.*;
import toxi.processing.*;
import controlP5.*;
import java.util.Scanner;

//z
PeasyCam camera;
ToxiclibsSupport gfx;
ControlP5 cp5;
Table table;

Serial port;                         // The serial port
char[] teapotPacket = new char[19];  // InvenSense Teapot packet
int serialCount = 0;                 // current packet byte position
int aligned = 0;

int interval = 0;
//DA - added the variable below to fix byte alignment over the Serial port
boolean gotFirstDataByte = false;

float[] q = new float[4];
float[] Q = new float[4];
Quaternion quat = new Quaternion(1, 0, 0, 0);
Quaternion QUAT = new Quaternion(1, 0, 0, 0);

float[] gravity = new float[3];
float[] GRAVITY = new float[3];


float[] euler = new float[3];
float[] EULER = new float[3];


float[] ypr = new float[3];
float[] YPR = new float[3];

char batt;
char BATT;

String batt_percent;
String BATT_percent;

char record;

String text;

void setup() {
    
    
  // 300px square viewport using OpenGL rendering
    size(1920, 1080, OPENGL);
    gfx = new ToxiclibsSupport(this);
camera = new PeasyCam(this, width/2, height/2, 0, 1000);
    // setup lights and antialiasing
    
  
    // display serial port list for debugging/clarity
    //println(Serial.list());

    // get the first available port (use EITHER this OR the specific port code below)
    // DA - changed the port to second one in the list (for my laptop)
    //String portName = Serial.list()[1];
    
    // get a specific serial port (use EITHER this OR the first-available code above)
    String portName = "COM3";
    
    // open the serial port
    //DA - changed the serial data rate to 38400
    port = new Serial(this, portName, 115200);
   
    // send single character to trigger DMP init/start
    // (expected by MPU6050_DMP6 example Arduino sketch)
    
    //DA - I added two more of these because the program seems to hang otherwise
    //port.write('r');
    //port.write('r');
  SetupButtons();
  SetupCSV();
}

void draw() {
  /*
  if (millis() - interval > 1000) {
        // resend single character to trigger DMP init/start
        // in case the MPU is halted/reset while applet is running
        port.write('r');
        interval = millis();
    }
    */
    
    
    // white background
    background(0);
    lights();
    smooth();
  
    
   stroke(0, 255, 255); // set outline colour to darker teal
   noFill();
  
  Spine();
  LeftThigh();
  //RightThigh();
  Hip();
  
  
  gui();
 CSV();
  
}





/*


//------Will be deleted once the UI is fully completed ---------
void keyPressed() {
  // If the return key is pressed, save the String and clear it
  if (key == '\n' ) {
  
    port.write('1');
    port.write('1');
    port.write('1');
     port.write('1');
    port.write('1');
    port.write('1');
  }
  if (key == 'a' ) {
  
    port.write('2');
    port.write('2');
    port.write('2');
     port.write('2');
    port.write('2');
    port.write('2');
  }
  
  if (key == 's' ) {
  
    port.write('3');
    port.write('3');
    port.write('3');
    port.write('3');
    port.write('3');
    port.write('3');
  }
  
  
   // port.write('1');
   // port.write("\r");
    // A String can be cleared by setting it equal to ""
    
  
}

*/
