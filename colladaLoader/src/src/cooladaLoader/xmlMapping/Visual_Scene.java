package cooladaLoader.xmlMapping;
import java.util.HashMap;
import java.util.HashSet;

import cooladaLoader.ColladaLoaderException;
import processing.data.XML;
/**
 * <p>Lucerne University of Applied Sciences and Arts <a href="http://www.hslu.ch">http://www.hslu.ch</a></p>
 *
 * <p>This source is free; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License and by nameing of the originally author</p>
 * 
 *<p> this class maps the Visual_Scene-tag and binds meterials to the geometries</p>
 * 
 * @author Markus Zimmermann <a href="http://www.die-seite.ch">http://www.die-seite.ch</a>
 * @version 1.2
 */
class Visual_Scene {

    private String ID;


    Visual_Scene(XML aScene, Library_Materials lib_materials, Library_Geometries lib_geometries)
    {
        ID = aScene.getString("id");
        if (ID==null)throw new ColladaLoaderException("visual_scene not parsed (id)");

        XML[] _nodes = aScene.getChildren("node");
        if (_nodes.length==0)throw new ColladaLoaderException("visual_scene not parsed (node subtag)");
        
        for (XML node : _nodes) {
        	XML[] _instance_geometries = node.getChildren("instance_geometry");
        	if (_instance_geometries.length==0)	throw new ColladaLoaderException("visual_scene not parsed (instance_geometry subtags)");
        	
            for (XML instance_geometry : _instance_geometries) {

                String geometryID = instance_geometry.getString("url").substring(1);
                HashMap<String,String> materialBinds = new HashMap<String, String>(); //Format: <Symbol,MatID>

                //scan all Materialbinds that belongs to the geometry
                XML[] _instance_materials = instance_geometry.getChild("bind_material/technique_common").getChildren("instance_material");
                if (_instance_geometries.length==0) throw new ColladaLoaderException("visual_scene not parsed (instance_material subtags)");
                
                for (XML instance_material : _instance_materials)
                {
                    String materialSymbol = instance_material.getString("symbol");
                    String materialID = instance_material.getString("target").substring(1);
                    if (materialSymbol==null) throw new ColladaLoaderException("visual_scene not parsed (instance_material symbol attribute)");
                    materialBinds.put(materialSymbol, materialID);
                }
                //get the geometry-obj and start the material-binds to its triangles and lines
                Geometry geometry = lib_geometries.getGeometryByID(geometryID);
                geometry.bindMaterials(lib_materials, materialBinds);
                //System.out.println(geometry); //useful on debugging
            }
        }
    }
    /**
     * 
     * @return the ID of this scene
     */
    String getID()
    {
        return ID;
    }
}
