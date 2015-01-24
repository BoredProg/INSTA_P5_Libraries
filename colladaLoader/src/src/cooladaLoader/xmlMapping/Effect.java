package cooladaLoader.xmlMapping;
import java.util.HashMap;

import cooladaLoader.ColladaLoaderException;
import processing.data.XML;

/**
 * <p>Lucerne University of Applied Sciences and Arts <a href="http://www.hslu.ch">http://www.hslu.ch</a></p>
 *
 * <p>This source is free; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License and by nameing of the originally author</p>
 * 
 * <p>this class maps the effect-tag</p>
 * 
 * @author Markus Zimmermann <a href="http://www.die-seite.ch">http://www.die-seite.ch</a>
 * @version 1.2
 */
class Effect {

    private String ID;
    private Image image;
    private float[] color;
    private boolean hasTexture = false;

    Effect(XML effect, Library_Images images)
    {
    	
        ID = effect.getString("id");
        if (ID==null)
        	throw new ColladaLoaderException("effect tag not parsed");
 
        XML texture = effect.getChild("profile_COMMON/technique/lambert/diffuse/texture");
        XML color = effect.getChild("profile_COMMON/technique/lambert/diffuse/color");
        //try another variant of color if null
        if (color == null) color = effect.getChild("profile_COMMON/technique/constant/transparent/color");
        
        if (texture==null && color == null)
        	throw new ColladaLoaderException("effect tag not parsed (texture or color subtag)");
        
        if (texture !=null)
        {
            hasTexture = true;
            //read Paramtags
            HashMap<String, NewParam> params = new HashMap<String, NewParam>();
            XML[] newParams = effect.getChildren("profile_COMMON/newparam");
            if (newParams.length==0) 
            	throw new ColladaLoaderException("effect tag not parsed (newparam subtag)");
            for (XML e: newParams)
            {
                NewParam p = new NewParam(e);
                params.put(p.getID(), p);
            }
            //set Imagevariable
            String imageID = params.get(params.get(texture.getString("texture")).getNextSource()).getNextSource();
            image = images.getImageByID(imageID);
            if (image==null)
            	throw new ColladaLoaderException("effect tag not parsed (newparam texture attribute)");
        }

        if (color !=null)
        {
            hasTexture = false;
            String[] scolor = color.getContent().split(" ");
            this.color = new float[]{Float.parseFloat(scolor[0]),Float.parseFloat(scolor[1]),Float.parseFloat(scolor[2]),Float.parseFloat(scolor[3])};
        }

    }
/**
 * 
 * @return the ID of the Effect-Tag
 */
    String getID()
    {
        return ID;
    }
    /**
     * gives the answer if the effect contains a color or an image
     * @return false on color, true on image
     */
    boolean hasTexture()
    {
        return hasTexture;
    }
/**
 * returns the image of the texture
 * @return the image
 */
    Image getImage()
    {
        return image;
    }
    /**
     * returns an Array in the Format [red,green,blue,transparent]
     * @return the color
     */
    float[] getColor()
    {
        return color;
    }

    @Override
    public String toString()
    {
        String s = "";
        s+= "Effect ID '"+ID+"' contains"+((hasTexture)?" an Image with "+image:"Colors: Red = "+color[0]+" green = "+color[1]+" blue = "+color[2]+" transparence = "+color[3]);
        return s;
    }

}
