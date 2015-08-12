float acceleration = .003;

class Star {
  float xPos;
  float yPos;
  float zPos;

  float rotX;
  float rotY;
  float rotZ;

  float size;
  float speed;


  Star() {
    size = random(17) + 3;
    yPos = -size;
    xPos = random(150, width-150);
    zPos = random(width/2.0) - width/4.0;

    rotX = radians(random(360));
    rotY = radians(random(360));
    rotZ = radians(random(360));

    speed = random(1) + acceleration;
  }

  void update() {
    speed += acceleration;
    yPos += speed;
  }

  void draw() {
    pushMatrix();
    
    translate(xPos, yPos, zPos);
    
    rotateX(rotX);
    rotateY(rotY);
    rotateZ(rotZ);
    
    fill(204);
    box(20);
    popMatrix();
  }
}

