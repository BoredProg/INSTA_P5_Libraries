package cooladaLoader.xmlMapping;
import cooladaLoader.ColladaLoaderException;
import processing.data.XML;
/**
 * <p>Lucerne University of Applied Sciences and Arts <a href="http://www.hslu.ch">http://www.hslu.ch</a></p>
 *
 * <p>This source is free; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License and by nameing of the originally author</p>
 * 
 *<p> this class is a helper-class to map the source-tag inside the Geometry-tag </p>
 * 
 * @author Markus Zimmermann <a href="http://www.die-seite.ch">http://www.die-seite.ch</a>
 * @version 1.2
 */
class Source extends SubTag{

        private float[][] pointmatrix; // format: [index][x,y,z or x,y]
        private String ID;

        Source(XML source)
        {	
        	if (source==null) throw new ColladaLoaderException("source tag not parsed");
        	
            ID = source.getString("id");
            if (ID==null) throw new ColladaLoaderException("source tag not parsed (id)");
            
            XML accessor = source.getChild("technique_common/accessor");
                       
            String[] float_array = source.getChild("float_array").getContent().split(" ");
            int accessor_count = accessor.getInt("count");
            int accessor_stride = accessor.getInt("stride");

            if (accessor_count==0||accessor_stride==0||float_array.length==0)
            	throw new ColladaLoaderException("source tag not parsed (float_array or accessor subtag)");
            
            pointmatrix = new float[accessor_count][accessor_stride];

            for (int i = 0, k = 0; i<accessor_count; i++)
            {
                for (int j = 0; j < accessor_stride; j++, k++)
                pointmatrix[i][j] = Float.parseFloat(float_array[k]);
            }


        }

        /**
         *
         * @return returns position-Points in the format format: [index][x,y,z or x,y]
         */
        float[][] getPointMatrix()
        {
            return pointmatrix;
        }

        /**
         * @return the ID
         */
        String getID() {
            return ID;
        }

        String getNextSource()
        {
            return ID;
        }
    }
