import CellNoise.*;


CellNoise cn;
CellDataStruct cd;
float total = 0.0, start = 0.0;
float[] freq = {0.08, 0.08, 0.05};
double[] at = {0, 0, 0};
PImage im;
int frames = 0, t = 0;
double Fs = 0, Fsum = 0;

void setup() {
  size(200, 50);
  background(0);
  cn = new CellNoise(this);
  cd = new CellDataStruct(this, 2, at, cn.EUCLIDEAN);
  start = millis();
}

void draw() {
  loadPixels();
  //background(0);
  at[2] += freq[2];
  float diff;
  //t += freq[2];
  
  for (int x = 0; x < width; x++) {
    at[0] = freq[0]*(x+t);
    for (int y = 0; y < height; y++) {
      at[1] = freq[1]*(y+t);

      cd.at = at;
      cn.noise(cd);
      
      //pixel color
      pixels[x + y*width] = color((float)(cd.F[1]*cd.F[0]) * 150);
      
      // avrage F[0]
      Fsum += cd.F[0];
      Fs++;
    }
  }
  updatePixels();
  frames++;
}


void mouseReleased() {
  total = millis() - start;
  println("fps: " + frames*1000/total);
  println("avgF: " + Fsum/Fs);
  println();
}
