public class OctaSquare {
  float[] vertexes;
  boolean hasLeds;
  
  public OctaSquare(boolean hasLeds) {
    vertexes = new float[12];
    this.hasLeds = hasLeds;
  }
  
  public void draw() {
      int i=0;
      
      if (hasLeds) fill(255,0,0);
      else fill(255);
      
      pushMatrix();
      translate(0,EDGE_DEPTH/2,0);
      box(EDGE_WIDTH,EDGE_HEIGHT,EDGE_DEPTH);
      vertexes[i] = modelX(0,0,-EDGE_DEPTH/2); i++;
      vertexes[i] = modelY(0,0,-EDGE_DEPTH/2); i++;
      vertexes[i] = modelZ(0,0,-EDGE_DEPTH/2); i++;
      popMatrix();

      pushMatrix();
      rotateX(PI/2);
      translate(0,EDGE_DEPTH/2,0);
      box(EDGE_WIDTH,EDGE_HEIGHT,EDGE_DEPTH);
      vertexes[i] = modelX(0,0,-EDGE_DEPTH/2); i++;
      vertexes[i] = modelY(0,0,-EDGE_DEPTH/2); i++;
      vertexes[i] = modelZ(0,0,-EDGE_DEPTH/2); i++;
      popMatrix();
      
      pushMatrix();
      translate(0,-EDGE_DEPTH/2,0);
      box(EDGE_WIDTH,EDGE_HEIGHT,EDGE_DEPTH);
      vertexes[i] = modelX(0,0,EDGE_DEPTH/2); i++;
      vertexes[i] = modelY(0,0,EDGE_DEPTH/2); i++;
      vertexes[i] = modelZ(0,0,EDGE_DEPTH/2); i++;
      popMatrix();

      pushMatrix();
      rotateX(PI/2);
      translate(0,-EDGE_DEPTH/2,0);
      box(EDGE_WIDTH,EDGE_HEIGHT,EDGE_DEPTH);
      vertexes[i] = modelX(0,0,EDGE_DEPTH/2); i++;
      vertexes[i] = modelY(0,0,EDGE_DEPTH/2); i++;
      vertexes[i] = modelZ(0,0,EDGE_DEPTH/2); i++;
      popMatrix();
  }
 
  public int appendJSON(JSONArray top, int id) {
    if (!hasLeds) 
      return id;
    
    JSONArray verts;
    JSONObject edge;
    
    for (int i=0; i<4; i++) {
      edge = new JSONObject();
      edge.setInt("id", id);
      edge.setInt("density", 30);
      edge.setInt("numberOfLights", 80);
      verts = new JSONArray();
      verts.setFloat(0,vertexes[i*3]);
      verts.setFloat(1,vertexes[i*3+1]);
      verts.setFloat(2,vertexes[i*3+2]);
      edge.setJSONArray("startPoint", verts);
      verts = new JSONArray();
      if (i<3) {
        verts.setFloat(0,vertexes[(i+1)*3]);
        verts.setFloat(1,vertexes[(i+1)*3+1]);
        verts.setFloat(2,vertexes[(i+1)*3+2]);
      }
      else {
        verts.setFloat(0,vertexes[0]);
        verts.setFloat(1,vertexes[1]);
        verts.setFloat(2,vertexes[2]);
      }
      edge.setJSONArray("endPoint", verts);
      
      top.append(edge);
      id++;
    }

    return id;
  }  
  
}

