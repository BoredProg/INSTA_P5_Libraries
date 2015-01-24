/**
 * Shows an overview, and a detail map. The overview is a small-scale map, and shows the same area as the
 * large-scale detail map.
 * 
 * Both maps are interactive, and can be navigated. Each interaction is reflected in both maps. This Overview + Detail
 * example shows how to setup simple connected map views.
 * 
 */

import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.events.EventDispatcher;
import de.fhpotsdam.unfolding.interactions.MouseHandler;
import de.fhpotsdam.unfolding.providers.*; 

import de.fhpotsdam.unfolding.providers.*;


UnfoldingMap mapDetail;
UnfoldingMap mapOverview;

public void setup() 
{
  size(800, 600, P2D);
  
  /*
  //best
  MapBox.ControlRoomProvider
  
  AcetateProvider.Basemap
  AcetateProvider.Foreground
  AcetateProvider.GenericAcetateProvider
  AcetateProvider.Hillshading
  */

  //= new UnfoldingMap(this, 0, 0, 400, 400, new StamenMapProvider.WaterColor());

  //mapDetail = new UnfoldingMap(this, "detail", 10, 10, 585, 580);
  //mapDetail = new UnfoldingMap(this, 0, 0, 400, 400, new MapBox.ControlRoomProvider() );
  
   mapDetail = new UnfoldingMap(this, "detail", 10, 10, 385, 580, true, false, new Microsoft.AerialProvider());
  
  
  mapDetail.setTweening(true);
  mapDetail.zoomToLevel(4);
  mapOverview = new UnfoldingMap(this, "overview", 405, 10, 385, 580, true, false, new MapBox.ControlRoomProvider());
  //mapOverview = new UnfoldingMap(this, 0, 0, 400, 400, new MapBox.ControlRoomProvider() );
  // new UnfoldingMap(this, "overview", 605, 10, 185, 185);
  mapOverview.setTweening(true);

  EventDispatcher eventDispatcher = new EventDispatcher();

  // Add mouse interaction to both maps
  MouseHandler mouseHandler = new MouseHandler(this, mapDetail, mapOverview);
  eventDispatcher.addBroadcaster(mouseHandler);

  // Maps listen to each other, i.e. each interaction in one map is reflected in the other
  eventDispatcher.register(mapDetail, "pan", mapDetail.getId(), mapOverview.getId());
  eventDispatcher.register(mapDetail, "zoom", mapDetail.getId(), mapOverview.getId());
  eventDispatcher.register(mapOverview, "pan", mapDetail.getId(), mapOverview.getId());
  eventDispatcher.register(mapOverview, "zoom", mapDetail.getId(), mapOverview.getId());
}

public void draw() {
  background(0);

  mapDetail.draw();
  mapOverview.draw();
}

