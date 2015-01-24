import saito.objloader.*;

OBJModel model ;

float rotX, rotY;

void setup()
{
    size(1280, 720, P3D);
    //frameRate(30);
    model = new OBJModel(this, "globe.obj", "absolute", QUADS);
    model.enableDebug();

    model.scale(5);
    model.translateToCenter();
    strokeWeight(0.5f);
    stroke(255,120);
    //noStroke();
}



void draw()
{
    background(129);
    lights();
    //tint(12,15,235,120);
    pushMatrix();
    translate(width/2, height/2, 0);
    rotateZ(frameCount / 1000f);
    rotateX(rotY);
    rotateY(rotX);

    model.draw();

    popMatrix();
}

boolean bTexture = true;
boolean bStroke = false;

void keyPressed()
{
    if(key == 't') {
        if(!bTexture) {
            model.enableTexture();
            bTexture = true;
        } 
        else {
            model.disableTexture();
            bTexture = false;
        }
    }

    if(key == 's') {
        if(!bStroke) {
            stroke(255);
            bStroke = true;
        } 
        else {
            noStroke();
            bStroke = false;
        }
    }

    else if(key=='1')
        model.shapeMode(POINTS);
    else if(key=='2')
        model.shapeMode(LINES);
    else if(key=='3')
        model.shapeMode(TRIANGLES);
}

void mouseDragged()
{
    rotX += (mouseX - pmouseX) * 0.01;
    rotY -= (mouseY - pmouseY) * 0.01;
}

