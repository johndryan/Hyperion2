// Attraction

// A class for a draggable attractive body in our world

class Attractor extends Draggable {
  float G;       // Gravitational Constant

  Attractor(PVector _position, float _m, float _g) {
    super(_position.x,_position.y,_m);
    G = _g;
  }

  void go() {
    render(); //<>//
    drag(mouseX,mouseY);
  }

  PVector attract(MoverWithBoundariesAndAttraction c) {
    PVector dir = PVector.sub(position,c.position);        // Calculate direction of force
    float d = dir.mag();                              // Distance between objects
    d = constrain(d,5.0,25.0);                        // Limiting the distance to eliminate "extreme" results for very close or very far objects
    dir.normalize();                                  // Normalize vector (distance doesn't matter here, we just want this vector for direction)
    float force = (G * mass * c.mass) / (d * d); // Calculate gravitional force magnitude
    dir.mult(force);                                  // Get force vector --> magnitude * direction
    return dir;
  }

  // Method to display
  void render() {
    ellipseMode(CENTER);
    stroke(0,100);
    if (isDragging()) fill (50);
    else if (isRollover()) fill(100);
    else fill(175,50);
    ellipse(position.x,position.y,mass*2,mass*2); //<>//
  }
}
