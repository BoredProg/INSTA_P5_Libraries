import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.Properties;

ExtractTemplate unzip;
StringBuilder instruction = new StringBuilder(200);
BufferedWriter bw;
String povhome;
String sep;
Properties properties;
PFont font;
boolean done = false;

void setup() {
  size(500, 320);
  sep = System.getProperty("file.separator");
  povhome = System.getProperty("user.home") + sep + ".povwriter2";
  instruction.append("Use this tool to install template files,");
  instruction.append(" and to set the path 'to the povray executable' on your system,");
  instruction.append(" povengine.exe (windows) or povray (linux/Mac)\n");
  instruction.append("Press 'i' to install templates\n");
  instruction.append("Press 'e' to set Povray Executable\n");
  background(100, 100, 200);
  fill(200, 200, 0);
  font = createFont("Monospaced", 24);
  textFont(font);
  text(instruction.toString(), 5, 5, width, height);
}

void draw() {
  if(done){
    background(0);
    text("SUCCESS!", 200, height/2);
    noLoop();
  }
}

void setExecutable(File file) {
  String comments = "Povray Properties";
  String prop = povhome + sep + "povwriter.properties";
  String template = povhome + sep + "original.pov";
  String firstRun = "true";
  properties = new Properties();
  try {
    properties.put("first.run", firstRun);
    properties.put("template", template);
    properties.put("povrayPath", file.getAbsolutePath());    
    bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(prop), "UTF8"));
    try {
      properties.store(bw, comments);
    } 
    finally {
      bw.close();
      done = true;
    }
  } 
  catch (IOException e) {
  }
}

void keyPressed() {
  if (!done){
  switch (key) {
  case 'e':
    selectInput("Set Povray Executable", "setExecutable");
    
    break;
  case 'i':
    unzip = new ExtractTemplate(dataFile("template.zip"), true);
    unzip.run();    
    break;
  }
  }
}


