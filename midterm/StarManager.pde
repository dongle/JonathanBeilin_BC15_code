class StarManager {

  ArrayList<Star> stars;
  
  StarManager() {
    stars = new ArrayList<Star>();
  }
  
  void addStar() {
  }
  
  void updateStars() {
    for (int i = 0; i < stars.size() - 1; i++) {
      Star star = stars.get(i);
      
      // check star on screen
      // if not on screen
      // stars.remove(i);
    }
  }
  
  void drawStars() {
      for (int i = 0; i < stars.size() - 1; i++) {
        Star star = stars.get(i);
        star.draw();
    }
  }
}
