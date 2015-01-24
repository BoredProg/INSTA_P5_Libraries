import java.nio.*;  
import javax.media.opengl.*;

import vitamin.*;
import vitamin.math.*;
import vitamin.scenesimple.*;


VGL vgl;
float aspectRatio;


Scene mmscene;

Mesh mesh;
Light ll;

void setupPointLight( Vector3 pos )
{
  GL g = vgl.gl();

  float[] light_emissive = { 0.0f, 0.0f, 0.0f, 1 };
  float[] light_ambient = { 0.3f, 0.3f, 0.3f, 1 };
  float[] light_diffuse = { 3.0f, 3.0f, 3.0f, 1.0f };
//  float[] light_diffuse = { 0.10f, 0.10f, 0.10f, 1.0f };
  float[] light_specular = { 1.0f, 1.0f, 1.0f, 1.0f };  
  float[] mat_shininess = { 64 };

  float[] light_position = { pos.x, pos.y, pos.z, 1.0f };  


//  vgl.gl().glLightModeli( GL.GL_LIGHT_MODEL_LOCAL_VIEWER, GL.GL_TRUE );

  FloatBuffer fb;
  fb = FloatBuffer.wrap( light_ambient );
  g.glLightfv ( GL.GL_LIGHT0, GL.GL_AMBIENT, fb );
  fb = FloatBuffer.wrap( light_diffuse );
  g.glLightfv ( GL.GL_LIGHT0, GL.GL_DIFFUSE, fb );
//  fb = FloatBuffer.wrap( light_specular );
//  g.glLightfv ( GL.GL_LIGHT0, GL.GL_SPECULAR, fb );
//  fb = FloatBuffer.wrap( mat_shininess );
//  g.glLightfv( GL.GL_LIGHT1, GL.GL_SHININESS, fb );*/

  fb = FloatBuffer.wrap( light_position );
  g.glLightfv ( GL.GL_LIGHT0, GL.GL_POSITION, fb );  

  g.glEnable( GL.GL_LIGHT0 );
  g.glEnable( GL.GL_LIGHTING );

/*
  g.glEnable( GL.GL_COLOR_MATERIAL );
  fb = FloatBuffer.wrap( light_emissive );
  g.glMaterialfv( GL.GL_FRONT_AND_BACK, GL.GL_AMBIENT, fb );
  fb = FloatBuffer.wrap( light_diffuse );
  g.glMaterialfv( GL.GL_FRONT_AND_BACK, GL.GL_DIFFUSE, fb );
  fb = FloatBuffer.wrap( mat_shininess );
  g.glMaterialfv( GL.GL_FRONT_AND_BACK, GL.GL_SHININESS, fb );
  fb = FloatBuffer.wrap( light_specular );
  g.glMaterialfv( GL.GL_FRONT_AND_BACK, GL.GL_SPECULAR, fb );*/
}   


// Define a icosahedron
static float X = 0.525731112119133606;
static float Z = 0.850650808352039932;
static float[][] vdata = {  //[12][3]
{-X, 0.0, Z}, {X, 0.0, Z}, {-X, 0.0, -Z}, {X, 0.0, -Z},
{0.0, Z, X}, {0.0, Z, -X}, {0.0, -Z, X}, {0.0, -Z, -X},
{Z, X, 0.0}, {-Z, X, 0.0}, {Z, -X, 0.0}, {-Z, -X, 0.0}
};
static int[][] tindices = {  // [20][3]
{1,4,0}, {4,9,0}, {4,9,5}, {8,5,4}, {1,8,4},
{1,10,8}, {10,3,8}, {8,3,5}, {3,2,5}, {3,7,2},
{3,10,7}, {10,6,7}, {6,11,7}, {6,0,11}, {6,1,0},
{10,1,6}, {11,0,9}, {2,11,9}, {5,2,9}, {11,2,7}
};

void setup()
{
  size( 800, 600, OPENGL );

  // if enabled the screen will clear
  hint( ENABLE_OPENGL_4X_SMOOTH );
  smooth(); 

  vgl = new VGL( this );
  aspectRatio = width / (float)height;

  mmscene = vgl.loadScene( dataPath("beast_1.mm") );

/*  StandardMaterial mat = new StandardMaterial( "IcosaMat" );
  mat.setDiffuse( 1.0f, 1.0f, 0.0f, 1.0f );
  mmscene.addMaterial( (StandardMaterial)mat );

  mesh = new Mesh( "Icosahedron" );
  int i;
  for( i=0; i<12; i++ )
    mesh.addVertex( 100*vdata[i][0], -100*vdata[i][1], 100*vdata[i][2] );
  for( i=0; i<20; i++ )
    mesh.addTriangle( tindices[i][0], tindices[i][1], tindices[i][2] );
  mesh.setMaterial( mat );
  mesh.computeNormals();
  mesh.processChunks();
  mmscene.addMesh( mesh );*/

  if( mmscene == null )  stop();
  mmscene.debug();
  
  ll = mmscene.getLight( 0 );

//  vgl.gl().glShadeModel( GL.GL_FLAT );
}


void draw()
{
//  println( frameRate );
  float time = millis()*0.001;

  vgl.begin();
  vgl.background( 1 );
  vgl.perspective( 45, 4.0/3.0, 1, 5000 );
  vgl.camera( 0, 100, 400, 0, 0, 0, 0, 1, 0 );

  if( ll != null )  setupPointLight( new Vector3(ll._position.x, ll._position.y, ll._position.z) );
  else setupPointLight( new Vector3(100, 100, 500) );

  vgl.rotateX( mouseY );
  vgl.rotateY( mouseX );
  mmscene.render();

  vgl.end();
}

void keyPressed()
{
  if( key == 's' )
    saveFrame( "car_shot.jpg" );
}

void stop()
{
}
