// Creature

// A class to describe a thing in our world, has vectors for position, velocity, and acceleration
// Also includes scalar values for mass, maximum velocity, and elasticity

class Creature extends MoverWithBoundariesAndAttraction {
  float massMin = 8;
  float massMax = 16;
  
  CreatureTail tail;
  CreatureHead head;

  Creature(Attractor _target) {
    super(_target);
    super.setMass(random(massMin, massMax));
    tail = new CreatureTail(3);
    head = new CreatureHead(massMax);
  }

  void update() {
    // Pass acceleration to tail
    tail.applyForce(acceleration);
    super.update();
  }

  // Method to display
  void display() {
    //Transformations
    pushMatrix();
    translate(position.x, position.y);
    float angle = velocity.heading();
    rotate(angle);
    scale(mass/massMax);

    //Draw body parts
    head.display();
    translate(-6, 0);
    tail.go();
    
    //Debugging Vizualisations
    if (debugging) {
      noStroke();
      fill(175, 40);
      ellipse(0, 0, targetProximity, targetProximity);
    }
    popMatrix();
  }
}
