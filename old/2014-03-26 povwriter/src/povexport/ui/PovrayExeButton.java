/**
 * Copyright (C) 2013 Martin Prout The purpose of this library is to allow the
 * export of processing sketches to PovRAY (PovRAY SDL) This library is free
 * software; you can redistribute it and/or modify it under the terms of the GNU
 * Lesser General Public License as published by the Free Software Foundation;
 * either version 2.1 of the License, or (at your option) any later version.
 *
 * Obtain a copy of the license at http://www.gnu.org/licenses/lgpl-2.1.html
 */
package povexport.ui;

import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JDialog;
import javax.swing.JFileChooser;
import javax.swing.SwingUtilities;
import processing.core.PApplet;
import processing.core.PImage;

/**
 *
 * @author Martin Prout
 */
public class PovrayExeButton extends Button {

    private PImage baseImage;
    private PImage clickImage;
    private PImage currentImage;
    private boolean show = true;
    Properties prop;
    private final String HOME = System.getProperty("user.home");
    private final String SEPARATOR = System.getProperty("file.separator");
    private final String POV_HOME = HOME + SEPARATOR + ".povwriter2" + SEPARATOR;
    private final String PROP_FILE = POV_HOME + "povwriter.properties";
    private String povrayTemplate = POV_HOME + "original.pov";

    /**
     * NB: don't try to register dispose here 
     * @see: povexport2.ui.Button
     * @param applet
     * @param x
     * @param y
     */
    public PovrayExeButton(PApplet applet, int x, int y) {
        super(applet, x, y);
        applet.registerMethod("draw", this);
        baseImage = applet.loadImage("povray.png");
        clickImage = applet.loadImage("ppovray.png");
        setSize(baseImage.width, baseImage.height);
        this.currentImage = baseImage;
        prop = new Properties();
        prop.setProperty("template", povrayTemplate);
        prop.setProperty("first.run", "true");
    }

    /**
     * Update GUI
     */
    public void update() {
        if (pressed) {
            currentImage = clickImage;
        } else {
            currentImage = baseImage;
        }
    }

    /**
     * Get record button status
     *
     * @return
     */
    public boolean getClicked() {
        return clicked;
    }

    /**
     * hide record button
     */
    public void hide() {
        show = false;
    }

    /**
     * show gui
     */
    public void display() {
        if (show) {
            applet.image(currentImage, x, y, currentImage.width, currentImage.height);
        }
    }

    /**
     *
     */
    public void storeSettings() {
        try {
            storeSettingsImpl();
        } catch (IOException ex) {
            Logger.getLogger(PovrayExeButton.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     *
     * @throws IOException
     */
    protected final void storeSettingsImpl() throws IOException {
        String comments = "Povray Properties";
        BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(PROP_FILE), "UTF8"));
        try {
            prop.store(bw, comments);
        } finally {
            bw.close();
        }
    }

    /**
     *
     */
    public void draw() {
        update();
        display();
        if (getClicked()) {
            chooseTemplate();
            clicked = false;
            pressed = false;
        }
    }

    /**
     *
     * @param path
     */
    public void setPathToPovray(String path) {
        prop.setProperty("povrayPath", path);
        storeSettings();
    }

    /**
     * Launches a JFileChooser instance allows you to choose a PovRAY executable
     */
    public void chooseTemplate() {
        if (applet.isVisible()) {
            SwingUtilities.invokeLater(new Runnable() {
                @Override
                public void run() {
                    final JFileChooser fc = new JFileChooser("/");
                    int returnVal = fc.showDialog(new JDialog(), "Choose Povray Executable");
                    if (returnVal == JFileChooser.APPROVE_OPTION) {
                        setPathToPovray(fc.getSelectedFile().getAbsolutePath());
                    }
                }
            });
        }
    }

    /**
     * Dispose of images on dispose
     */
    @Override
    public void dispose() {
        baseImage = null;
        clickImage = null;
        currentImage = null;
        this.applet.unregisterMethod("draw", this);
    }
}
