/**
 * The purpose of this library is to allow the export of processing sketches to PovRAY
 * Copyright (C) 2011 Martin Prout
 * This library is free software; you can redistribute it and/or modify it under the terms
 * of the GNU Lesser General Public License as published by the Free Software Foundation; 
 * either version 2.1 of the License, or (at your option) any later version.
 * 
 * Obtain a copy of the license at http://www.gnu.org/licenses/lgpl-2.1.html
 */
package povexport;

import processing.core.PApplet;
import static processing.core.PConstants.*;

/**
 * Provide an alternative sphere for use in processing that works much better
 * than the original when exported to PovRAY, probably not required for processing-2.0
 * @author Martin Prout <martin_p@lineone.net>
 * @deprecated processing-2.0 sphere OK? better just export as sphere primitive
 */
@Deprecated
public class Sphere {

    private PApplet parent;
    final float GR = (1.0f + (float) Math.sqrt(5.0f)) / 2.0f;
    final float HT = 1 / (float) Math.sqrt(1.0f + GR * GR);
//    final int X = 0;
//    final int Y = 1;
//    final int Z = 2;

    /**
     * Constructor for class takes applet input to provide access
     * to methods of parent class
     * @param applet
     * @deprecated 
     */
    @Deprecated
    public Sphere(PApplet applet) {
        this.parent = applet;
    }

    /**
     * depth 80, 320, 1280, 5120..... triangles
     * @param depth
     * @param r
     */
    public void draw(int depth, float r) {
        // Calculate the vertex data for an icosahedron inscribed by a draw radius 'r'.
        // Use 4 Golden Ratio rectangles as the basis.
        final float h = r * HT;

        float[][] v = {
            {0, -h, h * GR}, {0, -h, -h * GR}, {0, h, -h * GR}, {0f, h, h * GR},
            {h, -h * GR, 0}, {h, h * GR, 0}, {-h, h * GR, 0}, {-h, -h * GR, 0},
            {-h * GR, 0, h}, {-h * GR, 0, -h}, {h * GR, 0, -h}, {h * GR, 0, h}
        };

        parent.beginShape(PApplet.TRIANGLES);

        drawTriangle(depth, r, v[0], v[7], v[4]);
        drawTriangle(depth, r, v[0], v[4], v[11]);
        drawTriangle(depth, r, v[0], v[11], v[3]);
        drawTriangle(depth, r, v[0], v[3], v[8]);
        drawTriangle(depth, r, v[0], v[8], v[7]);

        drawTriangle(depth, r, v[1], v[4], v[7]);
        drawTriangle(depth, r, v[1], v[10], v[4]);
        drawTriangle(depth, r, v[10], v[11], v[4]);
        drawTriangle(depth, r, v[11], v[5], v[10]);
        drawTriangle(depth, r, v[5], v[3], v[11]);
        drawTriangle(depth, r, v[3], v[6], v[5]);
        drawTriangle(depth, r, v[6], v[8], v[3]);
        drawTriangle(depth, r, v[8], v[9], v[6]);
        drawTriangle(depth, r, v[9], v[7], v[8]);
        drawTriangle(depth, r, v[7], v[1], v[9]);

        drawTriangle(depth, r, v[2], v[1], v[9]);
        drawTriangle(depth, r, v[2], v[10], v[1]);
        drawTriangle(depth, r, v[2], v[5], v[10]);
        drawTriangle(depth, r, v[2], v[6], v[5]);
        drawTriangle(depth, r, v[2], v[9], v[6]);

        parent.endShape();
    }

    /**
     * Calculate inner triangles (recursively) or draw triangle immediately
     * @param depth (or detail int not of recursions)
     * @param r sphere radius float
     * @param p1 point 1 as float array
     * @param p2 point 2 as float array
     * @param p3 point 3 as float array
     */
    public void drawTriangle(int depth, float r, float[] p1, float[] p2, float[] p3) {
        if (depth == 1) {
            float[] normals = normal(p1);
            parent.normal(normals[X], normals[Y], normals[Z]);
            parent.vertex(p1[X], p1[Y], p1[Z]);
            normals = normal(p2);
            parent.normal(normals[X], normals[Y], normals[Z]);
            parent.vertex((float) p2[X], (float) p2[Y], (float) p2[Z]);
            normals = normal(p3);
            parent.normal(normals[X], normals[Y], normals[Z]);
            parent.vertex((float) p3[X], (float) p3[Y], (float) p3[Z]);
        } else {
            // Calculate the mid points of this triangle.
            float[] v1 = {(p1[X] + p2[X]) / 2.0f, (p1[Y] + p2[Y]) / 2.0f, (p1[Z] + p2[Z]) / 2.0f};
            float[] v2 = {(p3[X] + p2[X]) / 2.0f, (p3[Y] + p2[Y]) / 2.0f, (p3[Z] + p2[Z]) / 2.0f};
            float[] v3 = {(p1[X] + p3[X]) / 2.0f, (p1[Y] + p3[Y]) / 2.0f, (p1[Z] + p3[Z]) / 2.0f};

            // Project the verticies out onto the draw with radius r.
            v1 = normalToSphere(v1, r);
            v2 = normalToSphere(v2, r);
            v3 = normalToSphere(v3, r);

            // Generate the next level of detail.
            depth--;

            drawTriangle(depth, r, p1, v1, v3);
            drawTriangle(depth, r, v1, p2, v2);
            drawTriangle(depth, r, v2, p3, v3);
            drawTriangle(depth, r, v1, v2, v3);
        }
    }

    /**
     * Utility to calculate coordinates of icosahedron face, projected onto the sphere
     * @param vect array of XYZ points of an icosahedron face
     * @param radius radius of sphere onto which to project points
     * @return array of points that have been projected onto the sphere
     */
    public float[] normalToSphere(float[] vect, float radius) {
        float[] normal = normal(vect);
        float[] toSphere = {normal[X] * radius, normal[Y] * radius, normal[Z] * radius};
        return toSphere;
    }

    /**
     * Used for calculating normals
     * @param vect 
     * @return
     */
    public float[] normal(float[] vect) {
        float mag = (float) Math.sqrt((vect[X] * vect[X]) + (vect[Y] * vect[Y]) + (vect[Z] * vect[Z]));
        float[] normal = {vect[X] / mag, vect[Y] / mag, vect[Z] / mag};
        return normal;
    }
}

