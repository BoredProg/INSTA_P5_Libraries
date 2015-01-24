package povexport;

import java.io.File;
import javax.swing.filechooser.FileFilter;

/**
 * A filter for use with JFileChooser, selects PovRAY files/templates
 * @author Martin Prout
 */
public class PovFilter extends FileFilter {

    /**
     * Accepts directory by default and files that end with ".pov"
     * @param f File
     * @return true when accepted
     */
    
    @Override
    public boolean accept(File f) {
        if (f.isDirectory()) {
            return true;
        }
        if (f.getName().endsWith(".pov")) {
            return true;
        } else {
            return false;
        }
    }

   /**
     * 
     * @return file description
     */
    @Override
    public String getDescription() {
        return "Povray File";
    }
}
