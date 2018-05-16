class CreatureHead {
  float size;
  
  CreatureHead(float _size) {
    size = _size;
  }
  
  CreatureHead() {
    size = 32;
  }
  
  void display() {
    ellipseMode(CENTER);
    stroke(0);
    fill(175, 100);
    pushMatrix();
    rotate(radians(90));
    //triangle(0, -20, -16, 12, 16, 12);
    triangle(0, -size*1.25, -size, size*0.75, size, size*0.75);
    popMatrix();
  }
}
