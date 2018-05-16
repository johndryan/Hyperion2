// TODO: Handle some of this with Interfaces and Implementation?

// BASIC OBJECT ------------------------------------ //
class BasicObject {
  PVector position;
  float mass;
  
  BasicObject(float x, float y) {
    position = new PVector(x,y);
    mass = 0;
  }
  
  void update() {
    
  }
  
  void display() {
    point(position.x,position.y);
  }
}

// MOVER OBJECT ------------------------------------ //
class Mover extends BasicObject {
  PVector velocity;
  PVector acceleration;
  float maxSpeed;
  
  float damping = 0.95;
  
  Mover(float x, float y, float _m) {
    super(x,y);
    mass = _m;
    maxSpeed = 2;
    acceleration = new PVector();
    // Starts with random velocity
    velocity = new PVector(random(-1, 1), random(-1, 1));
  }
  
  // position-less constructor
  Mover(float _m) {
    this(random(width),random(height),_m);
  }
  // Empty constructor
  Mover() {
    this(random(width),random(height),1);
  }
  // Mass-less constructor
  Mover(float x, float y) {
    this(x,y,1);
  }

  void go() {
    update();
    display();
  }
  
  void update() {
    super.update();
    velocity.add(acceleration);
    if (velocity.mag() > maxSpeed) {
      velocity.normalize();
      velocity.mult(maxSpeed);
    }
    // TODO: Add damping back once I give the creatures a 'kick' to push them
    //velocity.mult(damping);
    position.add(velocity);
    acceleration.mult(0);
  }

  // Newton's law: F = M * A
  void applyForce(PVector force) {
    PVector f = force.copy();
    f.div(mass);
    acceleration.add(f);
  }
  
  // Getters & Setters
  void setMaxSpeed(float _maxSpeed) {
    maxSpeed = _maxSpeed;
  }
  void setMass(float _mass) {
    mass = _mass;
  }
}

// MOVER WITH BOUNDARIES ------------------------------- //

class MoverWithBoundaries extends Mover {
  MoverWithBoundaries() {
    super();
  }
  
  // TODO: Add other constructors
  void go() {
    boundaries();
    super.go();
  }
  
  // Method to turn around if offscreen
  void boundaries() {

    float d = 50;

    PVector force = new PVector(0, 0);

    if (position.x < d) {
      force.x = 1;
    } else if (position.x > width -d) {
      force.x = -1;
    } 

    if (position.y < d) {
      force.y = 1;
    } else if (position.y > height-d) {
      force.y = -1;
    } 

    force.normalize();
    force.mult(0.1);

    applyForce(force);
  }
}

// MOVER WITH BOUNDARIES ------------------------------- //

class MoverWithBoundariesAndAttraction extends MoverWithBoundaries {
  Attractor target;
  
  float targetProximity = 200;
  
  MoverWithBoundariesAndAttraction(Attractor _target) {
    super();
    target = _target;
  }
  
  // TODO: Add other constructors
  void go() {
    applyAttraction();
    super.go();
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
    return PVector.dist(position, target.position) < targetProximity;
  }
}

// DRAGGABLE OBJECT ------------------------------------ //

class Draggable extends Mover {
  boolean dragging = false; // Is the object being dragged?
  boolean rollover = false; // Is the mouse over the ellipse?
  PVector dragOffset;  // holds the offset for when object is clicked on
  
  Draggable(float x, float y, float _m) {
    super(x,y,_m); //<>//
    dragOffset = new PVector(0.0,0.0);
  }
  
  void clicked(int mx, int my) {
    // Needs some refinement - drag area currently determined by mass
    float d = dist(mx,my,position.x,position.y);
    if (d < mass) {
      dragging = true;
      dragOffset.x = position.x-mx;
      dragOffset.y = position.y-my;
    }
  }

  void rollover(int mx, int my) {
    float d = dist(mx,my,position.x,position.y);
    if (d < mass) {
      rollover = true;
    } else {
      rollover = false;
    }
  }

  void stopDragging() {
    dragging = false;
  }

  void drag(int mx, int my) {
    if (dragging) {
      position.x = mx + dragOffset.x;
      position.y = my + dragOffset.y;
    }
  }

  // Getters & Setters
  boolean isDragging() {
    return dragging;
  }
  boolean isRollover() {
    return rollover;
  }
  
  // TODO: Needs a method to handle display when dragged?
  // TODO: Needs a method to return draggable state?
}
