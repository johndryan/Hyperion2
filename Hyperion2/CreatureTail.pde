// Oscillator

class CreatureTail {
  
  Pendulum[] parts;
  float partRadius = 30;
  
  // Because we are going to oscillate along the x and y axis we can use PVector for two angles, amplitudes, etc.!
  float theta;
  float amplitude;

  CreatureTail(int numParts) {
    parts = new Pendulum[numParts];
    for(int i=0; i < numParts; i++){
      // Make radius a little shorter every time
      float thisPartRadius = partRadius*(numParts-i/2)/numParts;
      parts[i] = new Pendulum(new PVector(0,0),thisPartRadius);
    }
  }

  void go() {
    update();
    display();
  }

  // Update Tail Parts
  void update() {
    for(int i=0; i < parts.length; i++){
      parts[i].update();
    }
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
