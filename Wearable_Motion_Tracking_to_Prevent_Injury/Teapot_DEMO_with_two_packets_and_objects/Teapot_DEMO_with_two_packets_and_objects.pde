// I2C device class (I2Cdev) demonstration Processing sketch for MPU6050 DMP output
import peasy.*;

PeasyCam camera;

import processing.serial.*;
import processing.opengl.*;
import toxi.geom.*;
import toxi.processing.*;

// NOTE: requires ToxicLibs to be installed in order to run properly.
// 1. Download from http://toxiclibs.org/downloads
// 2. Extract into [userdir]/Processing/libraries
//    (location may be different on Mac/Linux)
// 3. Run and bask in awesomeness

ToxiclibsSupport gfx;



Serial port;                         // The serial port
char[] teapotPacket = new char[28];  // InvenSense Teapot packet
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
float[] euler = new float[3];
float[] ypr = new float[3];

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
    background(255);
    lights();
    smooth();
  
    
   stroke(0, 255, 255); // set outline colour to darker teal
   noFill();
  print("Yaw:"+ypr[0]);
  print("  Pitch:"+ypr[1]);
  println("  Roll:"+ypr[2]);
  drawThighLeft();
  drawSpine();
  yeet();

 camera.beginHUD(); //Use this to make UI static
  fill(0, 128);
  rect(0, 0, 400,1900 );
  text("" + nfc(frameRate, 2), 10, 18);
  camera.endHUD();
  
}

void serialEvent(Serial port) {

    interval = millis();
    while (port.available() > 0) {
        int ch = port.read();
         //print((char)ch);
        // DA - Added this next if statement because we seem to be getting 
        //  off byte boundary with initialization warnings
        if(!gotFirstDataByte) {
          if (ch == '$') {
            gotFirstDataByte = true;
          } else {
            return;
          }
        }
        
        
        //println("Char: " + (char)ch);
        //println((char)ch + " " + aligned + " " + serialCount);
        if (aligned < 4) {
            // make sure we are properly aligned on a 14-byte packet
            if (serialCount == 0) {
                if (ch == '$') aligned++; else aligned = 0;
            } else if (serialCount == 1) {
                if (ch == 2) aligned++; else aligned = 0;
            } else if (serialCount == 12) {
                if (ch == '\r') aligned++; else aligned = 0;
            } else if (serialCount == 13) {
                if (ch == '\n') aligned++; else aligned = 0;
            }
            //println((char)ch + " " + aligned + " " + serialCount);
            serialCount++;
            if (serialCount == 28) serialCount = 0;
             println(serialCount);
        } else {
            if (serialCount > 0 || ch == '$') {
                teapotPacket[serialCount++] = (char)ch;
                if (serialCount == 28) {
                    serialCount = 0; // restart packet byte position
                    
                    // get quaternion from data packet
                    Q[0] = ((teapotPacket[2] << 8) | teapotPacket[3]) / 16384.0f;
                    Q[1] = ((teapotPacket[4] << 8) | teapotPacket[5]) / 16384.0f;
                    Q[2] = ((teapotPacket[6] << 8) | teapotPacket[7]) / 16384.0f;
                    Q[3] = ((teapotPacket[8] << 8) | teapotPacket[9]) / 16384.0f;
                    for (int i = 0; i < 4; i++) if (Q[i] >= 2) Q[i] = -4 + Q[i];
                    
                    q[0] = ((teapotPacket[16] << 8) | teapotPacket[17]) / 16384.0f;
                    q[1] = ((teapotPacket[18] << 8) | teapotPacket[19]) / 16384.0f;
                    q[2] = ((teapotPacket[20] << 8) | teapotPacket[21]) / 16384.0f;
                    q[3] = ((teapotPacket[22] << 8) | teapotPacket[23]) / 16384.0f;
                    for (int i = 0; i < 4; i++) if (q[i] >= 2) q[i] = -4 + q[i];
                    
                    // set our toxilibs quaternion to new data
                   

                    
                    // below calculations unnecessary for orientation only using toxilibs
                    
                    // calculate gravity vector
                    gravity[0] = 2 * (q[1]*q[3] - q[0]*q[2]);
                    gravity[1] = 2 * (q[0]*q[1] + q[2]*q[3]);
                    gravity[2] = q[0]*q[0] - q[1]*q[1] - q[2]*q[2] + q[3]*q[3];
        
                    // calculate Euler angles
                    euler[0] = atan2(2*q[1]*q[2] - 2*q[0]*q[3], 2*q[0]*q[0] + 2*q[1]*q[1] - 1);
                    euler[1] = -asin(2*q[1]*q[3] + 2*q[0]*q[2]);
                    euler[2] = atan2(2*q[2]*q[3] - 2*q[0]*q[1], 2*q[0]*q[0] + 2*q[3]*q[3] - 1);
        
                    // calculate yaw/pitch/roll angles
                    ypr[0] = atan2(2*q[1]*q[2] - 2*q[0]*q[3], 2*q[0]*q[0] + 2*q[1]*q[1] - 1);
                    ypr[1] = atan(gravity[0] / sqrt(gravity[1]*gravity[1] + gravity[2]*gravity[2]));
                    ypr[2] = atan(gravity[1] / sqrt(gravity[0]*gravity[0] + gravity[2]*gravity[2]));
        
                    // output various components for debugging
                    //println("q:\t" + round(q[0]*100.0f)/100.0f + "\t" + round(q[1]*100.0f)/100.0f + "\t" + round(q[2]*100.0f)/100.0f + "\t" + round(q[3]*100.0f)/100.0f);
                    //println("euler:\t" + euler[0]*180.0f/PI + "\t" + euler[1]*180.0f/PI + "\t" + euler[2]*180.0f/PI);
                    //println("ypr:\t" + ypr[0]*180.0f/PI + "\t" + ypr[1]*180.0f/PI + "\t" + ypr[2]*180.0f/PI);
                    
                }
            }
        }
    }
}



