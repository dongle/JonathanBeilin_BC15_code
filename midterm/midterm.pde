// informed by the Textures examples

PImage waves;

int[] palette = new int[128];
int[] colors;

StarManager starManager = new StarManager();

void setup() {
  size(1280, 720, P3D);
  noStroke();

  setupWaves();
}

void draw() {
  background(0);

  drawStars();

  updateWaves();
  drawGroundPlane();
  
  drawMoon();
}

void setupWaves() {
  waves = createImage(300, 300, RGB);
  // store colors in an array to define a palette cycle through
  // to draw the plasma
  // colors must have smooth transitions; palette must wrap
  float s1, s2;
  for (int i = 0; i < 128; i++) {
    s1 = sin(i*PI/25);
    s2 = sin(i*PI/50+PI/4);
    palette[i] = color(128 + s1 * 128, 128 + s1 * 128, 255);
  }

  // precalculate pixel values to cycle through to animate the plasma
  colors = new int[waves.width * waves.height];
  for (int x = 0; x < waves.width; x++) {
    for (int y = 0; y < waves.height; y++) {
      colors[x+y*waves.width] = (int)((127.5 + +(127.5 * sin(x / 32.0)))+ (127.5 + +(127.5 * cos(y / 32.0))) + (127.5 + +(127.5 * sin(sqrt((x * x + y * y)) / 32.0)))  ) / 4;
    }
  }
}

void drawMoon() {

}

void drawStars() {
  starManager.updateStars();
  starManager.drawStars();
}

void updateWaves() {
  waves.loadPixels();
  for (int pixelCount = 0; pixelCount < colors.length; pixelCount++) {                   
    waves.pixels[pixelCount] = palette[(colors[pixelCount] + frameCount) &127];
  }
  waves.updatePixels();
}

void drawGroundPlane() {
  pushMatrix();
  translate(width / 2, height/3 + height / 2);
  rotateX(PI/4);
  beginShape();
  texture(waves);
  vertex(-width/2, -100, 0, 0, 0);
  vertex(width/2, -100, 0, waves.width, 0);
  vertex(width/2, 100, 0, waves.width, waves.height);
  vertex(-width/2, 100, 0, 0, waves.height);
  endShape();
  popMatrix();
}

void calculatePixelDifference() {

}

