class CustomScene extends vitamin.fx.Effect
{
    Vector4 lightPos;
    
    VTexture2D _groundTex;
    
    Cubic _cube;
    float cubeSize;
    float cubeHeight;
    
    int _numOfCubes;
    ArrayList _cubePos;
    ArrayList _originalCubePos;

  
  // Abstract methods. to implement!
  public boolean Init( GL gl )
  {
    _gl = gl;
    
    _groundTex = new VTexture2D( _gl, dataPath("groundtex.png") );
    
    
    cubeHeight = -1;
    cubeSize = 20;
    _cube = new Cubic();
    _cube.resize( cubeSize, cubeSize, cubeSize );
    
    _cubePos = new ArrayList();
    _originalCubePos = new ArrayList();
    
    _numOfCubes = 10;
    for( int i=0; i<_numOfCubes; i++ )
    {
        float per = (i / (float)_numOfCubes);
        //float rad = per * 150;
        //float angle = 2 * PI * per * 2;
        float rad = 100;
        float angle = 2 * PI * per;
        float x = cos(angle)*rad;
        float z = sin(angle)*rad;
        float y = 0;
        
        _cubePos.add( new Vector4(x, y, z, cubeHeight) );
        _originalCubePos.add( new Vector4(x, y, z, cubeHeight) );
    }
    
    
    lightPos = new Vector4( 0, 300, 0, 1.0 );

    return true;
  }

	
  public void Render( float time )
  {
//    vgl.ortho( 0, width, 0, height, -100, 100 );
    vgl.perspective( 45, aspectRatio, 1, 10000 );
    vgl.camera( 0, 400, 0, 0, 0, 0, 0, 0, 1 );
//    vgl.camera( sin(time*0.4)*400, 150, cos(time*0.4)*400, 0, 0, 0, 0, 1, 0 );
    
    lightPos.set( sin(time*0.4)*500, 200, cos(time*1.4)*400, 1 );
    setupLight( lightPos.xyz(), lightPos.w );

    vgl.setDepthMask( true );
    vgl.setDepthWrite( true );
    vgl.enableLighting( true );
    
    vgl.enableTexture( true );
    _groundTex.enable();
    vgl.fill( 1 );
    vgl.rectXZ( 1000, 1000 );
    _groundTex.disable();

    

    // 
    // Draw planar shadows
    //
    vgl.enableTexture( false );
    vgl.enableLighting( false );
    vgl.setDepthMask( false );
//    vgl.setDepthWrite( false );
    
    Plane plane = new Plane( new Vector3(0, 0, 0), new Vector3(0, 1, 0) );
    float[] P = { 0, 0.1, 0, 1 };
    float[] P2 = { plane._normal.x, plane._normal.y, plane._normal.z, plane._d };
    float[] L2 = { lightPos.x, lightPos.y, lightPos.z, 1 };
  
    vgl.gl().glEnable( GL.GL_POLYGON_OFFSET_FILL );
    vgl.gl().glPolygonOffset( -1, 1 );
  
    vgl.pushMatrix();
    CreateShadowProjection( L2, P, P2 );

//    vgl.fill( 0, 0, 0, 0.65 );    
//    vgl.rectXZ( 1000, 1000 );

    vgl.fill( 0, 0, 0, 0.35 );
    for( int i=0; i<_numOfCubes; i++ )
    {
        Vector4 p = (Vector4)_cubePos.get( i );

        if( p.w > 0 )
        {
            vgl.pushMatrix();
            vgl.translate( p.xyz() );
            _cube.resize( cubeSize*2-2, p.w, cubeSize-2 );
            _cube.draw();
            vgl.popMatrix();
        }
    }
    vgl.gl().glDisable( GL.GL_POLYGON_OFFSET_FILL );
    vgl.popMatrix();



    vgl.enableLighting( true );
    vgl.setDepthMask( true );
    vgl.setDepthWrite( true );
    vgl.enableTexture( false );
    vgl.fill( 1, 1 );
    for( int i=0; i<_numOfCubes; i++ )
    {
        Vector4 p = (Vector4)_cubePos.get( i );

        vgl.pushMatrix();
        vgl.translate( p.xyz() );
        _cube.resize( cubeSize*2, p.w, cubeSize );
        _cube.draw();
        vgl.popMatrix();
    }
    
  }


	
  public void Update( float time )
  {
    //
    // Animate cube height      
    //
    for( int i=0; i<_numOfCubes; i++ )
    {
        Vector4 p = (Vector4)_cubePos.get( i );
        Vector4 op = (Vector4)_originalCubePos.get( i );
        
        p.w = cubeHeight+(abs(sin(time*1.3+i*0.5))*10);
    }
      
  }



