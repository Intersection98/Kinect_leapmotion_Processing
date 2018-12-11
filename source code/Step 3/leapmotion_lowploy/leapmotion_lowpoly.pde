//Inspired by: https://www.openprocessing.org/sketch/413567


import java.util.Iterator;
import de.voidplus.leapmotion.*; 
LeapMotion leap;
PVector fp;

final float MAX_PARTICLES = 400; // ADD
final float MAX_TRIANGLES = 2000; //500 // ADD
final float MAX_PARTICLE_SPEED = 1.5;// 1.0;
final float SIZE = 5;//2;
final float LIFESPAN_DECREMENT = 2.0;//.5; //2.0
final float MAX_TRI_DISTANCE = 100;//50; //35 //25; 
final float MIN_TRI_DISTANCE = 25;//15; //10
final int MAX_PARTICLE_NEIGHBOURS = 15; //5;//10;//5;
final int MAX_WANDERER_SPEED = 6;//4;
final int SPAWN_DELAY = 20; //10
final int PARTICLE_LIFESPAN = 255;

// Simulation Systems
ParticleSystem system = new ParticleSystem();
TriangleSystem triangles = new TriangleSystem();

// Particle spawner
Wanderer spawner = new Wanderer();

/* Global colour object */
ColourGenerator colour = new ColourGenerator();

float posX, posY;

void setup()
{
  //colorMode(HSB);
  fullScreen();
 // size(750, 750, P2D);
  frameRate(60);
  noStroke();
  smooth();
   leap = new LeapMotion(this);
}

void draw()
{
  background(255);
 
  triangles.clear();
  

  spawner.update();
 
  system.update();
  triangles.display();
   for (Hand hand : leap.getHands()) {
    fp=hand.getPosition();
     system.addParticle(new PVector(fp.x, fp.y));
    }
    //saveFrame("1###.png");
  }
  
float amplify(float n) {
  return constrain(2 * n, 0, 255);
}
