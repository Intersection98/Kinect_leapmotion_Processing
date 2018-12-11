class Particle
{
  PVector velocity = new PVector(random(-MAX_PARTICLE_SPEED, MAX_PARTICLE_SPEED), random(-MAX_PARTICLE_SPEED, MAX_PARTICLE_SPEED));
  PVector pos;
  int lifespan = PARTICLE_LIFESPAN;
  //ColourGenerator colour = new ColourGenerator();
  
  // Stores nearby particles, for drawing triangles
  ArrayList<Particle> neighbours;
  
  Particle(PVector origin)
  {
    pos = origin;  
  }
  
  void move()
  {
    // Apply velocity to particle
    pos.add(velocity);
    
    // Wrap around screen
    if (pos.x > width)
      pos.x -= width;
    if (pos.x < 0)
      pos.x += width;
    if (pos.y > height)
      pos.y -= height;
    if (pos.y < 0)
      pos.y += height;
    
    // Decrease particle lifespan
    lifespan -= LIFESPAN_DECREMENT;
  }
  
  void display()
  {
    //colour.update();
    noFill();
    fill(colour.R, colour.G, colour.B, lifespan);
    ellipse(pos.x, pos.y, SIZE, SIZE);
  }
  
  boolean isDead()
  {
    if (lifespan < 0) {
      return true;
    } else {
      return false;
    }
  }
}
