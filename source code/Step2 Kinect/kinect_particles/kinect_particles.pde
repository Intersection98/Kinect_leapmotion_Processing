// Inspire by Daniel Shiffman
// Coding Challenge #24: Perlin Noise Flow  Field
// https://youtu.be/BjoM9oKOAKY

import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import org.openkinect.tests.*;
ParticleSystem ps;
Kinect2 kinect2;
float minThresh=880;
float maxThresh=1430;
PImage img;

FlowField flowfield;
ArrayList<Particle> particles;

boolean debug = false;

void setup() {
  colorMode(HSB);
  fullScreen();
    //size(1024,848,P3D);
     ps = new ParticleSystem(new PVector(width/2,50));
  
 
  kinect2 = new Kinect2(this);
  kinect2.initVideo();
  kinect2.initDepth();
//  kinect2.initIR();
 // kinect2.initRegistered();
  kinect2.initDevice();
  particles = new ArrayList<Particle>();
 
 
  img=createImage(kinect2.depthWidth,kinect2.depthHeight,RGB);
}

void draw() {
  scale(2);
   background(255,1);
  img.loadPixels();
  int[] depth=kinect2.getRawDepth();
  //image(img,0,0);

     
      for(int x=0;x<kinect2.depthWidth;x++){
    for(int y=0;y<kinect2.depthHeight;y++){
      int offset=x+y*kinect2.depthWidth;
      int d=depth[offset];
      if(d>minThresh && d<maxThresh && random(0,100)<5 &&  random(100)<1){
    // img.pixels[offset]=color(255,0,150);
       ps.origin.set(x,y,0);
    
  ps.addParticle();
  ps.run();
      }
    }
  }
  
 
}
