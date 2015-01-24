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

import java.io.*;
import java.util.HashSet;
import java.util.Properties;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import static povexport.povwriter.POVConstants.*;

/**
 * File input/output functionality here
 *
 * @author Martin Prout
 */
public class PovWriter {

    private final String HOME = System.getProperty("user.home");
    private final String SEPARATOR = System.getProperty("file.separator");
    private final String POV_HOME = HOME + SEPARATOR + ".povwriter2" + SEPARATOR;
    private final String PROP_FILE = POV_HOME + "povwriter.properties";
    private final String POV_FILE = POV_HOME + "original.pov";
    private Properties prop;
    private final ObjectBuilder builder;
    private String templatePath;
    private BufferedWriter bw;
    private Set<Integer> colors = null;
    private String defaultTemplate = POV_FILE;

    /**
     * Constructor for PoVWriter class Initializes object builder (String
     * building utility) Initializes colors HashSet (controls duplicates)
     * Initializes the PovRAY file writer instance, loads stored parameters from
     * properties file (this is mainly to ensure we are using the stored
     * template file, that was set by PovExporter, or the default
     * "original.pov")
     *
     * @param pov PrintWriter output
     */
    public PovWriter(BufferedWriter pov) {
        builder = new ObjectBuilder();
        colors = new HashSet<Integer>();
        this.bw = pov;
        loadTemplate();
    }

    /**
     * load the template file
     */
    private void loadTemplate() {
        prop = new Properties();
        try {
            InputStreamReader is = new InputStreamReader(new FileInputStream(PROP_FILE), "UTF-8");
            try {
                prop.load(is);
                templatePath = prop.getProperty("template", defaultTemplate);
            } finally {
                is.close();
            }
        } catch (FileNotFoundException e) {
            Logger.getLogger(PovWriter.class.getName()).log(Level.SEVERE, null, e);
            System.out.println("You should unzip povwriter resources in " + POV_HOME);
        } catch (IOException ex) {
            Logger.getLogger(PovWriter.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Write the PovRAY header note using UTF character set, and system line
     * endings
     * @throws IOException 
     */
    public void writeHeader() throws IOException {
        FileInputStream fis = new FileInputStream(templatePath);
        InputStreamReader isr = new InputStreamReader(fis, "UTF8");
        BufferedReader reader = new BufferedReader(isr);
        while (reader.ready()) {
            bw.append(reader.readLine());
            bw.append(eol);
        }
        reader.close();
        bw.flush();
    }

    /**
     * This doesn't get used it is just an idea (wouldn't need to declare any
     * new colors)
     *
     * @param points
     */
    public void writeTriangle(float[][] points) {
        try {
            builder.writeTriangle(points, -1); // default to White fill
        } catch (IOException ex) {
            Logger.getLogger(PovWriter.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Use builder writeTriangle function to do the heavy lifting including
     * converting the color format form processing to PovRAY
     *
     * @param points 3 * 3 array of float required
     * @param col takes processing color as an integer
     */
    public void writeTriangle(float[][] points, int col) {
        try {
            builder.writeTriangle(points, col);
        } catch (IOException ex) {
            Logger.getLogger(PovWriter.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     *
     * @param pt1
     * @param pt2
     * @throws IOException
     */
    public void writeLine(float[] pt1, float[] pt2) throws IOException {
        builder.writeLine(pt1, pt2);
    }

    /**
     *
     * @param pt1
     * @param pt2
     * @throws IOException
     */
    public void writeLine2(float[] pt1, float[] pt2) throws IOException {
        builder.writeLine(pt1, pt2);
    }

    /**
     * Finish writing processing objects to a tmp file, append color
     * declarations to the PovRAY file begin the processing sketch by starting
     * the union, reads from tmp file and writes to PovRAY file closes the
     * reader.
     */
    public void declare() {
        try {
            builder.endProcessingObjects(); // finish writing objects to tmp file
            PovrayColorFactory factory = PovrayColorFactory.getFactory();
            TextureFactory tf = TextureFactory.getFactory();
            for (Integer col : colors) {             // initialize factory create sketch colors
                factory.addColor(col);
            }
            bw.append(factory.declareColours()); // declare sketch colors as reqd
            bw.append(tf.includeFinishes());
            bw.append(tf.declareTextures());
            bw.append(builder.beginUnion());
            FileInputStream fis = new FileInputStream(builder.getTempName());
            InputStreamReader isr = new InputStreamReader(fis, "UTF8");
            BufferedReader reader = new BufferedReader(isr);
            try {
                while (reader.ready()) {
                    bw.append(reader.readLine());
                    bw.append(eol);
                }
            } finally {
                bw.flush();
            }
            reader.close();
        } catch (IOException ex) {
            Logger.getLogger(PovWriter.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * clear the colors
     */
    public void dispose() {
        colors.clear();

    }
}
