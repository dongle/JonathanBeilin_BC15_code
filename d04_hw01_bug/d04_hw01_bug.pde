
int segments = 6;
int padding = 50;
float baseSize;

void setup() {
  size(600, 600);
  baseSize = (width - padding*2)/float(segments); 
}

void draw() {
  background(255);
  fill(0);
  noStroke();
  for (int i = 0; i < segments; i++) {
    float curSize = baseSize * (sin(.005*frameCount) + 2.2);
    ellipse(padding + baseSize * i, height/2, curSize, curSize);
    
    if (i == segments - 1) {
      stroke(255);
      strokeWeight(5);
      ellipse(padding + (baseSize * i) + .5*curSize - 40, height/2, 10, 10);
      ellipse(padding + (baseSize * i) + .5*curSize - 20, height/2, 10, 10);
    }
  }  
}
