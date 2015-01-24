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

import processing.core.PApplet;

/**
 *
 * @author Martin Prout
 */
public class Button {

    /**
     *
     */
    protected int x;
    /**
     *
     */
    protected int y;
    /**
     *
     */
    protected int w;
    /**
     *
     */
    protected int h;
    /**
     *
     */
    protected boolean pressed = false;
    /**
     *
     */
    protected boolean clicked = false;
    /**
     *
     */
    protected final PApplet applet;

    /**
     *
     * @param outer
     * @param x coordinate 1st point
     * @param y coordinate 2nd point
     */
    public Button(final PApplet outer, int x, int y) {
        this.applet = outer;
        this.setActive(true);
        this.x = x;
        this.y = y;
    }

    /**
     * Set width and height of selectable rectangle
     *
     * @param width
     * @param height
     */
    public void setSize(int width, int height) {
        this.w = width;
        this.h = height;
    }

    /**
     * determine whether point(mx, my) is over rectangle
     *
     * @param mx
     * @param my
     * @return
     */
    public boolean overRect(int mx, int my) {
        if (mx >= this.x && my >= this.y && mx <= this.x + this.w && my <= this.y + this.h) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * Mouse events to register
     *
     * @param e
     */
    public void mouseEvent(processing.event.MouseEvent e) {
        int mx = e.getX();
        int my = e.getY();
        switch (e.getAction()) {
            case processing.event.MouseEvent.PRESS:
                pressed = overRect(mx, my); // only controls graphic
                break;
            case processing.event.MouseEvent.CLICK:
                if (clicked == false) // idempotent
                {
                    clicked = overRect(mx, my);
                }
                break;
        }
    }

    /**
     * Key events to register, in case GUI doesn't display eg with peasycam
     *
     * @param e
     */
    public void keyEvent(processing.event.KeyEvent e) {
        if (processing.event.MouseEvent.RELEASE == e.getAction()) {
            switch (e.getKey()) {
                case 'r':
                case 'R':
                    if (clicked == false) // idempotent
                    {
                        pressed = true;
                        clicked = true;
                    }
                    break;
            }
        }
    }

    /**
     *
     * @param active
     */
    protected void setActive(boolean active) {
        if (active) {
            this.applet.registerMethod("dispose", this);
            this.applet.registerMethod("mouseEvent", this);
            this.applet.registerMethod("keyEvent", this);
        } else {
            this.applet.unregisterMethod("mouseEvent", this);
            this.applet.unregisterMethod("keyEvent", this);
        }
    }

    /**
     * Requirement of a processing library
     */
    public void dispose() {
        setActive(false);
    }
}