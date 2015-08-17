class Alien {
  float x, y;
  float speed;
  float alienSize = 48;
  
  Boolean shot = false;
  
  PImage alienIcon = loadImage("alien.png");

  Alien(float _x, float _y, float _speed) {
    x = _x;
    y = _y;
    speed = _speed;
  }

  void update() {
    y += speed;
  }

  void display() {
    image(alienIcon, x, y, alienSize, alienSize);
  }  
  
  void checkCollisionWithBullet(Bullet b, Alien alien, int alienIndex, int shotIndex) {
    if (dist(x, y, b.x, b.y) < alienSize/2 + 2) {
      if (shot) {
        aliens.remove(alienIndex);
        score++;
      }
        shots.remove(shotIndex);
        shot = true;
        alienSize *= 2;
    }
  }
  
  void checkCollisionWithPlayer(Player ship, Alien alien) {
    if (dist(x, y, ship.x, ship.y) < alienSize/2 + 5) {
      fill(255,255,255,180);
      ellipse(ship.x, ship.y, 180, 180);
      ship.alive= false;
    }
  }
  
  boolean rectRectIntersect(float left, float top, float right, float bottom,
                          float otherLeft, float otherTop, float otherRight, float otherBottom) {
  return !(left > otherRight || right < otherLeft || top > otherBottom || bottom < otherTop);
  }

}