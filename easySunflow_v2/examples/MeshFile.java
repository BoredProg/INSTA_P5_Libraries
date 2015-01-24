import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.nio.ByteOrder;
import java.nio.FloatBuffer;
import java.nio.IntBuffer;
import java.nio.MappedByteBuffer;
import java.nio.channels.FileChannel;
import java.nio.channels.FileChannel.MapMode;
import org.sunflow.SunflowAPI;
import org.sunflow.core.ParameterList;
import org.sunflow.core.ParameterList.InterpolationType;
import org.sunflow.core.PrimitiveList;
import org.sunflow.core.Tesselatable;
import org.sunflow.core.primitive.TriangleMesh;
import org.sunflow.math.BoundingBox;
import org.sunflow.math.Matrix4;
import org.sunflow.math.Point3;
import org.sunflow.math.Vector3;
import org.sunflow.system.Memory;
import org.sunflow.system.UI;
import org.sunflow.system.UI.Module;
import org.sunflow.util.FloatArray;
import org.sunflow.util.IntArray;
import org.sunflow.core.tesselatable.FileMesh;

public class MeshFile  extends FileMesh
{
  private String filename = null;
  private boolean smoothNormals = false;

  public int[] 	 triangles =null;
  public float[] vertices=null;
  public float[] normals=null;


  public MeshFile() {
  }

  public boolean update(ParameterList pl, SunflowAPI api) {
    String file = pl.getString("filename", null);
    if (file != null)
      this.filename = api.resolveIncludeFilename(file);
    this.smoothNormals = pl.getBoolean("smooth_normals", this.smoothNormals);
    return this.filename != null;
  }

