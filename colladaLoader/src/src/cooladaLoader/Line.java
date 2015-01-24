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
public class Line implements Serializable
{
    /**
     * the Line-Position A
     */
    public Point3D A;
    /**
     * the Line-Position B
     */
    public Point3D B;
    /**
     * the color of the line
     */
    public Color colour;
}
