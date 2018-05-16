// Oscillator

class CreatureTail {
  
  Pendulum[] parts;
  float partRadius = 30;
  float partDamping = 0.99;
  float aAcceleration;
  
  CreatureTail(int numParts) {
    parts = new Pendulum[numParts];
    for(int i=0; i < numParts; i++){
      // Make radius a little shorter every time
      float thisPartRadius = partRadius*(numParts-i/2)/numParts;
      parts[i] = new Pendulum(new PVector(0,0),thisPartRadius);
    }
    aAcceleration = 0.0;
  }

  void go() {
    update();
    display();
  }

  // Update Tail Parts
  void update() {
    for(int i=0; i < parts.length; i++){
      parts[i].applyAngularAcceleration(aAcceleration);
      println("PART "+i+":aAcceleration =   " + aAcceleration);
      parts[i].update();
      aAcceleration *= partDamping;
    }
    aAcceleration = 0.0;
  }

  void applyForce(PVector force) {
    PVector f = force.copy();
    Float angularAcceleration = f.heading();
    aAcceleration += angularAcceleration * 0.002;
    println("TAIL:  aAcceleration =   " + aAcceleration);
  }

  // Display based on a position
  void display() {
    pushMatrix();
    rotate(radians(90));
    for(int i=0; i < parts.length; i++){
      parts[i].display();
      translate(parts[i].position.x,parts[i].position.y);
      rotate(parts[i].angle);
      scale(0.8);
    }
    popMatrix();
  }
}
