class Cubic
{
  Cubic()
  {
          _V = new Vector3[8];
          _oV = new Vector3[8];
          
/*          _V[0] = new Vector3( -1.0, 1.0, 1.0 );
          _V[1] = new Vector3(  1.0, 1.0, 1.0 );
          _V[2] = new Vector3(  1.0, -1.0, 1.0 );
          _V[3] = new Vector3(  -1.0, -1.0, 1.0 );
          _V[4] = new Vector3( -1.0, 1.0, -1.0 );
          _V[5] = new Vector3(  1.0, 1.0, -1.0 );
          _V[6] = new Vector3(  1.0, -1.0, -1.0 );
          _V[7] = new Vector3(  -1.0, -1.0, -1.0 );*/
          
          _V[0] = new Vector3( 0.0, 1.0, 1.0 );
          _V[1] = new Vector3( 1.0, 1.0, 1.0 );
          _V[2] = new Vector3( 1.0, 0.0, 1.0 );
          _V[3] = new Vector3( 0.0, 0.0, 1.0 );
          _V[4] = new Vector3( 0.0, 1.0, 0.0 );
          _V[5] = new Vector3( 1.0, 1.0, 0.0 );
          _V[6] = new Vector3( 1.0, 0.0, 0.0 );
          _V[7] = new Vector3( 0.0, 0.0, 0.0 );
          
          for( int i=0; i<8; i++ )
          {
              _oV[i] = _V[i].copy();
          }
  }

