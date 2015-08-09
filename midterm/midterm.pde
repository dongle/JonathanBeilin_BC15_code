// Plane informed by the Textures examples

// TODO:
// - draw stars
// - add star for sounds
// - manage stars
// - add sound fx for each star when it drops & when hits water
// - shake moon
// - diffpixels amplitude waves


import processing.video.*;
Capture video;
int numPixels;
int[] previousFrame;
int threshold = 50; // forgiveness in difference between pixels between frames

PImage waves;

int[] palette = new int[128];
int[] colors;

StarManager starManager = new StarManager();

void setup() {
  size(1280, 720, P3D);
  noStroke();

  video = new Capture(this, width, height);
  video.start();
  numPixels = video.width * video.height;
  previousFrame = new int[width * height];
  arraycopy(video.pixels, previousFrame);

  setupWaves();
}

void draw() {
  lights();
  background(0);

  int diffPixels = calculateVideoDifference();
//  println("changed pixels: " + diffPixels);
  arraycopy(video.pixels, previousFrame);

  drawStars(diffPixels);

  updateWaves(diffPixels);
  drawGroundPlane();

  drawMoon(diffPixels);
}

void setupWaves() {
  waves = createImage(300, 300, RGB);
  // store colors in an array to define a palette cycle through
  // to draw the plasma
  // colors must have smooth transitions; palette must wrap
  float s1, s2;
  for (int i = 0; i < 128; i++) {
    s1 = sin(i*PI/25)*.3;
    s2 = sin(i*PI/50+PI/4)*.3;
    palette[i] = color(128 + s1 * 128, 128 + s1 * 128, 255);
  }

  // precalculate pixel values to cycle through to animate the plasma
  colors = new int[waves.width * waves.height];
  for (int x = 0; x < waves.width; x++) {
    for (int y = 0; y < waves.height; y++) {
      colors[x+y*waves.width] = (int)((127.5 + (127.5 * sin(x / 32.0))) + (127.5 + (127.5 * cos(y / 32.0))) + (127.5 +(127.5 * sin(sqrt((x * x + y * y)) / 32.0)))  ) / 6;
    }
  }
}

void drawMoon(int diffPixels) {
  pushMatrix();
  translate(width/2, -width/2 + 100);
  fill(204);
  //  sphereDetail(6);
  sphere(width/2);
  popMatrix();
}

void drawStars(int diffPixels) {
  starManager.updateStars();
  starManager.drawStars();
}

void updateWaves(int diffPixels) {
  waves.loadPixels();
  float waveSpeed = map(diffPixels, 0, width*height, .3, 9); 
  for (int pixelCount = 0; pixelCount < colors.length; pixelCount++) {  
    if (pixelCount >= 0 && pixelCount <= 10) {
//      int colorspixelcount = colors[pixelCount];
      int palIndex = (colors[pixelCount] + frameCount) &127;
      println("palIndex: " + palIndex);

      int palIndex2 = (colors[pixelCount] + frameCount) % 128;
      println("palIndex2: " + palIndex2);
    }
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

// practically speaking, range is about 1k-100k pixels
// from handwaving etc
int calculateVideoDifference() {
  int changedPixels = 0;
  if (video.available()) {
    video.read(); // Read a new video frame
    video.loadPixels(); // Make the pixels of video available

    for (int i = 0; i < numPixels; i++) {
      int videoColor = video.pixels[i];
      int videoR          = (videoColor >> 16) & 0xFF;
      int videoG          = (videoColor >> 8) & 0xFF;
      int videoB          = videoColor & 0xFF;

      int bgColor = previousFrame[i];
      int bgR          = (bgColor >> 16) & 0xFF;
      int bgG          = (bgColor >> 8) & 0xFF;
      int bgB          = bgColor & 0xFF;

      boolean changed = (abs(videoR - bgR) > threshold) && (abs(videoG - bgG) > threshold) && (abs(videoB - bgB) > threshold);
      if (changed) {
        changedPixels++;
      }
    }
  }

  return changedPixels;
}

