// Creature

// A class to describe a thing in our world, has vectors for position, velocity, and acceleration
// Also includes scalar values for mass, maximum velocity, and elasticity

class Creature {
  float maxSpeed = 2;
  float targetProximity = 200;
  float massMin = 8;
  float massMax = 16;

  PVector pos;
  PVector vel;
  PVector acc;
  float mass;

  Attractor target;
  CreatureTail tail;

  Creature(Attractor _target) {
    target = _target;
    acc = new PVector();
    vel = new PVector(random(-1, 1), random(-1, 1));
    pos = new PVector(random(width), random(height));
    mass = random(massMin, massMax);
    tail = new CreatureTail(3);
  }

  void go() {
    applyAttraction();
    boundaries();
    update();
    display();
  }

  void applyForce(PVector force) {
    PVector f = force.get();  
    f.div(mass);
    acc.add(f);
  }

  // Method to update position
  void update() {
    vel.add(acc);
    if (vel.mag() > maxSpeed) {
      vel.normalize();
      vel.mult(maxSpeed);
    }
    pos.add(vel);
    // Pass acceleration to tail
    tail.applyForce(acc);
    // Multiplying by 0 sets the all the components to 0
    acc.mult(0);
  }

  // Method to add forces from attraction
  void applyAttraction() {
    // Select new target if close enought to current target
    if (doHittest()) {
      target = getRandomAttractor();
    }

    // Get attraction force
    PVector f = target.attract(this);
    // Apply that force to the Creature
    applyForce(f);
  }

  // Is Creature close to target?
  boolean doHittest() {
    return PVector.dist(pos, target.pos) < targetProximity;
  }

  // Method to display
  void display() {
    float angle = vel.heading2D();

    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle);
    scale(mass/massMax*2);

    drawHead();
    translate(-6, 0);
    tail.go();
    popMatrix();
  }

  // Draw creature head
  void drawHead() {
    ellipseMode(CENTER);
    stroke(0);
    fill(175, 100);
    pushMatrix();
    rotate(radians(90));
    //triangle(0, -20, -16, 12, 16, 12);
    triangle(0, -massMax*1.25, -massMax, massMax*0.75, massMax, massMax*0.75);
    popMatrix();

    //Debugging Vizualisations
    if (debugging) {
      noStroke();
      fill(175, 40);
      ellipse(0, 0, targetProximity, targetProximity);
    }
  }

  // Method to turn around if offscreen
  void boundaries() {

    float d = 50;

    PVector force = new PVector(0, 0);

    if (pos.x < d) {
      force.x = 1;
    } else if (pos.x > width -d) {
      force.x = -1;
    } 

    if (pos.y < d) {
      force.y = 1;
    } else if (pos.y > height-d) {
      force.y = -1;
    } 

    force.normalize();
    force.mult(0.1);

    applyForce(force);
  }
}
