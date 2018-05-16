// Hyperion 2.0
// Built on code and ideas from Daniel Shiffman's http://natureofcode.com
Boolean debugging = true;

Crawler[] crawlers = new Crawler[6];
Attractor[] attractors = new Attractor[5];

void setup() {
  size(1024,768);
  setupAttractors();
  setupCrawlers();
}

void draw() {
  background(255);
  //a.rollover(mouseX,mouseY);
  for (int i = 0; i < attractors.length; i++) {
    attractors[i].go();
  }
  
  for (int i = 0; i < crawlers.length; i++) {
    crawlers[i].go();
  }
}

//void mousePressed() {
//  a.clicked(mouseX,mouseY);
//}

//void mouseReleased() {
//  a.stopDragging();
//}

void setupCrawlers() {
  for (int i = 0; i < crawlers.length; i++) {
    crawlers[i] = new Crawler(getRandomAttractor());
  }
}
  
void setupAttractors() {
  attractors[0] = new Attractor(new PVector(width/2,height/2),20,0.4);
  attractors[1] = new Attractor(new PVector(width/5,height/5),20,0.4);
  attractors[2] = new Attractor(new PVector(width/5*4,height/5),20,0.4);
  attractors[3] = new Attractor(new PVector(width/5,height/5*4),20,0.4);
  attractors[4] = new Attractor(new PVector(width/5*4,height/5*4),20,0.4);
}

Attractor getRandomAttractor() {
  return attractors[int(random(attractors.length-1))];
}
