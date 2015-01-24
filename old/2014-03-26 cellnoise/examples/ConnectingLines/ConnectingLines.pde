
/*
* Created: by Carl-Johan Rosén as a part of the 
 * course Procedural Methods for Images.
 * At: Linköping Univeristy, Sweden.
 * Created: 20060302
 * Last edited: 20061118
 * Contact: cj(  )rosen( at )gmail(  )com
 * Based on the work and research by Steven Worley.
 */

import CellNoise.*;
CellNoise cn;
CellDataStruct cd;
int[] x = new int[100];
int[] y = new int[x.length];
int gdx, gdy;
int r = 1, i;
float k = 14;
double[] at = {
  0, 0, 0};
float t;

void setup() {
  size(200, 200);
  background(150, 0, 0);
  cn = new CellNoise(this);
  cd = new CellDataStruct(this, 5, at, cn.EUCLIDEAN);
  smooth();
  t = millis();
  noFill();
  restart();
  //ellipse(100, 100, 20, 20);
}



void draw() {

  if (millis() - t > 150) {
    t = millis();

    at[0] += cd.delta[r][0];
    at[1] += cd.delta[r][1];
    at[2] += cd.delta[r][2];
    r = (int)(random(4)+1);

    cd.at = at;
    cn.noise(cd);
    background(150,0,0);

    for (i = 0; i < x.length-5; i++) {
      stroke(160 + 1*i, 0 + 2*i, 0);
      //line(x[i], y[i], x[i+1], y[i+1]);
      bezier(x[i] + gdx, y[i] + gdy, x[i+1] + gdx, y[i+1] + gdy, x[i+2] + gdx, y[i+2] + gdy, x[i+3] + gdx, y[i+3] + gdy);
      x[i] = x[i+1];
      y[i] = y[i+1];
    }
    for (i = x.length-5; i < x.length-1; i++) {
      x[i] = x[i+1];
      y[i] = y[i+1];
    }

    x[x.length-1] = (int)((at[0] + cd.delta[r][0]) * k);
    y[y.length-1] = (int)((at[1] + cd.delta[r][1]) * k);
    stroke(220);
    //line(x[x.length-2], y[y.length-2], x[x.length-1], y[y.length-1]);
    bezier(x[x.length-4] + gdx, y[y.length-4] + gdy, x[x.length-3] + gdx, y[y.length-3] + gdy, x[x.length-2] + gdx, y[y.length-2] + gdy, x[x.length-1] + gdx, y[y.length-1] + gdy);

    moveCanvas(x[x.length-1] + gdx, y[y.length-1] + gdy);
  }

}


void restart() {
  background(150, 0, 0);
  at[0] = width/(2*k);
  at[1] = width/(2*k);
  at[2] = 20;
  gdx = 0;
  gdy = 0;
  for (i = 0; i < x.length; i++) {
    x[i] = (int)(at[0]*k);
    y[i] = (int)(at[1]*k);
  }

}

void moveCanvas(int mx, int my) {
  int dx = mx - floor(width*0.5);
  int dy = my - floor(height*0.5);
  int px = 0, py = 0;
  if (abs(dx) > width*0.4 || abs(dy) > height*0.4) {
    loadPixels();

    int[] cpixels = pixels;
    if (dx > width*0.4) {
      for (px = 0; px < width-1; px++) {
        for (py = 0; py < height; py++) {
          pixels[px + py*width] = cpixels[px+1 + py*width];
        }
      }
      for (py = 0; py < height; py++) {
        pixels[width-1 + py*width] = color(150, 0,0);
      }
      gdx -= 1;
    } 
    else if (dx < -width*0.4) {
      for (px = width-1; px > 0; px--) {
        for (py = 0; py < height; py++) {
          pixels[px + py*width] = cpixels[px-1 + py*width];
        }
      }
      for (py = 0; py < height; py++) {
        pixels[0 + py*width] = color(150, 0,0);
      }
      gdx += 1;
    }

    cpixels = pixels;
    if (dy > height*0.4) {
      for (px = 0; px < width; px++) {
        for (py = 0; py < height-1; py++) {
          pixels[px + py*width] = cpixels[px + (py+1)*width];
        }
        pixels[px + (height-1)*width] = color(150,0,0);
      }
      gdy -= 1;
    } 
    else if (dy < -height*0.4) {
      for (px = 0; px < width; px++) {
        for (py = height-1; py > 0; py--) {
          pixels[px + py*width] = cpixels[px + (py-1)*width];
        }
        pixels[px + 0*width] = color(150,0,0);
      }
      gdy += 1;
    }

    updatePixels();
    /*
    for (px = 0; px < x.length; px++) {
      if (dx != 0) {
        x[px] -= dx/abs(dx);
      }
      if (dy != 0) {
        y[px] -= dy/abs(dy);
      }
    }
    */
  }      
}


void mouseReleased() {
  //moveCanvas(mouseX, mouseY);
  /*
  println((int)(millis() - t));
  println(x[0] + ":" + y[0]);
  println();
  */
  
  restart();
}
/*    dx = mouseX - width/2;
 dy = mouseY - height/2;
 
 loadPixels();
 int[] pixCopy = pixels;
 if (dx >= 0) {
 
 for (x = 0; x < width; x++) {
 for (y = 0; y < height; y++) {
 pixels[(x + dx) + (y + dy)*width] = color(200, 50, 0);
 else
 pixels[x + y*width] = color(150, 0, 0);
 }
 }
 updatePixels();
 
 }
 */
