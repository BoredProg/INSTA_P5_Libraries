/***
 * The purpose of this library is to allow the export of processing sketches to PovRAY
 * Copyright (C) 2013 Martin Prout
 * This library is free software; you can redistribute it and/or modify it under the terms
 * of the GNU Lesser General Public License as published by the Free Software Foundation; 
 * either version 2.1 of the License, or (at your option) any later version.
 * 
 * Obtain a copy of the license at http://www.gnu.org/licenses/lgpl-2.1.html
 */


package povexport.povwriter;

/**
 * Fragments of Strings used in PovRAY files
 * @author Martin Prout
 */
public final class POVConstants {
    private POVConstants(){throw new InstantiationError();}
    /**
     * assign char
     */
    public static final char ASSIGN = '=';
    /**
     * close curl char
     */
    public static final char CLOSE_CURLY = '}';
    /**
     * a new line String
     */
    public static final String eol = System.getProperty("line.separator");
    /**
     * a single space character
     */
    public static final char SPC = ' ';
    /**
     * format used in vertices/color in PovRAY
     */
    public static final String COMMA = ", ";
    /**
     * format used between vertices in PovRAY
     */
    public static final String CLOSE_OPEN = ">, <";   //
    /**
     *
     */
    public static final String DECLARE = "#declare";
    /**
     *
     */
    public static final String FINISH2 = "Finish2";
    /**
     *
     */
    public static final String FINISH = "finish{ ";
    /**
     *
     */
    public static final String UNION = "union{\n";
    /**
     * pigment names to be defined in template
     */
    public static final String PIGMENT = "pigment{ ";
    /**
     *  color/colour/coluer
     */
    public static final String COLOR = "colour ";
    /**
     *  prefix used by color factory for transparent colors
     */
    public static final String PRE_COL = "Colour";
    /**
     * prefix used by color factory for transparent colors
     */
    public static final String PRE_COL_T = "ColourT";
    /**
     * texture names to be defined in template
     */
    public static final String TEXTURE = "texture{ ";
    /**
     * A default texture for line
     */
    public static final String TEXTURE0 = "Texture0";
    /**
     * equivalent of stroke weight for povray line
     */
    public static final String SWIDTH = "SWIDTH";
}
