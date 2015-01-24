package cooladaLoader;

import java.io.Serializable;

/**
 * <p>Lucerne University of Applied Sciences and Arts <a href="http://www.hslu.ch">http://www.hslu.ch</a></p>
 *
 * <p>This source is free; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License and by nameing of the originally author</p>
 *
 * @author Markus Zimmermann <a href="http://www.die-seite.ch">http://www.die-seite.ch</a>
 * @version 1.0
 */
public class Color implements Serializable{

    public Color(float red,float green, float blue,float transp )
    {
        this.red = red;
        this.green = green;
        this.blue = blue;
        this.transparency = transp;
    }
    /**
     * range goes from 0 to 1.0 (0=black)
     */
    public float red;
    /**
     * range goes from 0 to 1.0 (0=black)
     */
    public float green;
    /**
     * range goes from 0 to 1.0 (0=black)
     */
    public float blue;
    /**
     * range goes from 0 to 1.0 (0=transparent)
     */
    public float transparency;
}
