// BlendSetSprite subclasses NestSprite,
// and draws rectangles to the screen via its draw() method.
// Clicking a BlendSetSprite will temporarily set its blendMode
// to Processing's default (PApplet.BLEND).

class BlendSetSprite extends NestSprite {
  int lastBlendMode;
  
  public BlendSetSprite () {
    // set bounds
    super(-50, -50, 100, 100);
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
    // store current blendMode for restoring in mouseReleased
    lastBlendMode = blendMode;
    
    // set blendMode to Processing's default blendMode
    blendMode = PApplet.BLEND;
    
    println("set blendMode to Processing default");
    
    // kill the event before it reaches the parent NestSprite
    e.stopPropagation();
  }
  
  void mouseReleased (com.transmote.nest.events.MouseEvent e) {
    // restore the blendMode from before the click
    blendMode = lastBlendMode;
    
    println("restore previous blendMode");
    
    // kill the event before it reaches the parent NestSprite
    e.stopPropagation();
  }
}
