import uibooster.*;
import uibooster.components.*;
import uibooster.model.*;
import uibooster.model.formelements.*;
import uibooster.model.options.*;
import uibooster.utils.*;

import processing.serial.*;
import java.io.FileWriter;
import java.io.BufferedWriter;

final int TEXT_SIZE = 22;
final color DivisionColor = color(255, 255, 255);
final color SensorColor = color(255, 255, 0);
final int LF = 10;

int NotConnectedToRS232 = 0, nCol = 1, nRow = 1, svReadingFrequency = 1000, svDumpFile, svDateTime;
String svFieldSeparator, svFilename;

PFont ArialBold;

Serial SPConn;
String inString; 
String SensorData;
JSONObject SerialPortConfig, SensorViewerConfig;
JSONArray ParameterList;

void setup () {

  size(800, 600);
  background(0);
  
  surface.setTitle("SensorViewer 1.0.   Q - Quit, P - Pause, R - Resume");
  surface.setResizable(false);
  //PImage icon = loadImage("icon.png");
  //surface.setIcon(icon);
  
  ProgressDialog InitDialog = new UiBooster().showProgressDialog("Starting SensorViewer", "Waiting", 0, 100);
  delay(3000);
 
  ArialBold   = createFont("TimesNewRomanPS-BoldMT", TEXT_SIZE);
  textFont(ArialBold);
  fill(SensorColor);

  InitDialog.setProgress(33);
  InitDialog.setMessage("Loading configurations");
  delay(3000);
  
  SerialPortConfig = loadJSONObject("serialport.json");
  String spSerialPort = SerialPortConfig.getString("SerialPort");
  println("Serial port: ", spSerialPort);
  int spBaudRate = SerialPortConfig.getInt("BaudRate");
  int spDataBits = SerialPortConfig.getInt("DataBits");
  int spStopBits = SerialPortConfig.getInt("StopBits");
  String spParity = SerialPortConfig.getString("Parity");
  
  SensorViewerConfig = loadJSONObject("sensorviewer.json");
  svReadingFrequency = SensorViewerConfig.getInt("Reading_Frequency");
  svFieldSeparator = SensorViewerConfig.getString("Field_Separator"); 
  svDumpFile = SensorViewerConfig.getInt("Dumpfile");
  svFilename = SensorViewerConfig.getString("Finlename"); 
  svDateTime = SensorViewerConfig.getInt("AddDateAndTime");
  
  ParameterList = loadJSONArray("parameters.json");

  try {
    InitDialog.setProgress(66);
    InitDialog.setMessage("Connecting to the serial port");
    SPConn = new Serial(this, spSerialPort, spBaudRate);
    delay(3000);
    SPConn.bufferUntil(LF);
  }
  catch(Exception e) {
    NotConnectedToRS232 = 1;
    super.exit();
    new UiBooster().showErrorDialog("Could not connect to serial port", "ERROR");
    e.printStackTrace();  
  }
  
  if (NotConnectedToRS232 == 1)
    InitDialog.setMessage("Closing SensorViewer");
  else
    InitDialog.setMessage("SensorViewer Started");
  InitDialog.setProgress(100);
  delay(3000);
  InitDialog.close();

}


void draw() {

  background(0);

  nCol = 0;
  nRow = 150;
  
  stroke(DivisionColor);
  line(0, nRow - 30, 800, nRow - 30);
  
  String[] PList = split(inString, svFieldSeparator);
  for (int iParam = 0; iParam < ParameterList.size(); iParam++) {
    JSONObject Parameter = ParameterList.getJSONObject(iParam); 
    String ParameterName = Parameter.getString("parameter");
    String ParameterUnit = Parameter.getString("unit");

    SensorData = ParameterName+ ": " + PList[iParam] + " " + ParameterUnit;
    fill(SensorColor);
    text(SensorData, (nCol + 10), nRow);
    stroke(DivisionColor);
    line(0, nRow + 20, 800, nRow + 20);
    nCol += 263;
    if ((iParam + 1) % 3 == 0) {
      nCol = 0;
      nRow += 50;
    }
  }

  if (svDumpFile == 1) {
      if (svDateTime == 1)
        appendDataToFile(svFilename, GetDate() + svFieldSeparator + GetTime() + svFieldSeparator + inString);
      else
        appendDataToFile(svFilename, inString);
  }
  delay(svReadingFrequency);
}

void serialEvent(Serial SPort) { 
  if (SPConn.available() > 0) 
    inString = SPort.readString(); 
} 

void keyPressed() {
  if (key == 'Q' || key == 'q') {
    SPConn.stop();
    new UiBooster().showInfoDialog("Quitting application");
    exit();
  }
  if (key == 'P' || key == 'p') {
    svDumpFile = 0;
    new UiBooster().showWarningDialog("Paused data dump", "WARN");
  }
  if (key == 'R' || key == 'r') {
    svDumpFile = 1;
    new UiBooster().showWarningDialog("Continuing data dump", "WARN");
  }
  
}


void appendDataToFile(String filename, String StringDATA){
  File Outputfile = new File(dataPath(filename));
  if(!Outputfile.exists()) {
    createFile(Outputfile);
  }
  try {
    PrintWriter output = new PrintWriter(new BufferedWriter(new FileWriter(Outputfile, true)));
    output.print(StringDATA);
    output.close();
  }
  catch (IOException e) {
      e.printStackTrace();
  }
}


void createFile(File Outputfile){
  File parentDir = Outputfile.getParentFile();
  try {
    parentDir.mkdirs(); 
    Outputfile.createNewFile();
  }
  catch(Exception e) {
    e.printStackTrace();
  }
}    

String GetDate() {
 return(nf(year(), 4) + "/" + nf(month(), 2) + "/" +nf(day(), 2));
}

String GetTime() {
  return(nf(hour(), 2) + ":" + nf(minute(), 2) + ":" + nf(second(), 2));
}
