import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

public static final boolean WRITE_JSON = false;
public static final boolean ENABLE_OCTACAD = false;
public static final float EDGE_DEPTH = 243.840;
public static final float EDGE_HEIGHT = 5.080;
public static final float EDGE_WIDTH = 10.160;

PeasyCam cam;
ArrayList<Octahedron> octas;
Octahedron octa;
JSONArray top;
int xRot;
int yRot;
int zRot;

int xLat;
int yLat;
int zLat;

int order;

void setup() {
  size(800,600,P3D);
  frameRate(30);
  cam = new PeasyCam(this, 1000);
  cam.setMinimumDistance(10);
  cam.setMaximumDistance(2000);
  cam.pan(0,-300);
  
  if (ENABLE_OCTACAD)
    cam.setSuppressRollRotationMode();
  else
    cam.setYawRotationMode();   // like spinning a globe

  octas = new ArrayList<Octahedron>();
  octas.add(new Octahedron(true,true,false,0,-104,0,0.0,0.0,0.638136,0));
  octas.add(new Octahedron(true,true,true,0,-309,0,0.0,1.0308352,0.638136,0));
  octas.add(new Octahedron(false,true,true,0,-516,0,0.0,0.0,0.5890486,0));
  octas.add(new Octahedron(false,true,true,-192,-383,0,0.0,0.0,1.3253595,0));
  octas.add(new Octahedron(true,true,false,-101,-242,173,0.98174775,0.24543694,0.19634955,1));  
  octas.add(new Octahedron(true,true,false,97,-372,170,1.0308352,1.276272,2.9452431,1));
  octas.add(new Octahedron(false,true,true,197,-238,4,1.4726216,0.09817477,1.3253595,1));
  octas.add(new Octahedron(false,true,true,-97,-237,-168,0.14726216,1.9144081,1.3253595,1));
  octas.add(new Octahedron(true,true,false,96,-372,-172,0.5890486,1.8653207,0.19634955,1));
  
  if (ENABLE_OCTACAD)
    octa = new Octahedron(false,false,false,0,0,0,0,0,0,0);
  
  top = new JSONArray();
}

void drawPlane() {
  float corner = 10000;
  pushStyle();
  fill(64);  
  beginShape();
  vertex(corner, 0, corner);
  vertex(corner, 0, -corner);
  vertex(-corner, 0, -corner);
  vertex(-corner, 0, corner);
  endShape(CLOSE);
  popStyle();
}


void keyPressed() {
  if (ENABLE_OCTACAD) {
    if (key == 'x') xRot = min(64,xRot+1);
    else if (key == 'X') xRot = max(0,xRot-1);
    
    else if (key == 'y') yRot = min(64,yRot+1);
    else if (key == 'Y') yRot = max(0,yRot-1);
    
    else if (key == 'z') zRot = min(64,zRot+1);
    else if (key == 'Z') zRot = max(0,zRot-1);
    
    else if (key == 'R') {
      xRot = 0;
      yRot = 0;
      zRot = 0;
      order = 0;
    }
    
    else if (keyCode == UP) zLat -= EDGE_DEPTH / 64;
    else if (keyCode == DOWN) zLat += EDGE_DEPTH / 64;
    
    else if (keyCode == LEFT) xLat -= EDGE_DEPTH / 64;
    else if (keyCode == RIGHT) xLat += EDGE_DEPTH / 64;
    
    else if (key == 'q') yLat -= EDGE_DEPTH / 64;
    else if (key == 'a') yLat += EDGE_DEPTH / 64;
  
    else if (key == 'Q') yLat -= EDGE_DEPTH / 16;
    else if (key == 'A') yLat += EDGE_DEPTH / 16;
    
    else if (key == '1') octa.squares[0].hasLeds = !octa.squares[0].hasLeds;
    else if (key == '2') octa.squares[1].hasLeds = !octa.squares[1].hasLeds;
    else if (key == '3') octa.squares[2].hasLeds = !octa.squares[2].hasLeds;
    
    else if (key == 'o') {
      order++;
      if (order > 2) order = 0;
    }
    
    else if (key == 'p') {
      println("octas.add(new Octahedron(" + 
        octa.squares[0].hasLeds + "," +
        octa.squares[1].hasLeds + "," +
        octa.squares[2].hasLeds + "," +
        xLat + "," +
        yLat + "," +
        zLat + "," +
        PI/64*xRot + "," +
        PI/64*yRot + "," +
        PI/64*zRot + "," + 
        order + "));");
    }
  }
}

void draw() {
  background(0);
  drawPlane();

  for (Octahedron o : octas) {
    o.draw();
  }
  
  if (ENABLE_OCTACAD) {
    pushMatrix();
  
    translate(xLat,yLat,zLat);
    
    if (order == 0) {
      rotateX(PI/64*xRot);
      rotateY(PI/64*yRot);
      rotateZ(PI/64*zRot);
    }
    else if (order == 1) {
      rotateY(PI/64*yRot);
      rotateZ(PI/64*zRot);
      rotateX(PI/64*xRot);
    }
    else {
      rotateZ(PI/64*zRot);
      rotateX(PI/64*xRot);
      rotateY(PI/64*yRot);
    }
    
    octa.draw();
    popMatrix();
  }

  if (WRITE_JSON && frameCount == 1) {
    int id = 0;
    for (Octahedron octa : octas) {
      id = octa.appendJSON(top, id);
    }
    saveJSONArray(top, "data/asterix.json");
  }
}

