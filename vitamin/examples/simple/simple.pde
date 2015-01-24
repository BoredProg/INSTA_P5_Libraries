import processing.opengl.*;
import vitamin.*;

int WIDTH = 800;
int HEIGHT = 600;
float aspectRatio = WIDTH/(float)HEIGHT; 

VGL vgl;
//VLog logger;

///___________________________________________________________
void setup()
{
  size( WIDTH, HEIGHT, OPENGL );
  hint( ENABLE_OPENGL_4X_SMOOTH ); 
  frameRate( 60 ); 

  //logger = new VLog( this, "log.txt" );   
  
  aspectRatio = width/(float)height; 
  vgl = new VGL( this );  
}



///___________________________________________________________
void draw()
{
  float time = millis() * 0.001;
  vgl.begin();
  vgl.background( 0 );
  vgl.perspective( 45, aspectRatio, 1, 1000 );
  vgl.camera( 0, 0, 200, 0, 0, 0, 0, 1, 0 );

  vgl.fill( 1 );
  vgl.rotateY( time*25 );
  vgl.quad( 50 );
  
  vgl.end();
}


///___________________________________________________________
void stop()
{
  //logger.release();
  vgl.release();
  super.stop();
}

