package povexport.povwriter;

import java.util.EnumSet;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

/**
 *
 * The purpose of this library is to allow the export of processing sketches to
 * PovRAY Copyright (C) 2013 Martin Prout This library is free software; you can
 * redistribute it and/or modify it under the terms of the GNU Lesser General
 * Public License as published by the Free Software Foundation; either version
 * 2.1 of the License, or (at your option) any later version.
 *
 * Obtain a copy of the license at http://www.gnu.org/licenses/lgpl-2.1.html
 */
public class TextureFactory {

    private EnumSet<Finish> finishSet;
    private Set<Texture> textureSet;
    private Map<Integer, String> textureMap;
    static TextureFactory factory = new TextureFactory();

    private TextureFactory() {
        this.textureSet = new HashSet<Texture>();
        this.textureMap = new TreeMap<Integer, String>();
        this.finishSet = EnumSet.of(Finish.MIRROR);
    }

    private static class FactoryHolder {

        private static final TextureFactory INSTANCE = new TextureFactory();
    }

    /**
     *
     * @return
     */
    public static TextureFactory getFactory() { // to declare getFactory makes no sense
        return TextureFactory.FactoryHolder.INSTANCE;
    }

    /**
     * Texture0 has been used in line texture
     *
     * @param texture
     * @return
     */
    public StringBuilder addTexture(Texture texture) {
        StringBuilder builder = new StringBuilder(100);
        PovrayColorFactory cf = PovrayColorFactory.getFactory();
        Finish finish = texture.getFinish();
        finishSet.add(finish);
        if (this.textureSet.add(texture)) {
            String name = String.format("Texture%d", this.textureSet.size());
            cf.addColor(texture.getColor()); //safety 1st if color is new
            builder.append(name);
            textureMap.put(texture.hashCode(), name);
        } else {
            builder.append(textureMap.get(texture.hashCode()));
        }
        return builder;
    }

    /**
     * Used by declareTextures
     *
     * @param text
     * @return
     */
    private StringBuilder buildTexture(Texture text) {
        StringBuilder build = new StringBuilder(150);
        if (text.getFinish() == Finish.RED_MARBLE) {
            build.append(Finish.RED_MARBLE.finish());
        }
        else if (text.getFinish() == Finish.MIRROR) {
            build.append(Finish.MIRROR.finish());
        } else {
            PovrayColorFactory cf = PovrayColorFactory.getFactory();
            StringBuilder colour;
            colour = cf.addColor(text.getColor());
            String fin = text.getFinish().finish();
            build.append("texture{ pigment{");
            build.append(colour);
            build.append("} ");
            build.append(fin);
            build.append("} ");
        }
        return build;
    }

    /**
     *
     * @return
     */
    public StringBuilder includeFinishes() {
        StringBuilder include = new StringBuilder(1000);
        for (Finish finish : finishSet) {
            switch (finish) {
                case RED_MARBLE:
                    include.append("#include \"stones1.inc\"\n");
                    break;
                case METAL:
                case CHROME:
                case STEEL:
                    include.append("#include \"metals.inc\"\n");
                    break;
                case GLASS:
                    include.append("#include \"glass.inc\"\n");
                    break;
                default:
                    break;
            }

        }
        return include;
    }

    /**
     *
     * @return
     */
    public StringBuilder declareTextures() {
        StringBuilder declare = new StringBuilder(1000);
        for (Texture texture : this.textureSet) {
            String name = textureMap.get(texture.hashCode());
            declare.append("#declare ");
            declare.append(name);
            declare.append(" = ");
            declare.append(buildTexture(texture));
            declare.append("\n");
        }
        return declare;
    }
}
