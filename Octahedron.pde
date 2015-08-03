public class Octahedron {
  OctaSquare[] squares;
  float xLat;
  float yLat;
  float zLat;
  float xRot;
  float yRot;
  float zRot;
  int order;
  
  public Octahedron(boolean hasLeds1, boolean hasLeds2, boolean hasLeds3, float xLat, float yLat, float zLat, float xRot, float yRot, float zRot, int order) {
    squares = new OctaSquare[3];
    squares[0] = new OctaSquare(hasLeds1);
    squares[1] = new OctaSquare(hasLeds2);
    squares[2] = new OctaSquare(hasLeds3);
    
    this.xLat = xLat;
    this.yLat = yLat;
    this.zLat = zLat;
    
    this.xRot = xRot;
    this.yRot = yRot;
    this.zRot = zRot;
    
    this.order = order;
  }
  
  void draw() {
    pushMatrix();
    translate(xLat,yLat,zLat);
    if (order == 0) {
      rotateX(xRot);
      rotateY(yRot);
      rotateZ(zRot);
    }
    else if (order == 1) {
      rotateY(yRot);
      rotateZ(zRot);
      rotateX(xRot);
    }
    else {
      rotateZ(zRot);
      rotateX(xRot);
      rotateY(yRot);
    }
    
    pushMatrix();
    squares[0].draw();
    rotateX(PI/4);
    popMatrix();
  
    pushMatrix();
    rotateX(PI/4);
    rotateZ(PI/2);
    rotateX(PI/4);  
    squares[1].draw();
    popMatrix();
  
    pushMatrix();
    rotateX(PI/4);
    rotateZ(PI/2);
    rotateY(PI/2);
    rotateX(PI/4);
    squares[2].draw();
    popMatrix();
    
    popMatrix();
  }
  
  public int appendJSON(JSONArray top, int id) {
    id = squares[0].appendJSON(top, id);
    id = squares[1].appendJSON(top, id);
    id = squares[2].appendJSON(top, id);
    return id;
  }
}

