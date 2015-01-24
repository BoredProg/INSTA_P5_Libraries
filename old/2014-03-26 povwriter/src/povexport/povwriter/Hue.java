package povexport.povwriter;

/**
 *
 * The purpose of this library is to allow the export of processing sketches to
 * PovRAY Copyright (C) 2013 Martin Prout This library is free software; you can
 * redistribute it and/or modify it under the terms of the GNU Lesser General
 * Public License as published by the Free Software Foundation; either version
 * 2.1 of the License, or (at your option) any later version.
 *
 * Obtain a copy of the license at http://www.gnu.org/licenses/lgpl-2.1.html
 */
public enum Hue {

    /**
     *
     */
    WHITE(-1),
    /**
     *
     */
    CORNELL_RED(-7272954),
    /**
     *
     */
    CORNELL_GREEN(-16368634),
    /**
     *
     */
    RED(-65536),
    /**
     *
     */
    GREEN(-16711936),
    /**
     *
     */
    BLUE(-16776961),
    /**
     *
     */
    CYAN(-16711681),
    /**
     *
     */
    YELLOW(-256),
    /**
     *
     */
    MAGENTA(-65281),
    /**
     *
     */
    OLD_GLASS(-640882983),
    /**
     *
     */
    WINE_BOTTLE(-1721321370),
    /**
     *
     */
    SILVER(-987674),
    /**
     *
     */
    BRASS(-5865408),
    /**
     *
     */
    SHINY_CHROME(-13421773),
    /**
     *
     */
    STEEL(-10262162),
    /**
     *
     */
    COPPER(-10079450),
    /**
     *
     */
    BUDDHA_GOLD(-4087804),
    /**
     *
     */
    BRIGHT_GOLD(-2500327),
    /**
     *
     */
    NEON_BLUE(-11710977),
    /**
     *
     */
    RED_MARBLE(-5293240),
      /**
     *
     */
    MIRROR(855638015),
    /**
     *
     */
    BLACK(-16777216);
    private final int colour;

    Hue(int colour) {
        this.colour = colour;
    }

    /**
     *
     * @param col
     * @return
     */
    public static Hue getHue(int col) {
        Hue tmp = Hue.WHITE;
        for (Hue hue : Hue.values()) {
            if (hue.color() == col) {
                tmp = hue;
            }
        }
        return tmp;
    }

    /**
     *
     * @return
     */
    public final int color() {
        return colour;
    }
}
