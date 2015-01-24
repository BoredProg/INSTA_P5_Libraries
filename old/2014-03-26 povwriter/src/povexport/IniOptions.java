/**
 * *
 * The purpose of this library is to allow the export of processing sketches to
 * PovRAY Copyright (C) 2011 Martin Prout This library is free software; you can
 * redistribute it and/or modify it under the terms of the GNU Lesser General
 * Public License as published by the Free Software Foundation; either version
 * 2.1 of the License, or (at your option) any later version.
 *
 * Obtain a copy of the license at http://www.gnu.org/licenses/lgpl-2.1.html
 */
package povexport;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import static povexport.povwriter.POVConstants.*;

/**
 *
 * @author Martin Prout
 */
public class IniOptions implements Options {

    private List<String> options;
    // private String name;
    private File iniFile;
    static String COMMENT_ANTIALIAS = "; Antialias=on";
    static String ANTIALIAS = "Antialias=on";
    static String COMMENT_MAXMEMORY = "; Max_Image_Buffer";
    static String MAXMEMORY = "Max_Image_Buffer_Memory=516";
    static String COMMENT_SAMPLING_METHOD = "; Sampling_Method=2";
    static String SAMPLING_METHOD = "Sampling_Method=2";
    static String OUT_TYPE = "Output_File_Type=N8";
    static String NO_DISPLAY = "Display=off";
    static String COMMENT_THRESHOLD = "; Antialias_Threshold=0.3";
    static String THRESHOLD = "Antialias_Threshold=0.3";

    /**
     * Basic constructor for IniOptions
     *
     * @param width window width
     * @param height window height
     * @param qual see above for suggested input in values
     * @param name
     */
    public IniOptions(int width, int height, Quality qual, String name) {
        // this.name = name;
        iniFile = new File(name);
        File parent = iniFile.getParentFile();
        if (!parent.exists()) { // guard against no data directory
            boolean newDir = parent.mkdir();
            if (newDir) {
                System.err.println("info: created a data directory");
            }
        }
        options = new ArrayList<String>();
        options.add(String.format("; %s", iniFile.getName()));
        options.add(eol);
        options.add(eol);
        options.add(String.format("Input_File_Name=%s.pov", name.replace(".ini", "")));
        options.add(String.format("Output_File_Name=%s.png", name.replace(".ini", "")));
        options.add(String.format("Width=%d", width));
        options.add(String.format("Height=%d", height));
        options.add(String.format("Declare=ASPECT_RATIO=%.4f", width * 1.0f / height));
        options.add(String.format("Declare=ZDEPTH=%.4f", width * 0.288675f));
        setQuality(qual);
        //  this.name = name;
    }

    /**
     * @param qual PREVIEW .. MEDIUM .. HIGH .. HIGHEST .. GRAYSCALE Quality
     * enum
     */
    @Override
    public final void setQuality(Quality qual) {
        switch (qual) {

            case PREVIEW: // Render should be quick hence display off
                options.add(String.format("Quality=%d", qual.value()));
                options.add(NO_DISPLAY);
                options.add("Preview_Start_Size=32");
                options.add("Preview_End_Size=8");
                break;
            case MEDIUM: // display on
                options.add(String.format("Quality=%d", qual.value()));
                options.add("; Display=off");
                options.add(COMMENT_ANTIALIAS);
                options.add(COMMENT_SAMPLING_METHOD);
                options.add(COMMENT_THRESHOLD);
                options.add(COMMENT_MAXMEMORY);
                options.add(OUT_TYPE);
                break;
            case HIGH: // display on
                options.add(String.format("Quality=%d", qual.value()));
                options.add(ANTIALIAS);
                options.add(COMMENT_SAMPLING_METHOD);
                options.add(COMMENT_THRESHOLD);
                options.add(MAXMEMORY);
                options.add(OUT_TYPE);
                break;
            case HIGHEST: // display off
                options.add(String.format("Quality=%d", qual.value()));
                options.add(NO_DISPLAY);
                options.add(OUT_TYPE);
                options.add(MAXMEMORY);
                options.add(ANTIALIAS);
                options.add(SAMPLING_METHOD);
                options.add(THRESHOLD);
                break;
            case GRAYSCALE: // display is full color
                options.add(String.format("Quality=%d", qual.value()));
                options.add(ANTIALIAS);
                options.add(MAXMEMORY);
                options.add("Grayscale_Output=true");
                break;
            default:
                options.add(String.format("Quality=%d", 7));
                options.add(MAXMEMORY);
                options.add(OUT_TYPE);
        }
    }

    /**
     * Custom add option to ini file
     *
     * @param type
     * @param value
     */
    @Override
    public void addOption(String type, String value) {
        options.add(String.format("%s=%s", type, value));
    }

    /**
     * Custom add declare to ini file
     *
     * @param name
     * @param value
     */
    @Override
    public void addDeclare(String name, String value) {
        options.add(String.format("Declare=%s=%s", name, value));
    }

    /**
     * Public to satisfy common interface with CommandOptions
     *
     * @return option as List of String elements
     */
    @Override
    public List<String> getArgs() {
        return options;
    }

    @Override
    public void writeFile() throws UnsupportedEncodingException, FileNotFoundException, IOException {
        BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(iniFile), "UTF-8"));
        try {            
            for (String option : options) {
                bw.append(option).append(eol);
            }
        } finally {
            bw.flush();
            bw.close();
        }
    }

    /**
     * @return option String
     */
    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        for (String option : options) {
            sb.append(option).append(eol);
        }
        return sb.toString();
    }
}
