void Spine(){
  pushMatrix();
  translate(1170,height/2,250); //sets location of object
   float c= 0.5;
  float b= 0.2;
  float a= .2; 
  quat.set(Q[0], Q[1], Q[2], Q[3]);
  float[] axiS = quat.toAxisAngle();
    rotate(axiS[0], -axiS[2], axiS[3], -axiS[1]);
    box(1);
    translate(0,0,-100*c); //this second translate will change the axis origin of a 3D object
     //note to invert the origin, use -100 or 700 in the z-axis of the translate. For now
     //a value of 700 will be used for the thigh and a value of -100 will be used for the spine.
 beginShape();
  vertex(-100*a, -100*b, -100*c);
  vertex( 100*a, -100*b, -100*c);
  vertex(   0*a,    0*b,  100*c);
  
  vertex( 100*a, -100*b, -100*c);
  vertex( 100*a,  100*b, -100*c);
  vertex(   0*a,    0*b,  100*c);
  
  vertex( 100*a, 100*b, -100*c);
  vertex(-100*a, 100*b, -100*c);
  vertex(   0*a,   0*b,  100*c);
  
  vertex(-100*a,  100*b, -100*c);
  vertex(-100*a, -100*b, -100*c);
  vertex(   0*a,    0*b,  100*c);
  
  vertex(-100*a,  100*b, -100*c);
  vertex(-100*a, -100*b, -100*c);
  vertex(   0*a,    0*b,  100*c);
  
 
  endShape(CLOSE);
  
  translate(0,0,-300*c);
  box(200*a,200*b,400*c);
  
  
  translate(0, 0, -300*c);
  beginShape();
  
  vertex(100*a, 100*b, 100*c);
  vertex( -100*a, 100*b, 100*c);
  vertex(   0*a,    0*b,  -100*c);
   
  vertex( -100*a, 100*b, 100*c);
  vertex( -100*a,  -100*b, 100*c);
  vertex(   0*a,    0*b,  -100*c);
   
  vertex( -100*a, -100*b, 100*c);
  vertex(100*a, -100*b, 100*c);
  vertex(   0*a,   0*b,  -100*c);
  
  
  vertex(100*a,  -100*b, 100*c);
  vertex(100*a, 100*b, 100*c);
  vertex(   0*a,    0*b,  -100*c);
    
  vertex(100*a,  -100*b, 100*c);
  vertex(100*a, 100*b, 100*c);
  vertex(   0*a,    0*b,  -100*c);
  
  endShape(CLOSE);
  
  
  Shoulders();
  
  popMatrix();
}

void Shoulders(){
  
  translate(0,0,-60);
  box(400,5,5);
  
  
  
  
}

//maybe if i make seperate axis for the hip it might work
void Hip(){
  pushMatrix();
  translate(1170,height/2,250);
 //rotateX(radians(euler[0])*(180/PI));
 //rotateY(-(radians(euler[1])*(180/PI)));

 //quat.set(q[0], q[1], q[2], q[3]);
  //quat.set(q[0], 0, 0, q[3]);
  //float[] axis = quat.toAxisAngle();
// rotate(axis[0], -axis[2], axis[3], -axis[1]); // Weirdly enough, this kind of works however after 2.7 to -2.5 it bugs out
 //So the rotate y works from 0 to 2pi, the values given from the mpu 6050 hower go negative.....
 //So from some testing, axis[0]*axis[3] works from 0.0 to 2.5, 
                                                  //2.5 to 0.0, 
                                                  //0.0 to -2.5, 
                                                  //-2.5 to 0.0, 
                                                  //0.0 to 2.5
 
 
 //println("  Axis 0&3:  "+axis[0]*axis[3]); //testing
 
 //rotateZ(radians(euler[2])*(180/PI));
  //box(20,20,500);
  // RightThigh();
   //LeftThigh();
  popMatrix();
  
}



