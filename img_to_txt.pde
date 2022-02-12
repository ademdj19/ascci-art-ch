import processing.video.*;

int size = 12;
PFont font;
String chars = "$@B%8&WM#*oahkbdpqwmZO0QLCJUYXzcvunxrjft/\\|()1{}[]?-_+~<>i!lI;:,\"^`'.";
float textw;
Capture cam;

void setup() {
  fullScreen();
  font = createFont("Consolas.ttf", size);
  fill(255);
  textFont(font);
  textw = textWidth("_");
  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }

    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[0]);
    cam.start();     
  }
}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }

  image(cam, 0, 0, width/textw, height/size);
  loadPixels();
  background(0);
  for (int i =0; i<width/textw; i++) {
    for (int j =0; j<height/size; j++) {
      float br = brightness(pixels[floor(i+j*width)]);
      int charindex = floor(map(br, 0, 255, 0, chars.length()-1));
      println(charindex);
      //println(charindex);
      String char_ = ""+chars.charAt(charindex);
      text(char_, i*textw, j*size);
    }
  }
  //updatePixels();
}
