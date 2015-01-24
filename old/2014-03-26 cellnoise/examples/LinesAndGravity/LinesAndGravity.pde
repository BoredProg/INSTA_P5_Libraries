import CellNoise.*;


CellNoise cn;
CellDataStruct cd;
float[] freq = {0.025, 0.025, 0.05};
double[] at = {0, 0};
float ax = 0, ay = 0, vx, vy;
float x, y, ox = 0, oy = 0;
float M, m, g, G, dt, t, odt = 1;

void setup() {
  size(200, 200);
  background(250);
  cn = new CellNoise(this);
  cd = new CellDataStruct(this, 3, at, cn.EUCLIDEAN);
  smooth();
  restart();
  M = 0.1;
  m = 5;
  G = 1;
}

void draw() {
  dt = (millis() - t)/1000;
  if (dt >= 0.04) {
    t = millis();
    //println(x + ", " + y);

    at[0] = freq[0] * x;
    at[1] = freq[1] * y;

    cd.at = at;
    cn.noise(cd);


    //-----------------
    if (x > width + 10 || x < -10 || y > height + 10 || y < -10) {
      crash();
      restart();
      //mirror();
    } 
    else {
      if (cd.F[0] < 0.1) {
        ax = M*m*G * (float)(cd.delta[1][0]/(cd.F[1]*cd.F[1]*cd.F[1]) + cd.delta[2][0]/(cd.F[2]*cd.F[2]*cd.F[2]))/freq[0];
        ay = M*m*G * (float)(cd.delta[1][1]/(cd.F[1]*cd.F[1]*cd.F[1]) + cd.delta[2][1]/(cd.F[2]*cd.F[2]*cd.F[2]))/freq[1];
      } else {
        ax = M*m*G * (float)(cd.delta[0][0]/(cd.F[0]*cd.F[0]*cd.F[0]) + cd.delta[1][0]/(cd.F[1]*cd.F[1]*cd.F[1]) + cd.delta[2][0]/(cd.F[2]*cd.F[2]*cd.F[2]))/freq[0];
        ay = M*m*G * (float)(cd.delta[0][1]/(cd.F[0]*cd.F[0]*cd.F[0]) + cd.delta[1][1]/(cd.F[1]*cd.F[1]*cd.F[1]) + cd.delta[2][1]/(cd.F[2]*cd.F[2]*cd.F[2]))/freq[1];
      }
      vx = (x - ox)/odt;
      vy = (y - oy)/odt;
      ox = x;
      oy = y;
      //println(dt);
      x = x + vx*dt + ax*dt*dt/2;
      y = y + vy*dt + ay*dt*dt/2;
      //ellipse(x, y, 3.0, 3.0);
      line(ox, oy, x, y);
      /*stroke(200, 0, 0);
      ellipse(ox + (float)cd.delta[0][0]/freq[0], oy + (float)cd.delta[0][1]/freq[1], 3, 3);
      ellipse(ox + (float)cd.delta[1][0]/freq[0], oy + (float)cd.delta[1][1]/freq[1], 3, 3);
      ellipse(ox + (float)cd.delta[2][0]/freq[0], oy + (float)cd.delta[2][1]/freq[1], 3, 3);
      */stroke(20);//(sqrt(vx*vx + vy*vy) - 100);
      odt = dt;
    }

    //-----------------
    /*
  stroke(50);
     line(x,y, x+(int)(cd.delta[0][0]/freq[0]), y+(int)(cd.delta[0][1]/freq[1]));
     stroke(100);
     line(x,y, x+(int)(cd.delta[1][0]/freq[0]), y+(int)(cd.delta[1][1]/freq[1]));
     stroke(150);
     line(x,y, x+(int)(cd.delta[2][0]/freq[0]), y+(int)(cd.delta[2][1]/freq[1]));  
     */
  }
}

void restart() {
  float p = random(width*2 + height*2);
  if (p < width) {
    x = floor(p);
    y = -10;
    ox = x;
    oy = -11;
  } else if (p < width+height) {
    x = width+10;
    y = floor(p - width);
    ox = x+1;
    oy = y;
  } else if (p < width*2+height) {
    x = floor(width*2+height - p);
    y = height+10;
    ox = x;
    oy = y+1;
  } else {
    x = -10;
    y = floor(width*2+height*2 - p);
    ox = -11;
    oy = y;
  }
  t = millis();
}

void mirror() {
  if (x < -10) {
    ox -= x;
    x = width + 10;
    ox += x;
  }
  else if (x > width + 10) {
    ox -= x;
    x = -10;
    ox += x;
  }
  else if (y < -10) {
    oy -= y;
    y = height + 10;
    oy += y;
  }
  else if (y > height + 10) {
    oy -= y;
    y = -10;
    oy += y;
  }
  t = millis();
}

void crash() {
  ;
}

void mouseReleased() {
  background(250);
  restart();
  /*
  total = millis() - start;
   println("fps: " + frames*1000/total);
   println("avgF: " + Fsum/Fs);
   println();
   */
}
