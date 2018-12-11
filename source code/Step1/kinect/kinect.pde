import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import org.openkinect.tests.*;



import java.nio.FloatBuffer;

// Kinect Library object
Kinect2 kinect2;

float minThresh=880;
float maxThresh=1430;
PImage img;



void setup() {

  // Rendering in P3D
  size(1024, 848);

  kinect2 = new Kinect2(this);
  kinect2.initDepth();
  kinect2.initDevice();
  img=createImage(kinect2.depthWidth,kinect2.depthHeight,RGB);
 // println(kinect2.depthWidth,kinect2.depthHeight);
}

void draw() {
  scale(2);
  background(0);
  
  img.loadPixels();
  
//  minThresh=map(mouseX,0,width,0,4500);
//  maxThresh=map(mouseY,0,height,0,4500);
  
  int[] depth=kinect2.getRawDepth();
  
  for(int x=0;x<kinect2.depthWidth;x++){
    for(int y=0;y<kinect2.depthHeight;y++){
      int offset=x+y*kinect2.depthWidth;
      int d=depth[offset];
      
      if(d>minThresh && d<maxThresh){
      img.pixels[offset]=color(255,0,150);
      } else{
        img.pixels[offset]=color(0);
    }
  }
  }
  
  img.updatePixels();
  image(img,0,0);
 
  
  fill(255);
  textSize(32);
  text(minThresh+""+maxThresh,10,64);
}
