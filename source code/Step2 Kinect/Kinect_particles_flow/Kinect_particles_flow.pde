//Inspired by Daniel Shiffman

import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import org.openkinect.tests.*;
Kinect2 kinect2;
float minThresh=880;
float maxThresh=1430;
PImage img;
ArrayList<PVector> points; 
PVector fp;
 
ArrayList<Particle> pts;
boolean onPressed, cleanUp;


boolean debug = false;

void setup() {
   // size(1225,848,P3D);
  fullScreen();
  
  kinect2 = new Kinect2(this);
  kinect2.initVideo();
  kinect2.initDepth();
//  kinect2.initIR();
 // kinect2.initRegistered();
  kinect2.initDevice();
   points = new ArrayList<PVector>(); 
   smooth(8);
  noStroke();
  pts = new ArrayList<Particle>();
 
  background(255);
 
  img=createImage(kinect2.depthWidth,kinect2.depthHeight,RGB);
}

void draw() {
  scale(2);
  
  img.loadPixels();
  int[] depth=kinect2.getRawDepth();
 background(255,40);
 points = new ArrayList<PVector>();
     
      for(int x=0;x<kinect2.depthWidth;x++){
    for(int y=0;y<kinect2.depthHeight;y++){
      // background(255,1);
      int offset=x+y*kinect2.depthWidth;
      int d=depth[offset];
     
       
      if(d>minThresh && d<maxThresh && random(5000)<1){
    // img.pixels[offset]=color(255,0,150);
      //   points = new ArrayList<PVector>();
        points.add(new PVector(x, y));
    
      }
     
   
    }
  }
  
  {
   for (int i = points.size()-1; i >= 0; i--) {
    PVector p = points.get(i);
      Particle newP = new Particle(p.x, p.y, i+pts.size(), i+pts.size());
      pts.add(newP);
    }
  }
 
  for (int i=0; i<pts.size(); i++) {
    Particle p = pts.get(i);
    p.update();
    p.display();
  }
 
  for (int i=pts.size()-1; i>-1; i--) {
    Particle p = pts.get(i);
    if (p.dead) {
      pts.remove(i);
    }
  }
}
