package cooladaLoader;
/**
 * <p>This Interface is designed only for development environment and 
 * wont affect any required classes. Compiling of this class is not
 * required
 * 
 * @author Markus Zimmermann <a href="http://www.die-seite.ch">http://www.die-seite.ch</a>
 * @version 1.0
 */
public interface MainScetch
{
	/**A callback as substitution of PApplet.draw()
	 * call "OpenGL11Adapter.repaint()" in PApplet.draw() method
	 * OpenGL11Adapter supports required methods of PApplet 
	 * for this purpose
	 */
	public abstract void draw(OpenGL11Adapter pApplet);
}