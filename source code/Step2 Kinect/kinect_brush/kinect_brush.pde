// Watercolor
//Inspired by Levente Sandor, 2013

import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import org.openkinect.tests.*;
Kinect2 kinect2;
float minThresh=880;
float maxThresh=1430;
PImage img;
ArrayList<Brush> brushes; 

void setup() {
  fullScreen();
// size(1024,848,P3D);
  background(255);
  frameRate(20);
  kinect2 = new Kinect2(this);
  kinect2.initVideo();
  kinect2.initDepth();
//  kinect2.initIR();
 // kinect2.initRegistered();
  kinect2.initDevice();
   img=createImage(kinect2.depthWidth,kinect2.depthHeight,RGB);
 
}

void draw() {
  scale(2);
 background(0,5);
  img.loadPixels();
  int[] depth=kinect2.getRawDepth();
  //image(img,0,0);
brushes = new ArrayList<Brush>();
     
      for(int x=0;x<kinect2.depthWidth;x++){
    for(int y=0;y<kinect2.depthHeight;y++){
      int offset=x+y*kinect2.depthWidth;
      int d=depth[offset];
      if(d>minThresh && d<maxThresh && random(0,700)<1){
         
         brushes.add(new Brush(x,y));
      }
    }
      }
      
  for (Brush brush : brushes) {
    brush.paint();
  }
}



class Brush {
  float angle,y2,x2;
  int components[];

  color clr;
float lifespan;
  Brush(float x, float y) {
    lifespan = 255.0;
    angle = random(TWO_PI);
    x2=x;
    y2=y;
    clr = color(random(255), random(255), random(255), 40);
    components = new int[2];
    for (int i = 0; i < 2; i++) {
      components[i] = int(random(1, 5));
    }
  }

  void paint() {
    float a = 0;
    float r = 0;
    float x1 = x2;
    float y1 = y2;
    float u = random(0.2, 0.8);

    fill(clr);
    noStroke();    

    beginShape();
    while (a < TWO_PI) {
      vertex(x1, y1); 
      float v = random(0.85, 1);
      x1 = x2 + r * cos(angle + a) * u * v;
      y1 = y2 + r * sin(angle + a) * u * v;
      a += PI / 180;
      for (int i = 0; i < 2; i++) {
        r += sin(a * components[i]);
      }
    }
    endShape(CLOSE);

    if (x2 < 0 || x2 > width ||y2 < 0 || y2 > height) {
      angle += HALF_PI;
    }

    x2 += 2 * cos(angle);
    y2 += 2 * sin(angle); 
    angle += random(-0.15, 0.15);
  }
}
