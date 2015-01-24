package cooladaLoader.xmlMapping;
import processing.data.XML;

import java.util.HashMap;
import java.util.Set;

import cooladaLoader.ColladaLoaderException;

/**
 * <p>Lucerne University of Applied Sciences and Arts <a href="http://www.hslu.ch">http://www.hslu.ch</a></p>
 *
 * <p>This source is free; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License and by nameing of the originally author</p>
 * 
 *<p> this class maps the Library_Effects-tag</p>
 * 
 * @author Markus Zimmermann <a href="http://www.die-seite.ch">http://www.die-seite.ch</a>
 * @version 1.2
 */
class Library_Effects {

    private HashMap<String,Effect> library_effects = new HashMap<String, Effect>();

    Library_Effects(XML[] effects, Library_Images libImg)
    {
    	if (effects.length==0) throw new ColladaLoaderException("library_effects tag not found");
        for (XML eff : effects)
        {
            Effect e = new Effect(eff, libImg);
            library_effects.put(e.getID(), e);
        }

    }
/**
 *
 * @param id of the Effect-Tag
 * @return a mapped Effect
 */
    Effect getEffectByID(String id)
    {
        return library_effects.get(id);
    }

}
