//The void gui is to stop the ui from moving with the camera
void SetupButtons(){
  
  noStroke();
  
  cp5 = new ControlP5(this);  
  // change the default font to Verdana
 PFont p = createFont("Arial",15); 
 ControlFont font = new ControlFont(p);
 
 // change the original colors
 cp5.setColorForeground(0xff808080);
 cp5.setColorBackground(0xff008080); 
 cp5.setFont(font);
 cp5.setColorActive(0xffFFFFFF);
  
  //UI for Saving Data to CSV
  cp5.addButton("SaveAs").setPosition(50, 250).setSize(100, 55);
  cp5.addTextfield(" ").setPosition(155, 250).setSize(300, 55).setAutoClear(false);

  cp5.addButton("Record").setPosition(50, 325).setSize(200, 55);
  cp5.addButton("Stop_Record").setPosition(253, 325).setSize(205, 55);
  
  //UI for Replaying past CSV data
  cp5.addButton("ReadFile").setPosition(50, 450).setSize(100, 55);
  cp5.addTextfield("  ").setPosition(155, 450).setSize(300, 55).setAutoClear(false);
  
  cp5.addButton("Play").setPosition(50, 525).setSize(70, 55);
  cp5.addButton("Pause").setPosition(123, 525).setSize(70, 55);
  cp5.addButton("STOP").setPosition(196, 525).setSize(70, 55);
  
 
 //Test Buttons
  cp5.addButton("LED_ONE").setPosition(100, 700).setSize(120, 50);
  cp5.addButton("Buzzer_ONE").setPosition(100, 800).setSize(120, 50);
  
  
  cp5.addButton("LED_TWO").setPosition(250, 700).setSize(120, 50);
  cp5.addButton("Buzzer_TWO").setPosition(250, 800).setSize(120, 50);
  
  
  cp5.setAutoDraw(false);  
}




void gui() {
   
  hint(DISABLE_DEPTH_TEST);
  camera.beginHUD();
  textSize(25);
  color(255);
  text("" + nfc(frameRate, 2), 0, 20);
 
  textSize(18);
  
  text(("Module ONE (THIGH):" + "  (BATT: " + BATT_percent + ")" ), 20,50);  
  text(("YAW: ")+ypr[0]+("   PITCH: ")+ypr[1]+("   ROLL: ")+ypr[2], 20,75);
   
  text(("Module TWO (SPINE):" + "  (BATT: " + batt_percent + ")" ), 20,125); 
  text(("YAW: ")+YPR[0]+("   PITCH: ")+YPR[1]+("   ROLL: ")+YPR[2], 20,150);
  
  cp5.draw();
  camera.endHUD();
  hint(ENABLE_DEPTH_TEST);
}



//For Recording Data
void SaveAs() {   
 // println(" Pick a comport " );
 print("FileName:");
  text=cp5.get(Textfield.class, " ").getText();
  println(text);
}

void Record() {      
  record = '1';  
}

void Stop_Record() { 
  record = '0';  
}

//For Replay 
void Play() { 
  
}
void Pause() { 
  
}
void Stop() { 
  
}

//For Testing Buzzer and LED 
void LED_TWO() {
 port.write('2');
    port.write('2');
    port.write('2');
     port.write('2');
    port.write('2');
    port.write('2');
}

void Buzzer_TWO() {
port.write('1');
    port.write('1');
    port.write('1');
    port.write('1');
    port.write('1');
    port.write('1');
}

void LED_ONE() {
 port.write('4');
    port.write('4');
    port.write('4');
     port.write('4');
    port.write('4');
    port.write('4');
}

void Buzzer_ONE() {
port.write('3');
    port.write('3');
    port.write('3');
    port.write('3');
    port.write('3');
    port.write('3');
}
