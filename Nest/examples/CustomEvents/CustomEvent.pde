// CustomEvent is a customized implementation of a Nest Event.
// Subclassing Event allows custom data to be passed along with the Event.

class CustomEvent extends com.transmote.nest.events.Event {
  private String customMessage;
  
  public CustomEvent (String customMessage) {
    // pass the event type (an arbitrary int) to Event's constructor
    super(CUSTOM_EVENT_TYPE);
    
    // store the custom data in this instance
    // for retrieval by the event handler.
    this.customMessage = customMessage;
  }
  
  public String customMessage () {
    return customMessage;
  }
}

// Specify a type ID for event disambiguation.
// This is optional; in this example, EventSender::handleEvent()
// checks if the received Event is an instance of CustomEvent
// rather than switching on type.
// 
// Note: The Processing IDE requires statics be defined
// outside of any classes.
public static final int CUSTOM_EVENT_TYPE = 10;

