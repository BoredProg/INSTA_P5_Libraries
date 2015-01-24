package cooladaLoader.xmlMapping;
import cooladaLoader.ColladaLoaderException;
import processing.data.XML;

/**
 * <p>Lucerne University of Applied Sciences and Arts <a href="http://www.hslu.ch">http://www.hslu.ch</a></p>
 *
 * <p>This source is free; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License and by nameing of the originally author</p>
 *
 *<p> this class maps the Image -tag</p>
 *
 * @author Markus Zimmermann <a href="http://www.die-seite.ch">http://www.die-seite.ch</a>
 * @version 1.2
 */
class Image {
    
    private String bild;
    private String ID;

    Image(XML image)
    {
        ID = image.getString("id");
        bild = image.getChild("init_from").getContent();
        if (ID==null || bild==null)
        	throw new ColladaLoaderException("an Image Tag could not be parsed");

   }
/**
 * the ID of the Image-tag
 * @return
 */
    String getID()
    {
        return ID;
    }
    /**
     *
     * @return the Filename of the picture
     */
    String getPicture()
    {
        return bild;
    }
    @Override
    public String toString()
    {
        return "Image-Filename '"+bild+"'";
    }

}
