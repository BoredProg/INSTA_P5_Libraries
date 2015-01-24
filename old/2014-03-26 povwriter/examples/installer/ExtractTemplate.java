import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

/**
 *
 * @author sid
 */
public class ExtractTemplate implements Runnable {

  private File zipFilePath;
  private boolean overwrite;


  /**
   *
   * @param zipFilePath
   * @param overwrite
   */
  public ExtractTemplate(File zipFilePath, boolean overwrite) {
    this.zipFilePath = zipFilePath;
    this.overwrite = overwrite;
  }



  @Override
    public void run() {
    try {
      extractZipFile(zipFilePath, overwrite);
    } 
    catch (IOException ex) {
      Logger.getLogger(ExtractTemplate.class.getName()).log(Level.SEVERE, null, ex);
    }
  }

  /**
   *
   * @param zipFilePath
   * @param overwrite
   * @throws IOException  
   */
  public void extractZipFile(File zipFilePath, boolean overwrite) throws IOException {
    InputStream inputStream = new FileInputStream(zipFilePath);
    ZipInputStream zipInputStream = new ZipInputStream(inputStream);
    final byte[] data = new byte[1024];
    try {
      ZipEntry zipEntry = null;
      while ( (zipEntry = zipInputStream.getNextEntry ()) != null) {
        final String destination = System.getProperty("user.home") + "/" + zipEntry.getName();
        if (overwrite == false) {
          if (new File(destination).exists()) {
            continue;
          }
        } 
        else {
          final File file = new File(destination);
          if (!(file.getParentFile().exists())) {
            if (file.getParentFile().mkdir()) {
              System.out.println("Created Directory " + file.getParent());
            }
          }
          int size = zipInputStream.read(data);
          FileOutputStream outputStream = null;
          try {
            if (size > 0) {
              outputStream = new FileOutputStream(destination);
              do {
                outputStream.write(data, 0, size);
                size = zipInputStream.read(data);
              } 
              while (size >= 0);
            }
          } 
          finally {
            outputStream.flush();
            outputStream.close();
          }
        }
      }
    } 
    finally {
      zipInputStream.close();
      inputStream.close();
    }
  }
}


