class Particle{
  PVector loc, vel, acc;
  int lifeSpan, passedLife;
  boolean dead;
  float alpha, weight, weightRange, decay, xOffset, yOffset;
  color c;
 
  Particle(float x, float y, float xOffset, float yOffset){
    loc = new PVector(x,y);
 
    float randDegrees = random(360);
    vel = new PVector(cos(radians(randDegrees)), sin(radians(randDegrees)));
    vel.mult(random(20));
 
    acc = new PVector(0,0);
    lifeSpan = int(random(50, 200));
    decay = random(0.75, 0.9);
    c = color(random(255),random(255),255);
    weightRange = random(3,50);
 
    this.xOffset = xOffset;
    this.yOffset = yOffset;
  }
 
  void update(){
    if(passedLife>=lifeSpan){
      dead = true;
    }else{
      passedLife++;
    }
 
    alpha = float(lifeSpan-passedLife)/lifeSpan * 10+50;
    weight = float(lifeSpan-passedLife)/lifeSpan * weightRange;
 
    acc.set(0,0);
 
    float rn = (noise((loc.x+frameCount+xOffset)*0.01, (loc.y+frameCount+yOffset)*0.01)-0.5)*4*PI;
    float mag = noise((loc.y+frameCount)*0.01, (loc.x+frameCount)*0.01);
    PVector dir = new PVector(cos(rn),sin(rn));
    acc.add(dir);
    acc.mult(mag);
 
    float randDegrees = random(360);
    PVector randV = new PVector(cos(radians(randDegrees)), sin(radians(randDegrees)));
    randV.mult(0.5);
    acc.add(randV);
 
    vel.add(acc);
    vel.mult(decay);
    vel.limit(3);
    loc.add(vel);
  }
 
  void display(){
    strokeWeight(weight+1.5);
    stroke(0, alpha);
    point(loc.x, loc.y);
 
    strokeWeight(weight);
    stroke(c);
    point(loc.x, loc.y);
  }
}
