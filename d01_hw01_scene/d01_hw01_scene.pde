// Plasma based on http://www.openprocessing.org/sketch/10148

PImage waves;
PImage shore;
int[] palette = new int[128];
int[] colors;

void setup() {
  size(1600,900);
  
  waves = createImage(1600, 900, ARGB);
  shore = createImage(1600, 300);
  noStroke();
  
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
  colors = new int[width * height];
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      colors[x+y*width] = (int)((127.5 + +(127.5 * sin(x / 32.0)))+ (127.5 + +(127.5 * cos(y / 32.0))) + (127.5 + +(127.5 * sin(sqrt((x * x + y * y)) / 32.0)))  ) / 4;
    }
  }
  
  
}

void draw() {
  background(0);
  
  waves.loadPixels();
  for (int pixelCount = 0; pixelCount < colors.length; pixelCount++) {                   
    waves.pixels[pixelCount] = palette[(colors[pixelCount] + frameCount) &127];
  }

  waves.updatePixels();
  
  image(waves, 0, 0);  
}
