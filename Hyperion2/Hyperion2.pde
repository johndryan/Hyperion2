// Hyperion 2.0
// Built on code and ideas from Daniel Shiffman's http://natureofcode.com
Boolean debugging = false;

Creature[] Creatures = new Creature[6];
Attractor[] attractors;

void setup() {
  size(1024,768);
  setupAttractors();
  setupCreatures();
}

void draw() {
  background(255);
  for (int i = 0; i < attractors.length; i++) {
    attractors[i].rollover(mouseX,mouseY);
    attractors[i].go();
  }
  
  for (int i = 0; i < Creatures.length; i++) {
    Creatures[i].go();
  }
}

// MOUSE INTERACTIONS ------------------------------------ //

void mousePressed() {
  for (int i = 0; i < attractors.length; i++) {
    attractors[i].clicked(mouseX,mouseY);
  }
}

void mouseReleased() {
  for (int i = 0; i < attractors.length; i++) {
    attractors[i].stopDragging();
  }
}

// SETUP FUNCTIONS ------------------------------------ //
// TODO: put these inside Manager/Factory Objects?

void setupCreatures() {
  for (int i = 0; i < Creatures.length; i++) {
    Creatures[i] = new Creature(getRandomAttractor());
  }
}
  
void setupAttractors() {
  PVector[] attractorPositions = {
    new PVector(width/2,height/2),
    new PVector(width/5,height/5),
    new PVector(width/5*4,height/5),
    new PVector(width/5,height/5*4),
    new PVector(width/5*4,height/5*4)
  };
  attractors = new Attractor[attractorPositions.length];
  
  for (int i = 0; i < attractorPositions.length; i++) {
    attractors[i] = new Attractor(attractorPositions[i],20,0.4);
  }
}

Attractor getRandomAttractor() {
  return attractors[int(random(attractors.length-1))];
}