  public PrimitiveList tesselate() {
    if (this.filename.endsWith(".ra3")) {
      try {
        UI.printInfo(UI.Module.GEOM, "RA3 - Reading geometry: \"%s\" ...", new Object[] { 
          this.filename
        }
        );
        File file = new File(this.filename);
        FileInputStream stream = new FileInputStream(this.filename);
        MappedByteBuffer map = stream.getChannel().map(FileChannel.MapMode.READ_ONLY, 0L, file.length());
        map.order(ByteOrder.LITTLE_ENDIAN);
        IntBuffer ints = map.asIntBuffer();
        FloatBuffer buffer = map.asFloatBuffer();
        int numVerts = ints.get(0);
        int numTris = ints.get(1);
        UI.printInfo(UI.Module.GEOM, "RA3 -   * Reading %d vertices ...", new Object[] { 
          Integer.valueOf(numVerts)
        }
        );
        float[] verts = new float[3 * numVerts];
        for (int i = 0; i < verts.length; i++)
          verts[i] = buffer.get(2 + i);
        UI.printInfo(UI.Module.GEOM, "RA3 -   * Reading %d triangles ...", new Object[] { 
          Integer.valueOf(numTris)
        }
        );
        int[] tris = new int[3 * numTris];
        for (int i = 0; i < tris.length; i++)
          tris[i] = ints.get(2 + verts.length + i);
        stream.close();
        UI.printInfo(UI.Module.GEOM, "RA3 -   * Creating mesh ...", new Object[0]);
        return generate(tris, verts, this.smoothNormals);
      } 
      catch (FileNotFoundException e) {
        e.printStackTrace();
        UI.printError(UI.Module.GEOM, "Unable to read mesh file \"%s\" - file not found", new Object[] { 
          this.filename
        }
        );
      } 
      catch (IOException e) {
        e.printStackTrace();
        UI.printError(UI.Module.GEOM, "Unable to read mesh file \"%s\" - I/O error occured", new Object[] { 
          this.filename
        }
        );
      }
    } 
    else if (this.filename.endsWith(".obj")) {
      int lineNumber = 1;
      try {
        UI.printInfo(UI.Module.GEOM, "OBJ - Reading geometry: \"%s\" ...", new Object[] { 
          this.filename
        }
        );
        FloatArray verts = new FloatArray();
        IntArray tris = new IntArray();
        FileReader file = new FileReader(this.filename);
        BufferedReader bf = new BufferedReader(file);
        String line;
        while ( (line = bf.readLine ()) != null)
        {

          if (line.startsWith("v")) {
            String[] v = line.split("\\s+");
            verts.add(Float.parseFloat(v[1]));
            verts.add(Float.parseFloat(v[2]));
            verts.add(Float.parseFloat(v[3]));
          } 
          else if (line.startsWith("f")) {
            String[] f = line.split("\\s+");
            if (f.length == 5) {
              tris.add(Integer.parseInt(f[1]) - 1);
              tris.add(Integer.parseInt(f[2]) - 1);
              tris.add(Integer.parseInt(f[3]) - 1);
              tris.add(Integer.parseInt(f[1]) - 1);
              tris.add(Integer.parseInt(f[3]) - 1);
              tris.add(Integer.parseInt(f[4]) - 1);
            } 
            else if (f.length == 4) {
              tris.add(Integer.parseInt(f[1]) - 1);
              tris.add(Integer.parseInt(f[2]) - 1);
              tris.add(Integer.parseInt(f[3]) - 1);
            }
          }
          if (lineNumber % 100000 == 0)
          UI.printInfo(UI.Module.GEOM, "OBJ -   * Parsed %7d lines ...", new Object[] { 
            Integer.valueOf(lineNumber)
          }
          );
          lineNumber++;
        }
        file.close();
        UI.printInfo(UI.Module.GEOM, "OBJ -   * Creating mesh ...", new Object[0]);

        return generate(tris.trim(), verts.trim(), this.smoothNormals);
      } 
      catch (FileNotFoundException e) {
        e.printStackTrace();
        UI.printError(UI.Module.GEOM, "Unable to read mesh file \"%s\" - file not found", new Object[] { 
          this.filename
        }
        );
      } 
      catch (NumberFormatException e) {
        e.printStackTrace();
        UI.printError(UI.Module.GEOM, "Unable to read mesh file \"%s\" - syntax error at line %d", new Object[] { 
          Integer.valueOf(lineNumber)
        }
        );
      } 
      catch (IOException e) {
        e.printStackTrace();
        UI.printError(UI.Module.GEOM, "Unable to read mesh file \"%s\" - I/O error occured", new Object[] { 
          this.filename
        }
        );
      }
    } 
    else if (this.filename.endsWith(".stl")) {
      try {
        UI.printInfo(UI.Module.GEOM, "STL - Reading geometry: \"%s\" ...", new Object[] { 
          this.filename
        }
        );
        FileInputStream file = new FileInputStream(this.filename);
        DataInputStream stream = new DataInputStream(new BufferedInputStream(file));
        file.skip(80L);
        int numTris = getLittleEndianInt(stream.readInt());
        UI.printInfo(UI.Module.GEOM, "STL -   * Reading %d triangles ...", new Object[] { 
          Integer.valueOf(numTris)
        }
        );
        long filesize = new File(this.filename).length();
        if (filesize != 84 + 50 * numTris) {
          UI.printWarning(UI.Module.GEOM, "STL - Size of file mismatch (expecting %s, found %s)", new Object[] { 
            Memory.bytesToString(84 + 14 * numTris), Memory.bytesToString(filesize)            
          }
          );
          return null;
        }
        int[] tris = new int[3 * numTris];
        float[] verts = new float[9 * numTris];
        int i = 0; 
        int i3 = 0; 
        for (int index = 0; i < numTris; i3 += 3)
        {
          stream.readInt();
          stream.readInt();
          stream.readInt();
          for (int j = 0; j < 3; index += 3) {
            tris[(i3 + j)] = (i3 + j);

            verts[(index + 0)] = getLittleEndianFloat(stream.readInt());
            verts[(index + 1)] = getLittleEndianFloat(stream.readInt());
            verts[(index + 2)] = getLittleEndianFloat(stream.readInt());

            j++;
          }

          stream.readShort();
          if ((i + 1) % 100000 == 0)
          UI.printInfo(UI.Module.GEOM, "STL -   * Parsed %7d triangles ...", new Object[] { 
            Integer.valueOf(i + 1)
          }
          );
          i++;
        }

        file.close();

        UI.printInfo(UI.Module.GEOM, "STL -   * Creating mesh ...", new Object[0]);
        if (this.smoothNormals)
          UI.printWarning(UI.Module.GEOM, "STL - format does not support shared vertices - normal smoothing disabled", new Object[0]);
        return generate(tris, verts, false);
      } 
      catch (FileNotFoundException e) {
        e.printStackTrace();
        UI.printError(UI.Module.GEOM, "Unable to read mesh file \"%s\" - file not found", new Object[] { 
          this.filename
        }
        );
      } 
      catch (IOException e) {
        e.printStackTrace();
        UI.printError(UI.Module.GEOM, "Unable to read mesh file \"%s\" - I/O error occured", new Object[] { 
          this.filename
        }
        );
      }
    } 
    else {
      UI.printWarning(UI.Module.GEOM, "Unable to read mesh file \"%s\" - unrecognized format", new Object[] { 
        this.filename
      }
      );
    }
    return null;
  }




