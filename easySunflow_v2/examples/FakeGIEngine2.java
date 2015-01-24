import org.sunflow.core.GIEngine;
import org.sunflow.core.Options;
import org.sunflow.core.Scene;
import org.sunflow.core.ShadingState;
import org.sunflow.image.Color;
import org.sunflow.math.Vector3;

/**
 * This is a quick way to get a bit of ambient lighting into your scene with
 * hardly any overhead. It's based on the formula found here:
 * 
 * @link http://www.cs.utah.edu/~shirley/papers/rtrt/node7.html#SECTION00031100000000000000
 */
public class FakeGIEngine2 implements GIEngine {
    private Vector3 up;
    private Color sky;
    private Color ground;

    public Color getIrradiance(ShadingState state, Color diffuseReflectance) {
        float cosTheta = Vector3.dot(up, state.getNormal());
        float a = 0.5f + 0.5f*cosTheta;
        return Color.blend(ground, sky, a);
    }
   

    public Color getGlobalRadiance(ShadingState state) {
        return Color.BLACK;
    }

    public boolean init(Options options, Scene scene) {
        up = options.getVector("gi.fake2.up", new Vector3(0, 1, 0)).normalize();
        sky = options.getColor("gi.fake2.sky", Color.WHITE).copy();
        ground = options.getColor("gi.fake2.ground", Color.BLACK).copy();
        sky.mul((float) Math.PI);
        ground.mul((float) Math.PI);
        return true;
    }
}