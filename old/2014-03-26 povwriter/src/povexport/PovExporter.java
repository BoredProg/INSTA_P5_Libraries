/**
 *
 * The purpose of this library is to allow the export of processing sketches to
 * PovRAY Copyright (C) 2012 Martin Prout This library is free software; you can
 * redistribute it and/or modify it under the terms of the GNU Lesser General
 * Public License as published by the Free Software Foundation; either version
 * 2.1 of the License, or (at your option) any later version.
 *
 * Obtain a copy of the license at http://www.gnu.org/licenses/lgpl-2.1.html
 */
package povexport;

import java.io.*;
import static java.lang.System.out;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JDialog;
import javax.swing.JFileChooser;
import javax.swing.SwingUtilities;
import povexport.povwriter.Hue;
import povexport.ui.ControlGUI;
import processing.core.PApplet;
import static processing.core.PConstants.*;

/**
 * This is the setup class for RawPovray that does the real work, revised
 * version briefly flirted with command line options for their versatility, but
 * I now very much favour use of an ini file...
 *
 * @todo implement a special case for sphere export now modelX, modelY and
 * modelZ appear to be working.....
 *
 * @author Martin Prout
 */
public class PovExporter {

    private PApplet parent;
    private final String VERSION = "2.0";
    /**
     * Interface to RawPovray as a String
     */
    public static final String POV = "povexport.RawPovray";
    private Options options;
    private Properties prop;
    private final String HOME = System.getProperty("user.home");
    private final String SEPARATOR = System.getProperty("file.separator");
    private final String POV_HOME = HOME + SEPARATOR + ".povwriter2" + SEPARATOR;
    private final String PROP_FILE = POV_HOME + "povwriter.properties";
    private String povrayTemplate = POV_HOME + "original.pov";
    private String INFO_FORMAT = "info: %s";
    private String povrayPath;
    private String storedTemplate;
    private String iniFile;
    private volatile String firstRun = "false";
    private State state = State.START;
    private ControlGUI gui;
    /**
     * This is the external povray process
     */
    public Process povray = null;
    private boolean notwritten = true;

    /**
     * PovExporter constructor to satisfy processing library requirement
     *
     * @param parent PApplet
     */
    public PovExporter(PApplet parent) {
        this.parent = parent;
        this.setActive(true);
        this.gui = new ControlGUI(this.parent, 10, 10);
        this.parent.camera();
        prop = new Properties();
        loadProperties();
        out.println(String.format(INFO_FORMAT, "povwriter version " + version()));
        out.println(String.format(INFO_FORMAT, "requires version processing-2.0b8 or greater"));
    }

    /**
     *
     * @param state
     */
    public void setState(State state) {
        this.state = state;
    }

    /**
     *
     * @param state
     * @return
     */
    public boolean getState(State state) {
        return (this.state == state);
    }

    /**
     * Use to set scalar values (or with ingenuity switches) in pov file
     *
     * @param name that is used in pov file eg SizeP5
     * @param value scalar value as a string
     */
    public void addDeclareOption(String name, String value) {
        options.addDeclare(name, value);
    }

    /**
     * Scale processing sketch elements within PovRAY scene
     *
     * @param scale scalar value as a float (at suitable precision)
     */
    public void scalePovray(float scale) {
        options.addDeclare("ScaleP5", String.format("%.4f", scale));
    }

    /**
     * Set Line Width
     *
     * @param width float (avoid spurious precision)
     */
    public void lineWidth(float width) {
        options.addDeclare("SWIDTH", String.format("%.2f", width));
    }

    /**
     * Overloaded function to deal with in input Set Line Width
     *
     * @param width int (avoid spurious precision)
     */
    public void lineWidth(int width) {
        options.addDeclare("SWIDTH", String.format("%d", width));
    }

    /**
     * Rotate processing sketch elements within PovRAY scene (Y)
     *
     * @param rot degrees around Y axis
     */
    public void rotatePovray(int rot) {
        options.addDeclare("RotYP5", String.format("%d", rot));
    }

    /**
     * Use this to set PovRAY options that haven't been set eg display gamma
     *
     * @param name
     * @param value
     */
    public void addOption(String name, String value) {
        options.addOption(name, value);
    }

    /**
     * Use this to set the stored povray path
     *
     * @param povrayPath String path to povray on local system
     */
    public void setPovrayPath(String povrayPath) {
        prop.setProperty("povrayPath", povrayPath);
    }

