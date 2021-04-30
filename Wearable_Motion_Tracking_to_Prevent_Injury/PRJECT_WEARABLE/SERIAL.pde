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
      /*  if (aligned < 4) {
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
            if (serialCount == 30) serialCount = 0;
             //println(serialCount);
        } else {*/
            if (serialCount > 0 || ch == '$') {
                teapotPacket[serialCount++] = (char)ch;
                if (serialCount == 19) {
                    serialCount = 0; // restart packet byte position
                    
                    // get quaternion from data packet
                    Q[0] = ((teapotPacket[1] << 8) | teapotPacket[2]) / 16384.0f;
                    Q[1] = ((teapotPacket[3] << 8) | teapotPacket[4]) / 16384.0f;
                    Q[2] = ((teapotPacket[5] << 8) | teapotPacket[6]) / 16384.0f;
                    Q[3] = ((teapotPacket[7] << 8) | teapotPacket[8]) / 16384.0f;
                    for (int i = 0; i < 4; i++) if (Q[i] >= 2) Q[i] = -4 + Q[i];
                    
                    q[0] = ((teapotPacket[9] << 8) | teapotPacket[10]) / 16384.0f;
                    q[1] = ((teapotPacket[11] << 8) | teapotPacket[12]) / 16384.0f;
                    q[2] = ((teapotPacket[13] << 8) | teapotPacket[14]) / 16384.0f;
                    q[3] = ((teapotPacket[15] << 8) | teapotPacket[16]) / 16384.0f;
                    for (int i = 0; i < 4; i++) if (q[i] >= 2) q[i] = -4 + q[i];
                    
                    // set our toxilibs quaternion to new data
                    batt = teapotPacket[17];
                    BATT = teapotPacket[18];
                   
                   //Mod 2
                   if (batt == 'a'){
                     batt_percent = "Charged";         
                   }
                   if (batt == 'b'){
                     batt_percent = "100%";
                     
                   }
                   if (batt == 'c'){
                     batt_percent = "90%";
                     
                   }
                   if (batt == 'd'){
                     batt_percent = "80%";
                     
                   }
                    if (batt == 'e'){
                     batt_percent = "70%";         
                   }
                   if (batt == 'f'){
                     batt_percent = "60%";
                     
                   }
                   if (batt == 'g'){
                     batt_percent = "50%";
                     
                   }
                   if (batt == 'h'){
                     batt_percent = "40%";
                     
                   }
                    if (batt == 'i'){
                     batt_percent = "30%";         
                   }
                   if (batt == 'j'){
                     batt_percent = "20%";
                     
                   }
                   if (batt == 'k'){
                     batt_percent = "10%";
                     
                   }
                  
                   
                   //Mod 1
                    if (BATT == 'a'){
                     BATT_percent = "Charged";         
                   }
                   if (BATT == 'b'){
                     BATT_percent = "100%";
                     
                   }
                   if (BATT == 'c'){
                     BATT_percent = "90%";
                     
                   }
                   if (BATT == 'd'){
                     BATT_percent = "80%";
                     
                   }
                    if (BATT == 'e'){
                     BATT_percent = "70%";         
                   }
                   if (BATT == 'f'){
                     BATT_percent = "60%";
                     
                   }
                   if (BATT == 'g'){
                     BATT_percent = "50%";
                     
                   }
                   if (BATT == 'h'){
                     BATT_percent = "40%";
                     
                   }
                    if (BATT == 'i'){
                     BATT_percent = "30%";         
                   }
                   if (BATT == 'j'){
                     BATT_percent = "20%";
                     
                   }
                   if (BATT == 'k'){
                     BATT_percent = "10%";
                     
                   }
                  
                
               
                   // println(batt);
                    
                    // below calculations unnecessary for orientation only using toxilibs
                    
                    // calculate gravity vector
                    gravity[0] = 2 * (q[1]*q[3] - q[0]*q[2]);
                    gravity[1] = 2 * (q[0]*q[1] + q[2]*q[3]);
                    gravity[2] = q[0]*q[0] - q[1]*q[1] - q[2]*q[2] + q[3]*q[3];
                     
                    GRAVITY[0] = 2 * (Q[1]*Q[3] - Q[0]*Q[2]);
                    GRAVITY[1] = 2 * (Q[0]*Q[1] + Q[2]*Q[3]);
                    GRAVITY[2] = Q[0]*Q[0] - Q[1]*Q[1] - Q[2]*Q[2] + Q[3]*Q[3];
        
        
                    // calculate Euler angles
                    euler[0] = atan2(2*q[1]*q[2] - 2*q[0]*q[3], 2*q[0]*q[0] + 2*q[1]*q[1] - 1);
                    euler[1] = -asin(2*q[1]*q[3] + 2*q[0]*q[2]);
                    euler[2] = atan2(2*q[2]*q[3] - 2*q[0]*q[1], 2*q[0]*q[0] + 2*q[3]*q[3] - 1);
                    
                    EULER[0] = atan2(2*Q[1]*Q[2] - 2*Q[0]*Q[3], 2*Q[0]*Q[0] + 2*Q[1]*Q[1] - 1);
                    EULER[1] = -asin(2*Q[1]*Q[3] + 2*Q[0]*Q[2]);
                    EULER[2] = atan2(2*Q[2]*Q[3] - 2*Q[0]*Q[1], 2*Q[0]*Q[0] + 2*Q[3]*Q[3] - 1);
        
        
        
                    // calculate yaw/pitch/roll angles
                    ypr[0] = (atan2(2*q[1]*q[2] - 2*q[0]*q[3], 2*q[0]*q[0] + 2*q[1]*q[1] - 1))*180/PI;
                    ypr[1] = (atan(gravity[0] / sqrt(gravity[1]*gravity[1] + gravity[2]*gravity[2])))*180/PI;
                    ypr[2] = (atan(gravity[1] / sqrt(gravity[0]*gravity[0] + gravity[2]*gravity[2])))*180/PI;
        
                    YPR[0] = (atan2(2*Q[1]*Q[2] - 2*Q[0]*Q[3], 2*Q[0]*Q[0] + 2*Q[1]*Q[1] - 1))*180/PI;
                    YPR[1] = (atan(GRAVITY[0] / sqrt(GRAVITY[1]*GRAVITY[1] + GRAVITY[2]*GRAVITY[2])))*180/PI;
                    YPR[2] = (atan(GRAVITY[1] / sqrt(GRAVITY[0]*GRAVITY[0] + GRAVITY[2]*GRAVITY[2])))*180/PI;
                 
                    
                    
                    
                    // output various components for debugging
                    //println("q:\t" + round(q[0]*100.0f)/100.0f + "\t" + round(q[1]*100.0f)/100.0f + "\t" + round(q[2]*100.0f)/100.0f + "\t" + round(q[3]*100.0f)/100.0f);
                    //println("euler:\t" + euler[0]*180.0f/PI + "\t" + euler[1]*180.0f/PI + "\t" + euler[2]*180.0f/PI);
                    //println("ypr:\t" + ypr[0]*180.0f/PI + "\t" + ypr[1]*180.0f/PI + "\t" + ypr[2]*180.0f/PI);
                    
                }
            //}
        }
    }
}
