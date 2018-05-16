// Crawler

// A class to describe a thing in our world, has vectors for position, velocity, and acceleration
// Also includes scalar values for mass, maximum velocity, and elasticity

class Crawler {
  float maxSpeed = 2;
  float targetProximity = 200;
  
  PVector pos;
  PVector vel;
  PVector acc;
  float mass;
  
  Attractor target;
  Wave tail;
  Oscillator osc;
    
  Crawler(Attractor _target) {
    target = _target; //<>//
    acc = new PVector();
    vel = new PVector(random(-1,1),random(-1,1));
    pos = new PVector(random(width),random(height));
    mass = random(8,16);
    osc = new Oscillator(mass*2);
    tail = new Wave(new PVector(0,0),100,20,100);
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
    if(vel.mag() > maxSpeed) {
      vel.normalize();
      vel.mult(maxSpeed);
    }
    pos.add(vel);
    // Multiplying by 0 sets the all the components to 0
    acc.mult(0);
    
    osc.update(vel.mag()/10);
    
    tail.calculate(vel.mag()/20);
  }
  
  // Method to add forces from attraction
  void applyAttraction() {
    // Select new target if close enought to current target
    if(doHittest()){
       target = getRandomAttractor();
    }
    
    // Get attraction force
    PVector f = target.attract(this); //<>//
    // Apply that force to the Crawler
    applyForce(f);
  }
  
  boolean doHittest() {
    return PVector.dist(pos,target.pos) < targetProximity;
  }
  
  // Method to display
  void display() {
    float angle = vel.heading2D();
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(angle);
    ellipseMode(CENTER);
    stroke(0);
    fill(175,100);
    ellipse(0,0,mass*2,mass*2);
    
    osc.display(pos);
    rotate(PI);
    tail.display();
    popMatrix();
    
  }
  
  // Method to turn around if offscreen
  void boundaries() {

    float d = 50;

    PVector force = new PVector(0, 0);

    if (pos.x < d) {
      force.x = 1;
    } 
    else if (pos.x > width -d) {
      force.x = -1;
    } 

    if (pos.y < d) {
      force.y = 1;
    } 
    else if (pos.y > height-d) {
      force.y = -1;
    } 

    force.normalize();
    force.mult(0.1);

    applyForce(force);
  }
}