  void draw()
  {    
    // front
    vgl.gl().glBegin( GL.GL_QUADS );
    vgl.gl().glColor4f( vgl._r, vgl._g, vgl._b, vgl._a );
    vgl.gl().glNormal3f( 0.0f, 0.0f, 1.0f ); 
    vgl.gl().glTexCoord2f(0, 0); vgl.gl().glVertex3f( _V[0].x, _V[0].y, _V[0].z );
    vgl.gl().glNormal3f( 0.0f, 0.0f, 1.0f ); 
    vgl.gl().glTexCoord2f(1, 0); vgl.gl().glVertex3f( _V[1].x, _V[1].y, _V[1].z );
    vgl.gl().glNormal3f( 0.0f, 0.0f, 1.0f ); 
    vgl.gl().glTexCoord2f(1, 1); vgl.gl().glVertex3f( _V[2].x, _V[2].y, _V[2].z );
    vgl.gl().glNormal3f( 0.0f, 0.0f, 1.0f ); 
    vgl.gl().glTexCoord2f(0, 1); vgl.gl().glVertex3f( _V[3].x, _V[3].y, _V[3].z );
    vgl.gl().glEnd();
    
    // back
    vgl.gl().glBegin( GL.GL_QUADS );
    vgl.gl().glColor4f( vgl._r, vgl._g, vgl._b, vgl._a );
    vgl.gl().glNormal3f( 0.0f, 0.0f, -1.0f ); 
    vgl.gl().glTexCoord2f(1, 0); vgl.gl().glVertex3f( _V[4].x, _V[4].y, _V[4].z );
    vgl.gl().glNormal3f( 0.0f, 0.0f, -1.0f ); 
    vgl.gl().glTexCoord2f(0, 0); vgl.gl().glVertex3f( _V[5].x, _V[5].y, _V[5].z );
    vgl.gl().glNormal3f( 0.0f, 0.0f, -1.0f ); 
    vgl.gl().glTexCoord2f(0, 1); vgl.gl().glVertex3f( _V[6].x, _V[6].y, _V[6].z );
    vgl.gl().glNormal3f( 0.0f, 0.0f, -1.0f ); 
    vgl.gl().glTexCoord2f(1, 1); vgl.gl().glVertex3f( _V[7].x, _V[7].y, _V[7].z );
    vgl.gl().glEnd();
  
  
    // left
    vgl.gl().glBegin( GL.GL_QUADS );
    vgl.gl().glColor4f( vgl._r, vgl._g, vgl._b, vgl._a );
    vgl.gl().glNormal3f( -1.0f, 0.0f, 0.0f ); 
    vgl.gl().glTexCoord2f(0, 0); vgl.gl().glVertex3f( _V[4].x, _V[4].y, _V[4].z );
    vgl.gl().glNormal3f( -1.0f, 0.0f, 0.0f ); 
    vgl.gl().glTexCoord2f(1, 0); vgl.gl().glVertex3f( _V[0].x, _V[0].y, _V[0].z );
    vgl.gl().glNormal3f( -1.0f, 0.0f, 0.0f ); 
    vgl.gl().glTexCoord2f(1, 1); vgl.gl().glVertex3f( _V[3].x, _V[3].y, _V[3].z );
    vgl.gl().glNormal3f( -1.0f, 0.0f, 0.0f ); 
    vgl.gl().glTexCoord2f(0, 1); vgl.gl().glVertex3f( _V[7].x, _V[7].y, _V[7].z );
    vgl.gl().glEnd();
  
    // right
    vgl.gl().glBegin( GL.GL_QUADS );
    vgl.gl().glColor4f( vgl._r, vgl._g, vgl._b, vgl._a );
    vgl.gl().glNormal3f( 1.0f, 0.0f, 0.0f ); 
    vgl.gl().glTexCoord2f(0, 0); vgl.gl().glVertex3f( _V[1].x, _V[1].y, _V[1].z );
    vgl.gl().glNormal3f( 1.0f, 0.0f, 0.0f ); 
    vgl.gl().glTexCoord2f(1, 0); vgl.gl().glVertex3f( _V[5].x, _V[5].y, _V[4].z );
    vgl.gl().glNormal3f( 1.0f, 0.0f, 0.0f ); 
    vgl.gl().glTexCoord2f(1, 1); vgl.gl().glVertex3f( _V[6].x, _V[6].y, _V[6].z );
    vgl.gl().glNormal3f( 1.0f, 0.0f, 0.0f ); 
    vgl.gl().glTexCoord2f(0, 1); vgl.gl().glVertex3f( _V[2].x, _V[2].y, _V[2].z );
    vgl.gl().glEnd();
  	
    // top
    vgl.gl().glBegin( GL.GL_QUADS );
    vgl.gl().glColor4f( vgl._r, vgl._g, vgl._b, vgl._a );
    vgl.gl().glNormal3f( 0.0f, 1.0f, 0.0f ); 
    vgl.gl().glTexCoord2f(0, 1); vgl.gl().glVertex3f( _V[4].x, _V[4].y, _V[4].z );
    vgl.gl().glNormal3f( 0.0f, 1.0f, 0.0f ); 
    vgl.gl().glTexCoord2f(1, 1); vgl.gl().glVertex3f( _V[5].x, _V[5].y, _V[5].z );
    vgl.gl().glNormal3f( 0.0f, 1.0f, 0.0f ); 
    vgl.gl().glTexCoord2f(1, 0); vgl.gl().glVertex3f( _V[1].x, _V[1].y, _V[1].z );
    vgl.gl().glNormal3f( 0.0f, 1.0f, 0.0f ); 
    vgl.gl().glTexCoord2f(0, 0); vgl.gl().glVertex3f( _V[0].x, _V[0].y, _V[0].z );
    vgl.gl().glEnd();
  
    // bottom
    vgl.gl().glBegin( GL.GL_QUADS );
    vgl.gl().glColor4f( vgl._r, vgl._g, vgl._b, vgl._a );
    vgl.gl().glNormal3f( 0.0f, 1.0f, 0.0f ); 
    vgl.gl().glTexCoord2f(0, 1); vgl.gl().glVertex3f( _V[3].x, _V[3].y, _V[3].z );
    vgl.gl().glNormal3f( 0.0f, 1.0f, 0.0f ); 
    vgl.gl().glTexCoord2f(1, 1); vgl.gl().glVertex3f( _V[2].x, _V[2].y, _V[2].z );
    vgl.gl().glNormal3f( 0.0f, 1.0f, 0.0f ); 
    vgl.gl().glTexCoord2f(1, 0); vgl.gl().glVertex3f( _V[6].x, _V[6].y, _V[6].z );
    vgl.gl().glNormal3f( 0.0f, 1.0f, 0.0f ); 
    vgl.gl().glTexCoord2f(0, 0); vgl.gl().glVertex3f( _V[7].x, _V[7].y, _V[7].z );
    vgl.gl().glEnd();
  }


  void resize( float s )
  {
    for( int i=0; i<_V.length; i++ )
    {
      _V[i].x = _oV[i].x * s;
      _V[i].y = _oV[i].y * s;
      _V[i].z = _oV[i].z * s;
    }
  }
        
  void resize( float sx, float sy, float sz )
  {
    for( int i=0; i<_V.length; i++ )
    {
      _V[i].x = _oV[i].x * sx;
      _V[i].y = _oV[i].y * sy;
      _V[i].z = _oV[i].z * sz;
    }
  }


  void offset( float x, float y, float z )
  {
    for( int i=0; i<_V.length; i++ )
    {
      _V[i].x = _oV[i].x + x;
      _V[i].y = _oV[i].y + y;
      _V[i].z = _oV[i].z + z;
    }
  }       

      
  float _scale;
  Vector3[]  _V;
  Vector3[]  _oV;
  Vector3 _Pos;
};