  public void Release()
  {
  }




  /*
   * This is where the "magic" is done:
   *
   * Multiply the current ModelView-Matrix with a shadow-projetion
   * matrix.
   *
   * l is the position of the light source
   * e is a point on within the plane on which the shadow is to be
   *   projected.  
   * n is the normal vector of the plane.
   *
   * Everything that is drawn after this call is "squashed" down
   * to the plane. Hint: Gray or black color and no lighting 
   * looks good for shadows *g*
   */
  void CreateShadowProjection( float[] l, float[] e, float[] n )
  {
    float d, c;
    float[] mat = new float[16];
  
    // These are c and d (corresponding to the tutorial)
  
    d = n[0]*l[0] + n[1]*l[1] + n[2]*l[2];
    c = e[0]*n[0] + e[1]*n[1] + e[2]*n[2] - d;
  
    // Create the matrix. OpenGL uses column by column
    // ordering
    mat[0]  = l[0]*n[0]+c; 
    mat[4]  = n[1]*l[0]; 
    mat[8]  = n[2]*l[0]; 
    mat[12] = -l[0]*c-l[0]*d;
  
    mat[1]  = n[0]*l[1];        
    mat[5]  = l[1]*n[1]+c;
    mat[9]  = n[2]*l[1]; 
    mat[13] = -l[1]*c-l[1]*d;
  
    mat[2]  = n[0]*l[2];        
    mat[6]  = n[1]*l[2]; 
    mat[10] = l[2]*n[2]+c; 
    mat[14] = -l[2]*c-l[2]*d;
  
    mat[3]  = n[0];        
    mat[7]  = n[1]; 
    mat[11] = n[2]; 
    mat[15] = -d;

    // Finally multiply the matrices together *plonk*
    vgl.gl().glMultMatrixf( mat, 0 );
  } 



  // val is 0 or 1. 0 = directional light, 1 = point light
  void setupLight( Vector3 pos, float val )
  {
    GL g = _gl;
  
    float[] light_emissive = { 0.0f, 0.0f, 0.0f, 1 };
    float[] light_ambient = { 0.3f, 0.3f, 0.3f, 1 };
    float[] light_diffuse = { 1.0f, 1.0f, 1.0f, 1.0f };
    float[] light_specular = { 1.0f, 1.0f, 1.0f, 1.0f };  
    float[] light_position = { pos.x, pos.y, pos.z, val };  
  
    g.glLightfv ( GL.GL_LIGHT1, GL.GL_AMBIENT, light_ambient, 0 );
    g.glLightfv ( GL.GL_LIGHT1, GL.GL_DIFFUSE, light_diffuse, 0 );
    g.glLightfv ( GL.GL_LIGHT1, GL.GL_SPECULAR, light_specular, 0 );
    g.glLightfv ( GL.GL_LIGHT1, GL.GL_POSITION, light_position, 0 );  
    g.glEnable( GL.GL_LIGHT1 );
    g.glEnable( GL.GL_LIGHTING );
    g.glEnable( GL.GL_COLOR_MATERIAL );
  }  
 

  
  // __________________________________________________________
  // Members

  GL _gl;
}

