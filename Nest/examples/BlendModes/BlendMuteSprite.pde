// BlendMuteSprite subclasses NestSprite,
// and draws rectangles to the screen via its draw() method.
// Instantiate a new BlendMuteSprite with a Processing blend mode;
// clicking a BlendMuteSprite will temporarily turn off blend mode
// to NestSprite.NO_BLEND_MODE.

class BlendMuteSprite extends NestSprite {
  // use Processing's default blend mode
  int initBlendMode;
  
  public BlendMuteSprite (int initBlendMode) {
    // set bounds
    super(-50, -50, 100, 100);
    
    this.initBlendMode = initBlendMode;
    blendMode = initBlendMode;
  }

  // draw() is called second by NestSpriteContainer.update(),
  // and should be used to draw the NestSprite to the screen.
  void draw (PApplet p) {
    // draw a white rectangle
    p.fill(255);
    p.stroke(0);
    p.rect(boundsLeft, boundsTop, width, height);
    
    // draw a black rectangle inside of it
    p.fill(0);
    p.rect(boundsLeft/2, boundsTop/2, width/2, height/2);
  }
  
  void mousePressed (com.transmote.nest.events.MouseEvent e) {
    blendMode = NestSprite.NO_BLEND_MODE;
    
    println("turn off blendMode");
    
    e.stopPropagation();
  }
  
  void mouseReleased (com.transmote.nest.events.MouseEvent e) {
    blendMode = initBlendMode;
    
    println("restore previous blendMode");
    
    e.stopPropagation();
  }
}
