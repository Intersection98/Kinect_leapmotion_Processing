
float angle, speed;
float l0, l1, l2;
int n = 9;
int n2=6;
boolean first = true;
import java.util.Iterator;
import de.voidplus.leapmotion.*; 
LeapMotion leap;
PVector fp;
float hue;
float hue2;

void setup() {
  colorMode(HSB);
  fullScreen();
  angle = 0;
  speed = 0.01;
  background(0);
   leap = new LeapMotion(this);
}

void draw() { 
  //background(0,1);
  fill(0, 10);
  rect(0, 0, width, height);

  translate(width/2, height/2);
  rotate(angle);
  for (Hand hand : leap.getHands()) {
    fp=hand.getPosition();
   l0 = map(fp.x, 0,fp.y, 50, 200);
  l1 = map(fp.y, 0, fp.x, 0, 150);
  l2 = map(fp.x+fp.y+fp.z, 0, width+height, 25, 100);
  hue=map(fp.x, 0,fp.y, 0, 255);
  hue2=map(fp.x+fp.y+fp.z, 0, width+height, 0, 255);
  speed=map(fp.z,0,width,0,0.5);
 
    }

  
   for (int i=0; i<n; i++) {
    fill(hue,150, 250);
    pushMatrix();
    rotate(i*TWO_PI/n);
    translate(l1, l0);
    ellipse(0, 0, 15, 15);

    for (int j=0; j<n; j++) {
      fill(hue, 100,200);
      pushMatrix();
      rotate(j*TWO_PI/n);
      translate(l2, l1+1);
      ellipse(0, 0, random(4,10), random(4,10));

      for (int k=0; k<n2; k++) {
        fill(hue2, hue2,100);
        pushMatrix();
        rotate(k*TWO_PI/n);
        translate(0, l2+random(0,30));    
        ellipse(0, 0, 5, 5);
        popMatrix();
      }
      popMatrix();
    }
    popMatrix();
  }
  angle = (angle+speed)%TWO_PI;
}
