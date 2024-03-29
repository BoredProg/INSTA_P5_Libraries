package povexport.povwriter;

/**
 * *
 * 
 * The purpose of this library is to allow the export of processing sketches to
 * PovRAY Copyright (C) 2013 Martin Prout This library is free software; you can
 * redistribute it and/or modify it under the terms of the GNU Lesser General
 * Public License as published by the Free Software Foundation; either version
 * 2.1 of the License, or (at your option) any later version.
 *
 * Obtain a copy of the license at http://www.gnu.org/licenses/lgpl-2.1.html
 */
public class Texture {

    private Finish finish;
    private int colour;

    /**
     * 
     * @param finish
     * @param colour
     */
    public Texture(Finish finish, int colour) {
        this.colour = colour;
        this.finish = finish;
    }

    /**
     * 
     * @param finish
     * @param colour
     */
    public Texture(Finish finish, Hue colour) {
        this(finish, colour.color());
    }

    /**
     * 
     * @param finish
     */
    public Texture(Finish finish) {
        this(finish, Hue.WHITE.color()); //default white color
    }

    /**
     * 
     * @return
     */
    public int getColor() {
        return colour;
    }

    /**
     * 
     * @return
     */
    public Finish getFinish() {
        return finish;
    }

    @Override
    public boolean equals(Object o) {
        boolean result;
        result = (o == null)||(o.getClass() != Texture.class)? false
                : (o.hashCode() == this.hashCode()) ? true : false;
        return result;
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 17 * hash + (this.finish != null ? this.finish.hashCode() : 0);
        hash = 17 * hash + this.colour;
        return hash;
    }
}

