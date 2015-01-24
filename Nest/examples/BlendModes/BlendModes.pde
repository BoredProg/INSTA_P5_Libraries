/*
 * BlendModes
 * 
 * Nest allows Processing's blend modes to follow the display list.
 * When a NestSprite has its blendMode set, all of its descendants
 * will inherit the same blendMode, unless they have a blendMode specified.
 * 
 * The following examples show this blendMode inheritance in action.
 * 
 * The first row of squares are BlendMuteSprites; the first three have
 * a blendMode set, the last has no blendMode set (setting blendMode to
 * NestSprite.NO_BLEND_MODE tells Nest there is no blendMode explicitly set).
 * When clicked, blendMode is turned off (set to NO_BLEND_MODE),
 * and the NestSprite takes on the blendMode of its parent.
 * 
 * The first row of squares are BlendSetSprites, with a different
 * blendMode applied to the first and last (in setupSetSprites).
 * When clicked, a BlendSetSprite explicitly sets its blendMode to
 * Processing's default blendMode (blendMode = PApplet.BLEND).
 * For BlendSetSprite with a blendMode set, descendants are unaffected;
 * for those without a blendMode set, the new blendMode falls through
 * to the last descendant without a blendMode set.
 */

import com.transmote.nest.*;
import com.transmote.nest.events.*;

NestSpriteContainer spriteContainer;
PImage backgroundImage;

void setup () {
  size(600, 300);
  
  // robin's nest background image from:
  // http://en.wikipedia.org/wiki/File:American_Robin_nest_and_eggs.JPG
  backgroundImage = loadImage("robinsNest.jpg");
  
  setupSprites();
}

void draw () {
  image(backgroundImage, 0, 0);
  spriteContainer.updateDisplayList();
}

void setupSprites () {
  // create a NestSpriteContainer to hold all other NestSprites.
  spriteContainer = new NestSpriteContainer(this);
  
  setupMuteSprites();
  setupSetSprites();
}

/**
 * A BlendMuteSprite turns off its own blendMode when clicked.
 * Setting a NestSprite's blendMode to NestSprite.NO_BLEND_MODE
 * will render it using Processing's default blend mode,
 * while child NestSprites will still render with whatever
 * blendMode they have set.
 */
void setupMuteSprites () {
  BlendMuteSprite s1_0 = new BlendMuteSprite(BLEND);
  s1_0.x = 75;
  s1_0.y = 75;
  BlendMuteSprite s1_1 = new BlendMuteSprite(SUBTRACT);
  s1_1.x = 150;
  s1_1.y = 0;
  BlendMuteSprite s1_2 = new BlendMuteSprite(ADD);
  s1_2.x = 150;
  s1_2.y = 0;
  BlendMuteSprite s1_3 = new BlendMuteSprite(NestSprite.NO_BLEND_MODE);
  s1_3.x = 150;
  s1_3.y = 0;
  // no initBlendMode set for this one,
  // so it will use the blendMode set on its parent
  
  spriteContainer.addChild(s1_0);
  s1_0.addChild(s1_1);
  s1_1.addChild(s1_2);
  s1_2.addChild(s1_3);
}

/**
 * A BlendSetSprite sets its blendMode to Processing's
 * default blendMode (BLEND) when clicked.
 * Setting a NestSprite's blendMode causes all child NestSprites
 * to use that same blendMode, unless they have specified
 * their own blendMode (as with s0_3 below).
 */
void setupSetSprites() {
  // set a blendMode on the NestSprite that contains
  // all the other NestSprites; descendant NestSprites
  // will use this blendMode.
  BlendSetSprite s0_0 = new BlendSetSprite();
  s0_0.x = 75;
  s0_0.y = 225;
  s0_0.blendMode = MULTIPLY;
  BlendSetSprite s0_1 = new BlendSetSprite();
  s0_1.x = 150;
  s0_1.y = 0;
  BlendSetSprite s0_2 = new BlendSetSprite();
  s0_2.x = 150;
  s0_2.y = 0;
  BlendSetSprite s0_3 = new BlendSetSprite();
  s0_3.blendMode = DIFFERENCE;
  s0_3.x = 150;
  s0_3.y = 0;
  
  spriteContainer.addChild(s0_0);
  s0_0.addChild(s0_1);
  s0_1.addChild(s0_2);
  s0_2.addChild(s0_3);
}
