void SetupCSV() {
  
  table = new Table();
  
  table.addColumn("q[0]");
  table.addColumn("q[1]");
  table.addColumn("q[2]");
  table.addColumn("q[3]");
  
  table.addColumn("Q[0]");
  table.addColumn("Q[1]");
  table.addColumn("Q[2]");
  table.addColumn("Q[3]");
  
  table.addColumn("ypr[0]");
  table.addColumn("ypr[1]");
  table.addColumn("ypr[2]");
  
  
  table.addColumn("YPR[0]");
  table.addColumn("YPR[1]");
  table.addColumn("YPR[2]");
   
}

void CSV() {
 if (record == '1') {
  TableRow newRow = table.addRow();
  

  newRow.setFloat("q[0]", q[0]);
  newRow.setFloat("q[1]", q[1]);
  newRow.setFloat("q[2]", q[2]);
  newRow.setFloat("q[3]", q[3]);
  
  newRow.setFloat("Q[0]", Q[0]);
  newRow.setFloat("Q[1]", Q[1]);
  newRow.setFloat("Q[2]", Q[2]);
  newRow.setFloat("Q[3]", Q[3]);
  
  newRow.setFloat("ypr[0]", ypr[0]);
  newRow.setFloat("ypr[1]", ypr[1]);
  newRow.setFloat("ypr[2]", ypr[2]);
  
  
  newRow.setFloat("YPR[0]", YPR[0]);
  newRow.setFloat("YPR[1]", YPR[1]);
  newRow.setFloat("YPR[2]", YPR[2]);
 saveTable(table, "data/"+text);
  
 }
 
 if (record == '0') {
    
   
 }
 
 
 


  
  
 
  
  
  
}
