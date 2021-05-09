
import peasy.*;
import processing.serial.*;
import processing.opengl.*;
import toxi.geom.*;
import toxi.processing.*;
import controlP5.*;
import java.util.Scanner;

//A few variables may be named the same with a difference in being no Cap and caps. The variables that have all caps are going to be associated with data pertaining to Mod 1, and variables all lowercased
// will pertain to data from Mod2
PeasyCam camera;
ToxiclibsSupport gfx;
ControlP5 cp5;
Table table;

Serial port;                         // The serial port
char[] teapotPacket = new char[19];  // InvenSense Teapot packet
int serialCount = 0;                 // current packet byte position
int aligned = 0;

int interval = 0;

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

char batt; //Mod 2
char BATT; //Mod 1

String batt_percent;
String BATT_percent;

char record;

String text;

void setup() {
    
    
  // Sets window size for program, note the UI was based off of a 1080p, if your screen has a lower resolution, there might be issues with scaling
    size(1920, 1080, OPENGL);
    gfx = new ToxiclibsSupport(this);
camera = new PeasyCam(this, width/2, height/2, 0, 1000);
  
    //Enter the serial port, note linux and MAC OS use a different way of naming their com ports
    String portName = "COM3";
    
   //If the comport is over BT, the Buad rate will not matter. However, if it is a wired connection change it. 
    port = new Serial(this, portName, 115200);
   
    
  SetupButtons();
  SetupCSV();
}

void draw() {

    
    
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
