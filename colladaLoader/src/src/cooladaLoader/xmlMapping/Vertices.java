package cooladaLoader.xmlMapping;
import cooladaLoader.ColladaLoaderException;
import processing.data.XML;
/**
 * <p>Lucerne University of Applied Sciences and Arts <a href="http://www.hslu.ch">http://www.hslu.ch</a></p>
 *
 * <p>This source is free; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License and by nameing of the originally author</p>
 * 
 *<p> this class is a Helperclass to map the vertice-tag inside geometry-tag</p>
 * 
 * @author Markus Zimmermann <a href="http://www.die-seite.ch">http://www.die-seite.ch</a>
 * @version 1.2
 */
class Vertices extends SubTag{

    private String ID;
    private String nextSource;

    Vertices(XML vertice)
    {

        //analyze the vertices-Tag, search for semantic POSITION (only that is interesting)
        for (XML vertice_input : vertice.getChildren("input"))
            if (vertice_input.getString("semantic").equals("POSITION"))
            {
                ID = vertice.getString("id");
                nextSource = vertice_input.getString("source").substring(1);
            }
        if (ID==null || nextSource==null)
        	throw new ColladaLoaderException("vertices tag not parsed");


    }
 
    @Override
    String getNextSource() {
        return nextSource;
    }

    @Override
    String getID() {
        return ID;
    }


}
