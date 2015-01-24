/*
 * Code based on oracle FileChooser Demo.
 */
package povexport;

import java.awt.Color;
import java.io.File;
import javax.swing.Icon;
import javax.swing.filechooser.FileView;

/**
 * 
 * @author Martin Prout
 */
public class TemplateFileView extends FileView {

    /**
     * 
     */
    public Icon povrayIcon = new DiamondIcon(Color.RED);

//    @Override
//    public String getName(File f) {
//        return null;
//    }
//
//    @Override
//    public String getDescription(File f) {
//        return null;
//    }
//
//    @Override
//    public Boolean isTraversable(File f) {
//        return null;
//    }

    @Override
    public String getTypeDescription(File f) {
        String name = f.getName();
        String type = null;
        if (name != null) {
            if (name.endsWith(".pov") || name.endsWith(".POV")) {
                type = "POV Template";
            }
        }
        return type;
    }

    @Override
    public Icon getIcon(File f) {
        Icon icon = null;
        String name = f.getName();
        if (name != null) {
            if (name.endsWith(".pov") || name.endsWith(".POV")) {
                icon = povrayIcon;
            }
        }
        return icon;
    }
}
