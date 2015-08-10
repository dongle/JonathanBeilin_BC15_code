class StarManager {

  ArrayList<Star> stars;
  
  StarManager() {
    stars = new ArrayList<Star>();
  }
  
  void addStar() {
    Star star = new Star();
    stars.add(star);
  }
  
  void updateStars() {
    for (int i = 0; i < stars.size() - 1; i++) {
      Star star = stars.get(i);
      
      star.update();
      if (star.yPos > height) {
        stars.remove(i);
      }
    }
  }
  
  void drawStars() {
      for (int i = 0; i < stars.size() - 1; i++) {
        Star star = stars.get(i);
        star.draw();
    }
  }
}
