int maxImages = 8;
PImage[] bunny = new PImage[maxImages];
int imageIndex = 0;
int displacement = 0;

// Processing's pre-processor doesn't support enums! Bummer!
// But you can use JAVA in Processing by making a new tab and
// making the file a .java file to use it in your processing files.

// The Enum data type is great for tracking state because it
// enumerates (hey!) potential values and a variable of enum
// type can only hold one of those at a time*. This results in more
// explicit states than remembering to flip & check a bunch of bools

// * composite states can be handled with bit-shifting but
//   let's save that for a later example.

BunnyAction action;

void setup() {
  size(1200, 600);
  frameRate(8);

  action = BunnyAction.STANDING;
  for (int i=0; i<maxImages; i++) {
    bunny[i] = loadImage("bunnySprite" + i + ".png");
  }
}

void draw() {
  background(255);
  imageMode(CENTER);

  translate(width/2 + displacement, height/2);
  imageIndex = (imageIndex + 1) % maxImages;

  switch(action) {
  case STANDING:
    image(bunny[0], 0, 0);
    break;
  case MOVERIGHT:
    image(bunny[imageIndex], 0, 0);  
    displacement += 20;
    break;
  case MOVELEFT:
    scale(-1, 1);
    image(bunny[imageIndex], 0, 0);  
    displacement -= 20;
    break;
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == RIGHT) {
      action = BunnyAction.MOVERIGHT;
    } else if (keyCode == LEFT) {
      action = BunnyAction.MOVELEFT;
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    action = BunnyAction.STANDING;
  }
}

