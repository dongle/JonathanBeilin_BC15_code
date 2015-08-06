// FontAwesome uses extended unicode chars for its icons
// the codes are defined here: https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css
// starts at f000 (61440) and ends at f280 (62080)
// those are within Unicode's Private Use Areas (UTF-32)

PFont fAwesome;

void setup() {
  size(1080, 1080, P2D); // official instagram size
  fAwesome = createFont("fontawesome-webfont.ttf", 96);
  textFont(fAwesome);
  textAlign(CENTER, CENTER);

  background(0);
  colorMode(HSB, 360, 100, 100);
}

void draw() {
  float hue = random(0, 360);
  float saturation = random(0,100);
  float brightness = random(0,100);
  float alpha = 32;
  fill(hue, saturation, brightness, alpha); 
  
  blendMode(SCREEN);
  
  int charCode = int(random(61440, 62080));
  // Java does not support UTF-32 natively so we need to do
  // a hacky workaround by generating a utf-16 pair to define
  // the character. The below line is munged together from StackOverflow
  // and the official Java docs
  String extChar = new String(new int[] { charCode } , 0, 1);
  
  int xPos = int(random(0, width));
  int yPos = int(random(0, height));
  text(extChar, xPos, yPos);
}

void mouseClicked() {
  saveFrame();
}
