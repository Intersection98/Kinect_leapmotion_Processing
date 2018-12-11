class Wanderer {
  PVector loc;
  PVector vel;
  PVector acc;
  
  float angle;
  
  Wanderer() 
  {
    loc = new PVector(random(width), random(height));
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }
  
  void update()
  {
    // Move in random direction with random speed
    angle += random(0, TWO_PI);
    float magnitude = random(0, 1.5); //3
    
    // Work out force 
    acc.x += cos(angle) * magnitude;
    acc.y += sin(angle) * magnitude;
    
    // limit result
    acc.limit(3);
    
    // Add to current velocity
    vel.add(acc);
    vel.limit(MAX_WANDERER_SPEED);//6);
    
    // Appy result to current location
    loc.add(vel);
    
    // Wrap around screen
    if (loc.x > width)
      loc.x -= width;
     if (loc.x < 0)
       loc.x += width;
     if(loc.y > height)
       loc.y -= height;
     if(loc.y < 0)
       loc.y += height;
  }
  
  void display() {
     fill(0);
     ellipse(loc.x, loc.y, 10, 10);
  }
}
