// EventSender is very similar to ButtonSprite in the
// MouseEvents_Simple example. The main difference is that
// EventSender dispatches a CustomEvent when it is clicked,
// and also handles incoming events by checking if they are
// instances of CustomEvent.
//
// Note that messaging between objects via Events requires
// that the objects are observing one another; in this example,
// CustomEvents directs the two EventSender instances
// to observe one another in setupSprites().

class EventSender extends NestSprite {
  private String name;
  
  public EventSender (String name) {
    // set width, height, and bounds
    super(-50, -50, 100, 100);
    this.name = name;
  }
  
  // draw() is called second by NestSpriteContainer.update(),
  // and should be used to draw the NestSprite to the screen.
  void draw (PApplet p) {
    p.stroke(255);
    p.fill(0x99FFFFFF);
    p.ellipseMode(CORNER);
    p.ellipse(boundsLeft, boundsTop, width, height);
  }
  
  // dispatch a CustomEvent when clicked
  void mouseClicked (com.transmote.nest.events.MouseEvent e) {
    println("mouseClicked on "+ this);
    
    // send String representation of this instance
    // along with CustomEvent
    String whoAmI = toString();
    dispatchEvent(new CustomEvent(whoAmI));
  }
  
  // listen for Events, and write to the console
  // when a CustomEvent is received
  void handleEvent (com.transmote.nest.events.Event event) {
    if (event instanceof CustomEvent) {
      println(this +" heard CustomEvent from "+ ((CustomEvent)event).customMessage());
    }
  }
  
  // override Java's toString method to pretty-print information
  // about this instance when 'this' is passed to println().
  String toString () {
    return ("EventSender("+ name +")");
  }
}
