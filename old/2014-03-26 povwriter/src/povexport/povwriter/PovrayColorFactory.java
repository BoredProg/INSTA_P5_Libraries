/**
 * *
 * The purpose of this library is to allow the export of processing sketches to
 * PovRAY Copyright (C) 2013 Martin Prout This library is free software; you can
 * redistribute it and/or modify it under the terms of the GNU Lesser General
 * Public License as published by the Free Software Foundation; either version
 * 2.1 of the License, or (at your option) any later version.
 *
 * Obtain a copy of the license at http://www.gnu.org/licenses/lgpl-2.1.html
 */
package povexport.povwriter;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import static povexport.povwriter.POVConstants.*;

/**
 * The main function of color factory is to translate sketch colors to povray
 * format. Pre-loads colorMap with some standard colors otherwise new color are
 * automatically given a new name. Makes use of bit shifting, and PovRAY ability
 * to accept scalar color transforms to convert between the color formats.
 *
 * @author Martin Prout
 */
public class PovrayColorFactory  {

    int count = -1;
    int tCount = -1;
    private HashMap<Integer, String> colourMap;
    private List<Integer> declareList;

    /**
     * Private constructor, for singleton, initialize collections, and add
     * default colors
     */
    private PovrayColorFactory() {
        this.colourMap = new HashMap<Integer, String>();
        this.declareList = new ArrayList<Integer>();
        this.colourMap.put(-1, "White");
        this.colourMap.put(-16776961, "Blue");
        this.colourMap.put(-65536, "Red");
        this.colourMap.put(-16711936, "Green");
        this.colourMap.put(-256, "Yellow");
        this.colourMap.put(-16711681, "Cyan");
        this.colourMap.put(-65281, "Magenta");
        this.colourMap.put(Hue.SILVER.color(), "P_Silver3");
        this.colourMap.put(Hue.COPPER.color(), "P_Copper1");
        this.colourMap.put(Hue.SHINY_CHROME.color(), "P_Chrome1");
        this.colourMap.put(Hue.STEEL.color(), "P_Chrome2");
        this.colourMap.put(Hue.BRASS.color(), "P_Brass_4");
        this.colourMap.put(Hue.WINE_BOTTLE.color(), "Col_Glass_Winebottle");
        this.colourMap.put(Hue.OLD_GLASS.color(), "Col_Glass_Old");
        this.colourMap.put(Hue.NEON_BLUE.color(), "NeonBlue");
        this.colourMap.put(Hue.RED_MARBLE.color(), "RedMarble");
        this.colourMap.put(Hue.BUDDHA_GOLD.color(), "BuddhaGold");
        this.colourMap.put(-2500327, "BrightGold");
        this.colourMap.put(-16777216, "Black");
        this.colourMap.put(-7272954, "CornellRed");
        this.colourMap.put(-16368634, "CornellGreen");
        this.colourMap.put(-6452, "LineFill");
        this.colourMap.put(-11585249, "LineCol");
        this.colourMap.put(-1275074868, "TransFill");
    }

    /**
     * Supports Initialization on Demand Holder Idiom
     */
    private static class FactoryHolder {

        private static final PovrayColorFactory INSTANCE = new PovrayColorFactory();
    }

    /**
     * Supports Initialization on Demand Holder Idiom
     *
     * @return singleton instance of PovrayColorFactory
     */
    public static PovrayColorFactory getFactory() {
        return FactoryHolder.INSTANCE;
    }

    /**
     *
     * @param col integer
     * @return formatted StringBuilder
     */
    public StringBuilder addColor(int col) {
        StringBuilder colName;
        if (colourMap.containsKey(col)) {
            colName = new StringBuilder(colourMap.get(col));
        } else {
            declareList.add(col);           // NB: already guarded against duplicates
            if ((col >> 24 & 0xFF) < 255) { // then color has transparency
                tCount++;
                colName = new StringBuilder(PRE_COL_T);
                colName.append(tCount);
                colourMap.put(col, colName.toString());
            } else {                        // then color has no transparency
                count++;
                colName = new StringBuilder(PRE_COL);
                colName.append(count);
                colourMap.put(col, colName.toString());
            }
        }
        return colName;
    }

    /**
     * Once colors are loaded this is used to append color declarations
     *
     * @return povray color declarations
     */
    public StringBuilder declareColours() {
        StringBuilder builder = new StringBuilder("// --------------Begin declare colours from sketch\n");
        builder.append("// If empty then sketch colors already colored\n");
        Iterator<Integer> iterator = declareList.iterator();
        while (iterator.hasNext()) {
            String tmp;
            Integer povCol = iterator.next();
            builder.append(DECLARE);
            builder.append(SPC);
            tmp = colourMap.get(povCol);
            builder.append(tmp);
            builder.append(SPC);
            builder.append(ASSIGN);
            int red = povCol >> 16 & 0xFF;  // efficiently get red
            int green = povCol >> 8 & 0xFF; // efficiently get green
            int blue = povCol & 0xFF;       // efficiently get blue
            if (tmp.startsWith(PRE_COL_T)) {
                builder.append(" color rgbf< ");
                builder.append(red);
                builder.append(COMMA);
                builder.append(green);
                builder.append(COMMA);
                builder.append(blue);
                builder.append(COMMA);
                int alpha = povCol >> 24 & 0xFF; // efficiently get alpha
                builder.append(alpha);
            } else {
                builder.append(" color rgb< ");
                builder.append(red);
                builder.append(COMMA);
                builder.append(green);
                builder.append(COMMA);
                builder.append(blue);
            }
            builder.append(" >/255;\n");  // NB: povray does the RGB calculation
        }
        builder.append("// --------------end of declare colours for sketch\n\n\n");
        builder.append("// --------------processing sketch begins here\n\n\n");
        return builder;
    }
}
