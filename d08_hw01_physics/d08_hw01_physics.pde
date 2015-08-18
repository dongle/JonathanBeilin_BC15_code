PVector attractor;
ArrayList<PVector> particles;
color pColor;

float gravity = 0.005;

void setup() {
  size(600, 600);

  attractor = new PVector(width/2, height/2);
  particles = new ArrayList<PVector>();

  for (int i = 0; i < 15; i++) {
    PVector particle = new PVector(random(width), random(height));
    particles.add(particle);
  }
}

void draw() {
  background(0);

  fill(255, 0, 255);
  for (int i = 0; i < particles.size(); i++) {
    PVector particle = particles.get(i);
    float deltaX = attractor.x - particle.x;
    float deltaY = attractor.y - particle.y;
    particle.x += deltaX * gravity;
    particle.y += deltaY * gravity;
    ellipse(particle.x, particle.y, 10, 10);
  }

  fill(255);
  ellipse(attractor.x, attractor.y, 50, 50);
}

void mousePressed() {
  saveFrame("physics.jpg");
}