void drawThighLeft()
{
 

  pushMatrix(); // begin object
   quat.set(q[0], q[1], q[2], q[3]);
  translate(width /1.5, height/2);
  float[] axis = quat.toAxisAngle();
  rotate(axis[0], -axis[2], axis[3], -axis[1]);
  
   translate(0,0,35); //this second translate will change the axis origin of a 3D object
   box(50,30,70);
  
  textSize(25);
  //fill(0, 255, 255);
  text(" LeftThigh", -183, 10, 101);
  popMatrix(); // end of object

}


void drawSpine()
{
 

  pushMatrix(); // begin object
   quat.set(Q[0], Q[1], Q[2], Q[3]);
     translate(width /1.5, height/2); //sets location of object
  float[] axiS = quat.toAxisAngle();
    rotate(axiS[0], -axiS[2], axiS[3], -axiS[1]);
    translate(0,0,-35); //this second translate will change the axis origin of a 3D object
    box(50,30,70);
  
  textSize(25);
  //fill(0, 255, 255);
  text("Spine", -183, 10, 101);
  popMatrix(); // end of object

}

void yeet(){
  push();
  translate((width/3), height/2); //sets location of object
  float a= .2;
  float[] axiS = quat.toAxisAngle();
    rotate(axiS[0], -axiS[2], axiS[3], -axiS[1]);
    translate(0,0,-35); //this second translate will change the axis origin of a 3D object
  beginShape();
  vertex(-100*a, -100*a, -100*a);
  vertex( 100*a, -100*a, -100*a);
  vertex(   0*a,    0*a,  100*a);
  
  vertex( 100*a, -100*a, -100*a);
  vertex( 100*a,  100*a, -100*a);
  vertex(   0*a,    0*a,  100*a);
  
  vertex( 100*a, 100*a, -100*a);
  vertex(-100*a, 100*a, -100*a);
  vertex(   0*a,   0*a,  100*a);
  
  vertex(-100*a,  100*a, -100*a);
  vertex(-100*a, -100*a, -100*a);
  vertex(   0*a,    0*a,  100*a);
  
  vertex(-100*a,  100*a, -100*a);
  vertex(-100*a, -100*a, -100*a);
  vertex(   0*a,    0*a,  100*a);
  
 
  endShape(CLOSE);
  
  translate(0,0,-300*a);
  box(200*a,200*a,400*a);
  
  
  translate(0, 0, -300*a);
  beginShape();
  
  vertex(100*a, 100*a, 100*a);
  vertex( -100*a, 100*a, 100*a);
  vertex(   0*a,    0*a,  -100*a);
   
  vertex( -100*a, 100*a, 100*a);
  vertex( -100*a,  -100*a, 100*a);
  vertex(   0*a,    0*a,  -100*a);
   
  vertex( -100*a, -100*a, 100*a);
  vertex(100*a, -100*a, 100*a);
  vertex(   0*a,   0*a,  -100*a);
  
  
  vertex(100*a,  -100*a, 100*a);
  vertex(100*a, 100*a, 100*a);
  vertex(   0*a,    0*a,  -100*a);
    
  vertex(100*a,  -100*a, 100*a);
  vertex(100*a, 100*a, 100*a);
  vertex(   0*a,    0*a,  -100*a);
  
  endShape(CLOSE);
  
  
  pop();
}
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
