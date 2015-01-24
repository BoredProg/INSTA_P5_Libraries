package cooladaLoader.xmlMapping;
import processing.data.XML;
import java.util.HashMap;

import cooladaLoader.ColladaLoaderException;
/**
 * <p>Lucerne University of Applied Sciences and Arts <a href="http://www.hslu.ch">http://www.hslu.ch</a></p>
 *
 * <p>This source is free; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License and by nameing of the originally author</p>
 * 
 *<p> this class maps the Library_Visual_scenes -tag</p>
 * 
 * @author Markus Zimmermann <a href="http://www.die-seite.ch">http://www.die-seite.ch</a>
 * @version 1.2
 */
class Library_visual_scenes {

    private HashMap<String,Visual_Scene> library_visual_scenes = new HashMap<String, Visual_Scene>();

    Library_visual_scenes(XML[] libScenes, Library_Materials libmat, Library_Geometries libGeo)
    {
    	if (libScenes.length==0) throw new ColladaLoaderException("library_visual_scenes tag not found");
        for (XML aScene : libScenes)
        {
            Visual_Scene s = new Visual_Scene(aScene, libmat, libGeo);
            library_visual_scenes.put(s.getID(), s);
        }
    }
/**
 *
 * @param id of the Visual_scenes-Tag
 * @return a mapped Visual_scenes-Object
 */
    Visual_Scene getVisualScenesByID(String id)
    {
        return library_visual_scenes.get(id);
    }

}