void RightThigh(){
  pushMatrix();
  translate((1170), height/2, 0); //sets location of object
  //translate(0, 0, 250);
  
  float c= 0.5;
  float b= 0.2;
  float a= .2; 
  quat.set(q[0], q[1], q[2], q[3]);
  float[] axis = quat.toAxisAngle();
    rotate(axis[0], -axis[2], axis[3], -axis[1]);
    
    
    
    box(1);
    translate(0,0,700*c); //this second translate will change the axis origin of a 3D object
     //note to invert the origin, use -100 or 700 in the z-axis of the translate. For now
     //a value of 700 will be used for the thigh and a value of -100 will be used for the spine.
  beginShape();
  vertex(-100*a, -100*b, -100*c);
  vertex( 100*a, -100*b, -100*c);
  vertex(   0*a,    0*b,  100*c);
  
  vertex( 100*a, -100*b, -100*c);
  vertex( 100*a,  100*b, -100*c);
  vertex(   0*a,    0*b,  100*c);
  
  vertex( 100*a, 100*b, -100*c);
  vertex(-100*a, 100*b, -100*c);
  vertex(   0*a,   0*b,  100*c);
  
  vertex(-100*a,  100*b, -100*c);
  vertex(-100*a, -100*b, -100*c);
  vertex(   0*a,    0*b,  100*c);
  
  vertex(-100*a,  100*b, -100*c);
  vertex(-100*a, -100*b, -100*c);
  vertex(   0*a,    0*b,  100*c);
  
 
  endShape(CLOSE);
  
  translate(0,0,-300*c);
  box(200*a,200*b,400*c);
  
  
  translate(0, 0, -300*c);
  beginShape();
  
  vertex(100*a, 100*b, 100*c);
  vertex( -100*a, 100*b, 100*c);
  vertex(   0*a,    0*b,  -100*c);
   
  vertex( -100*a, 100*b, 100*c);
  vertex( -100*a,  -100*b, 100*c);
  vertex(   0*a,    0*b,  -100*c);
   
  vertex( -100*a, -100*b, 100*c);
  vertex(100*a, -100*b, 100*c);
  vertex(   0*a,   0*b,  -100*c);
  
  
  vertex(100*a,  -100*b, 100*c);
  vertex(100*a, 100*b, 100*c);
  vertex(   0*a,    0*b,  -100*c);
    
  vertex(100*a,  -100*b, 100*c);
  vertex(100*a, 100*b, 100*c);
  vertex(   0*a,    0*b,  -100*c);
  
  endShape(CLOSE);
  
  //txt on object
  textSize(25);
  //fill(0, 255, 255);
  text(" RIGHT_Thigh", -183, 10, 101);
  
  popMatrix(); // end of object
}

void RightShin(){
  
}


void LeftThigh(){
  pushMatrix();
  
  translate(1170, height/2, 250); //sets location of object
  //translate(0, 0, -250);
  //sets scale of object
  float c= 0.5;
  float b= 0.2;
  float a= .2; 
  quat.set(q[0], q[1], q[2], q[3]);
  float[] axis = quat.toAxisAngle();
    rotate(axis[0], -axis[2], axis[3], -axis[1]);
    box(300,50,50); //hip
    translate(0,0,700*c); //this second translate will change the axis origin of a 3D object
     //note to invert the origin, use -100 or 700 in the z-axis of the translate. For now
     //a value of 700 will be used for the thigh and a value of -100 will be used for the spine.
  beginShape();
  vertex(-100*a, -100*b, -100*c);
  vertex( 100*a, -100*b, -100*c);
  vertex(   0*a,    0*b,  100*c);
  
  vertex( 100*a, -100*b, -100*c);
  vertex( 100*a,  100*b, -100*c);
  vertex(   0*a,    0*b,  100*c);
  
  vertex( 100*a, 100*b, -100*c);
  vertex(-100*a, 100*b, -100*c);
  vertex(   0*a,   0*b,  100*c);
  
  vertex(-100*a,  100*b, -100*c);
  vertex(-100*a, -100*b, -100*c);
  vertex(   0*a,    0*b,  100*c);
  
  vertex(-100*a,  100*b, -100*c);
  vertex(-100*a, -100*b, -100*c);
  vertex(   0*a,    0*b,  100*c);
  
 
  endShape(CLOSE);
  
  translate(0,0,-300*c);
  box(200*a,200*b,400*c);
  
  
  translate(0, 0, -300*c);
  beginShape();
  
  vertex(100*a, 100*b, 100*c);
  vertex( -100*a, 100*b, 100*c);
  vertex(   0*a,    0*b,  -100*c);
   
  vertex( -100*a, 100*b, 100*c);
  vertex( -100*a,  -100*b, 100*c);
  vertex(   0*a,    0*b,  -100*c);
   
  vertex( -100*a, -100*b, 100*c);
  vertex(100*a, -100*b, 100*c);
  vertex(   0*a,   0*b,  -100*c);
  
  
  vertex(100*a,  -100*b, 100*c);
  vertex(100*a, 100*b, 100*c);
  vertex(   0*a,    0*b,  -100*c);
    
  vertex(100*a,  -100*b, 100*c);
  vertex(100*a, 100*b, 100*c);
  vertex(   0*a,    0*b,  -100*c);
  
  endShape(CLOSE);
  
    //txt on object
  textSize(25);
  //fill(0, 255, 255);
  text(" LEFT_Thigh", 0, 0, 150);
  
  popMatrix();
}

void LeftShin(){
  
  
}