  private TriangleMesh generate(int[] tris, float[] verts, boolean smoothNormals) {
    ParameterList pl = new ParameterList();
    pl.addIntegerArray("triangles", tris);
    pl.addPoints("points", ParameterList.InterpolationType.VERTEX, verts);


	//flipYAxis(verts);
	
    triangles=tris;
    vertices= verts;
    normals=null;

    smoothNormals=true;



    if (smoothNormals) {
      normals = new float[verts.length];
      Point3 p0 = new Point3();
      Point3 p1 = new Point3();
      Point3 p2 = new Point3();
      Vector3 n = new Vector3();
      for (int i3 = 0; i3 < tris.length; i3 += 3) {
        int v0 = tris[(i3 + 0)];
        int v1 = tris[(i3 + 1)];
        int v2 = tris[(i3 + 2)];
        p0.set(verts[(3 * v0 + 0)], verts[(3 * v0 + 1)], verts[(3 * v0 + 2)]);
        p1.set(verts[(3 * v1 + 0)], verts[(3 * v1 + 1)], verts[(3 * v1 + 2)]);
        p2.set(verts[(3 * v2 + 0)], verts[(3 * v2 + 1)], verts[(3 * v2 + 2)]);
        Point3.normal(p0, p1, p2, n);

        normals[(3 * v0 + 0)] += n.x;
        normals[(3 * v0 + 1)] += n.y;
        normals[(3 * v0 + 2)] += n.z;
        normals[(3 * v1 + 0)] += n.x;
        normals[(3 * v1 + 1)] += n.y;
        normals[(3 * v1 + 2)] += n.z;
        normals[(3 * v2 + 0)] += n.x;
        normals[(3 * v2 + 1)] += n.y;
        normals[(3 * v2 + 2)] += n.z;
      }

      for (int i3 = 0; i3 < normals.length; i3 += 3) {
        n.set(normals[(i3 + 0)], normals[(i3 + 1)], normals[(i3 + 2)]);
        n.normalize();
        normals[(i3 + 0)] = n.x;
        normals[(i3 + 1)] = n.y;
        normals[(i3 + 2)] = n.z;
      }
      pl.addVectors("normals", ParameterList.InterpolationType.VERTEX, normals);
    }



    TriangleMesh m = new TriangleMesh();
    if (m.update(pl, null)) {
      return m;
    }

    return null;
  }


  public float[]  getVertices() {
    return vertices;
  }
  public int[]  getTriangles() {
    return triangles;
  }
  

  private int getLittleEndianInt(int i) {
    return i >>> 24 | i >>> 8 & 0xFF00 | i << 8 & 0xFF0000 | i << 24;
  }
  private float getLittleEndianFloat(int i) {
    return Float.intBitsToFloat(getLittleEndianInt(i));
  }
}

