// Credit to memo atken for http://www.memo.tv/okgo-wtf-effect/
// which informed my work here on background differencing

// TO DO
// - save a frame every x frames for y frames
// - play back a frame sequence every x seconds

import processing.video.*;

Capture video;
int numPixels;
int []cleanPlate;        // stores clean plate pixel info
int threshold = 50;      // to eliminate noise, compare current against clean plate with this threshold

boolean savedBackground = false;

boolean isRecording = false;
boolean isGhosting = false;
int ghostFrames = 60;
int ghostFramesRecorded = 0;
int ghostFrameInterval = 2;
int ghostFrameCounter = 0;

int ghostTimer;
int recTimer;

int recordings = 0;
int ghostForPlayback = 0;
int ghostPlaybackCount = 0;

PImage ghost;

void setup() {
//  size(1280, 720, P2D);
  size(640, 360, P2D);
  frameRate(30);

/*
  String[] cameras = Capture.list();
  for (int i = 0; i < cameras.length; i++) {
      println(i + ": " + cameras[i]);
  }
  */ 
    
  video = new Capture(this, width, height);
  video.start();
  numPixels = video.width * video.height;

  loadPixels();
  
  cleanPlate = new int[width * height];
  background(0);
  
  setGhostTimer();
  setRecTimer();
  
  blendMode(ADD);
}

void draw() {
  if (video.available()) {
    video.read(); // Read a new video frame
    video.loadPixels(); // Make the pixels of video available
    
    if (savedBackground == false) {
      for (int i = 0; i < numPixels; i++) {
        pixels[i] = video.pixels[i];
      }
      updatePixels();
      return;
    }
    
    for (int i = 0; i < numPixels; i++) {
      int videoColor = video.pixels[i];
      int videoR          = (videoColor >> 16) & 0xFF;
      int videoG          = (videoColor >> 8) & 0xFF;
      int videoB          = videoColor & 0xFF;
      
      int bgColor = cleanPlate[i];
      int bgR          = (bgColor >> 16) & 0xFF;
      int bgG          = (bgColor >> 8) & 0xFF;
      int bgB          = bgColor & 0xFF;
      
      boolean isBackground = (abs(videoR - bgR) < threshold) && (abs(videoG - bgG) < threshold) && (abs(videoB - bgB) < threshold);
      if (isBackground == false) {
        pixels[i] = video.pixels[i];
      } else {
        pixels[i] = color(0);
      }
    }
    updatePixels();
  }
  
  
  // RECORDING
  recTimer--;
  if (!isGhosting && !isRecording && recTimer < 0) {
    isRecording = true;
    recordings++;
  }
  
  if (isRecording) {
    String frameName = "recording" + recordings + "frame-" + ghostFramesRecorded + ".tif";
    saveFrame(frameName);
    ghostFramesRecorded++;
    
    println("recorded frame: " + frameName);
  }
  
  if (isRecording && ghostFramesRecorded >= ghostFrames) {
    isRecording = false;
    setRecTimer();
    ghostFramesRecorded = 0;
  }
  
  // PLAYBACK
  ghostTimer--;
  if (!isGhosting && ghostTimer < 0 && recordings > 0) {
    isGhosting = true;
    ghostForPlayback = int(random(1, recordings));
  }
  
  if (isGhosting) {
    String frameName = "recording" + ghostForPlayback + "frame-" + ghostPlaybackCount + ".tif";
    ghost = loadImage(frameName);
    tint(255, 128);
    image(ghost, 0, 0);
    ghostPlaybackCount++;
  }
  
  if (isGhosting && ghostPlaybackCount >= ghostFrames) {
    isGhosting = false;
    ghostPlaybackCount = 0;
    setGhostTimer();
  }
  
}

void saveCleanPlate() {
  savedBackground = true;
  video.loadPixels();
  arraycopy(video.pixels, cleanPlate);
  println("saved background");
}

void setGhostTimer() {
  ghostTimer = int(random(0,900));
}

void setRecTimer() {
  recTimer = int(random(0,900));
}

void keyPressed() {
  switch(key) {
  case ' ': 
    saveCleanPlate();
    break;
  }
}
