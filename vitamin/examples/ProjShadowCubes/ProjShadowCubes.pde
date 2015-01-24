/*
  Exploiting the projection mapping on a planar surface.
  Using shadows to give the illusion of relief.
  
  Victor Martins 2010
*/

import javax.media.opengl.*;
import processing.opengl.*;
import vitamin.*;
import vitamin.math.*;
import vitamin.fx.*;

int WIDTH = 800;
int HEIGHT = 600;
float aspectRatio = WIDTH/(float)HEIGHT; 

VTimer timer;
VGL vgl;
EffectManager fxMan;
CustomScene scene;




///___________________________________________________________
void setup()
{
  size( WIDTH, HEIGHT, OPENGL );
  hint( ENABLE_OPENGL_4X_SMOOTH ); 
  //hint( DISABLE_OPENGL_ERROR_REPORT ); 
  
  frameRate( 60 ); 

  aspectRatio = width / (float)height; 

  vgl = new VGL( this );
  vgl.setVSync( true );
  
  scene = new CustomScene();
  scene.Init( vgl.gl() );

//  fxMan = new EffectManager( vgl.gl() );  
//  scene = new CustomScene();
//  fxMan.AddEffect( scene );
  
  // Process all effects now!
//  fxMan.process();
  
  timer = new VTimer();
  timer.start();
}



///___________________________________________________________
void draw()
{
  float time = timer.getCurrTime();
  timer.update();
  
  vgl.begin();
  vgl.background( 0.3 );
  
  scene.Render( time );
  scene.Update( time );
/*  for( int i=0; i<fxMan.getCount(); i++ )
  {
	Effect fx = fxMan.getEffectByIdx( i );
	fx.Render( time );
	fx.Update( time );
  }*/


  vgl.end();
}


  

///___________________________________________________________
void stop()
{
  vgl.release();
  
  super.stop();
}