    /**
     * Use this to control whether 'control' button get displayed
     *
     * @param True String functioning as a boolean
     */
//    public void showGui(String True) {
//        if (True.equalsIgnoreCase("false")){this.gui.hide();}
//        prop.setProperty("showGui", True.toLowerCase());
//    }
    /**
     * Launches a JFileChooser instance allows you to choose an alternative
     * PovRAY template file for current and future sketches
     */
    public void chooseTemplate() {
        if (parent.isVisible()) {
            SwingUtilities.invokeLater(new Runnable() {
                @Override
                public void run() {
                    final JFileChooser fc = new JFileChooser(POV_HOME);
                    fc.setFileView(new TemplateFileView());
                    fc.addChoosableFileFilter(new PovFilter());
                    int returnVal = fc.showDialog(new JDialog(), "Choose Template");
                    if (returnVal == JFileChooser.APPROVE_OPTION) {
                        try {
                            setTemplateFile(fc.getSelectedFile());
                        } catch (IOException ex) {
                            Logger.getLogger(PovExporter.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                }
            });
        }
    }

    /**
     * Use this in your sketch to get the stored povray path
     *
     * @return path String to povray executable on local system
     */
    public String getPovrayPath() {
        return povrayPath;
    }

    /**
     * Call external process PovRAY return proc
     *
     * @return proc Process
     */
    public Process rayTrace() {

        if (iniFile != null) {
            try {
                String[] args = new String[]{povrayPath, iniFile};
                povray = new ProcessBuilder(args).start();
                redirect(povray.getErrorStream());
            } catch (IOException ex) {
                Logger.getLogger(PovExporter.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return povray;
    }

    /**
     * Provides callback for template FileChooser, stores choice for future
     *
     * @param pov template File
     * @throws IOException
     */
    protected final void setTemplateFile(File pov) throws IOException {
        prop.setProperty("template", pov.getAbsolutePath());
        storeSettingsImpl();
    }

    /**
     * load stored properties from file, or default values. The coded defaults
     * for povrayPath would suit a linux user with povray 3.7 beta
     */
    private void loadProperties() {
        try {
            InputStreamReader is = new InputStreamReader(new FileInputStream(PROP_FILE), "UTF-8");
            try {
                prop.load(is);
            } finally {
                is.close();
            }
            storedTemplate = prop.getProperty("template", povrayTemplate);
            povrayPath = prop.getProperty("povrayPath", "/usr/local/bin/povray");
            firstRun = prop.getProperty("first.run", "true");
            if (firstRun.equals("false")) {
                povrayTemplate = storedTemplate; // used stored value rather than the default
            }
        } catch (FileNotFoundException e) {
            System.err.println("Warning: you should unzip template.zip in " + HOME);
            Logger.getLogger(PovExporter.class.getName()).log(Level.SEVERE, null, e);
        } catch (IOException ex) {
            Logger.getLogger(PovExporter.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     *
     * @throws IOException
     */
    protected final void storeSettingsImpl() throws IOException {
        String comments = "Povray Properties";
        if (firstRun.equals("true")) {
            prop.setProperty("first.run", "false");
            prop.setProperty("template", povrayTemplate); // store default in properties
        }
        BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(PROP_FILE), "UTF8"));
        try {
            prop.store(bw, comments);
        } finally {
            bw.close();
        }
    }

    /**
     * Current settings are stored to the properties file, since PovWriter/etc
     * use the stored settings when available, this function should always be
     * called, if you want to change runtime settings (not just to store
     * settings).
     */
    public void storeSettings() {
        try {
            storeSettingsImpl();
        } catch (IOException ex) {
            Logger.getLogger(PovExporter.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * The ini file stores the PovRAY raytrace options
     *
     * @param name path of ini file
     * @param quality
     */
    public void createIniFile(String name, Quality quality) {
        iniFile = name;
        options = new IniOptions(parent.width, parent.height, quality, name);
    }

    /**
     * The ini file stores the PovRAY raytrace options With a default of quality
     * medium
     *
     * @param dataPath
     *
     */
    public void createIniFile(String dataPath) {
        createIniFile(dataPath, Quality.MEDIUM);
    }

    /**
     * The ini file is a small file that sets the quality of ray-tracing, but
     * you can use custom declares to set scaling, translations etc.
     */
    public void writeIniFile() {
        try {
            options.writeFile();
        } catch (FileNotFoundException nf) {
            Logger.getLogger(PovExporter.class.getName()).log(Level.SEVERE, null, nf);
        } catch (UnsupportedEncodingException enc) {
            Logger.getLogger(PovExporter.class.getName()).log(Level.SEVERE, null, enc);
        } catch (IOException ex) {
            Logger.getLogger(PovExporter.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Set hue, also affects povray finish eg Hue.WINE_BOTTLE = Finish.GLASS
     *
     * @param texture
     */
    public void setHue(Hue texture) {
        parent.fill(texture.color());
    }

    /**
     * Draw a better sphere for processing that is better suited to PovRAY
     * export, possibly not required for processing 2.0
     *
     * @param radius float the detail is governed by size of the Sphere
     * @deprecated
     */
    @Deprecated
    public void sphere(float radius) {
        int detail = (radius < 50) ? 3 : (radius < 150) ? 4 : 5;
        sphere(radius, detail);
        //  int col = parent.g.fillColor;
        // PMatrix3D pos = (PMatrix3D) parent.g.getMatrix();
        // float[] posArray = pos.get(new float[]{1, 2, 3});
    }

    /**
     * Draw a better sphere for processing that is better suited to PovRAY
     * export
     *
     * @param radius float
     * @param detail int 80, 320, 1280, 5120 ... triangles
     * @deprecated
     */
    @Deprecated
    public void sphere(float radius, int detail) {
        Sphere sphere = new Sphere(this.parent);
        sphere.draw(detail, radius);
    }

    /**
     * Update GUI and update State from START to RECORDING
     */
    public void update() {
        if (this.getState(State.START) && gui.getClicked()) {
            this.setState(State.RECORDING);
        }
        this.gui.update();
    }

    /**
     * beginRaw and endRaw should wrap what you want to ray-trace
     *
     * @param filename
     */
    public void beginRaw(String filename) {
        parent.pushMatrix();
        // needed so we can display button in regular place
        if (getState(State.RECORDING)) {

            out.println(String.format(INFO_FORMAT, State.RECORDING));
            parent.noLights();    // let PovRAY do the lighting
            parent.beginRaw(PovExporter.POV, filename);

        }


    }

    /**
     * beginRaw and endRaw should wrap what you want to ray-trace
     */
    public void endRaw() {
        if (this.getState(State.RECORDING)) {

            parent.endRaw();
            this.setState(State.RECORDED);
            out.println(String.format(INFO_FORMAT, State.RECORDED));
        }
        if ((this.getState(State.RECORDED)) && (povray == null)) {
            povray = this.rayTrace();
            if (povray != null) {
                out.println(String.format(INFO_FORMAT, State.TRACING));
                this.setState(State.TRACING);
            }
        }
        try {
            if ((this.getState(State.TRACING)) && povray.waitFor() == 0) {
                this.setState(State.TRACED);      // set State as TRACED when povray has finished
                out.println(String.format(INFO_FORMAT, State.TRACED));
            }
        } catch (InterruptedException ex) {
            Logger.getLogger(PovExporter.class.getName()).log(Level.SEVERE, null, ex);
        } // following matches previous pushMatrix() needed to place button
        parent.popMatrix();
    }

    /**
     * Check whether we've got to TRACED State
     *
     * @return
     */
    public boolean traced() {
        return getState(State.TRACED);
    }

    /**
     * Needed to show button, called in sketch at end of draw loop see draw
     */
    public void displayRecordButton() {
        if (!this.getState(State.TRACED)) {
            parent.hint(DISABLE_DEPTH_TEST);
            parent.noLights(); // ideas from Amnon Owed
            parent.camera();   // from ideas by Amnon Owed
            this.gui.display();
            parent.hint(ENABLE_DEPTH_TEST);
        }
    }

    /**
     * Reduce amount of boilerplate code by two lines, ensure setting are stored
     * before sketch displayed, boolean guards against repeated saving?
     */
    public void pre() {
        if (notwritten) {
            this.storeSettings();
            this.writeIniFile();
            notwritten = false;
        }
        displayRecordButton();
    }

    /**
     * Processing libraries require this, doesn't do much here
     */
    public final void dispose() {
        this.setActive(false);
        this.parent.unregisterMethod("pre", this);
        gui.dispose();
        povray.destroy();
    }

    /**
     * Register this with PApplet to get drawn on sketch
     */
    public void draw() {
        displayRecordButton();
        update();
    }

    private static void redirect(InputStream in) throws IOException {
        int c;
        while ((c = in.read()) != -1) {
            out.write((char) c);
        }
    }

    /**
     *
     * @param active
     */
    public final void setActive(boolean active) {
        if (active) {
            this.parent.registerMethod("dispose", this);
            this.parent.registerMethod("draw", this);
            this.parent.registerMethod("pre", this);
        } else {
            this.parent.unregisterMethod("draw", this);
            this.parent.unregisterMethod("pre", this);
        }
    }

    /**
     * Returns library version no, processing libraries require this
     *
     * @return
     */
    public final String version() {
        return VERSION;
    }
}
