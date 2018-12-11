class ParticleSystem
{
  ArrayList<Particle> particles = new ArrayList<Particle>();
  
  
  ParticleSystem() { }
  
  /* Add a particle to the particle system */
  void addParticle(PVector loc)
  {
    if (particles.size() < MAX_PARTICLES) {
      Particle part = new Particle(loc);
      
      for (int i = 0; i < SPAWN_DELAY; i++) {
        part.move();  
      }
      particles.add(part);
    }
  }
  
  /* Discover and draw triangles between particle neighbours */
  void discoverNeighbours()
  {
    Particle p1, p2;
    
    // Work out neighbours/triangles for each particle
    for (int x = 0; x < particles.size(); x++) {
      p1 = particles.get(x);
      
      // Clear neighbours
      p1.neighbours = new ArrayList<Particle>();
      
      // Add particle itself to list of its neighbours (so traingles form using this particle)
      p1.neighbours.add(p1);
      
      // For other particles
      for (int y = x + 1; y < particles.size(); y++) {
        p2 = particles.get(y);
        
        float distance = PVector.dist(p1.pos, p2.pos);
        
        // If particle is within max distance 
        if (distance > MIN_TRI_DISTANCE && distance < MAX_TRI_DISTANCE)
        {
          // Add to neighbours
          p1.neighbours.add(p2);  
        }
      }
      if (p1.neighbours.size() > 1 && p1.neighbours.size() < MAX_PARTICLE_NEIGHBOURS) {
          triangles.addTriangles(p1.neighbours);
      }
    }
  }
  
  /* Update Particle System */
  void update()
  {

    Iterator<Particle> i = particles.iterator();
    
    // Loop through particles and remove inactive particles
    while(i.hasNext()) {
      // Get next particle
      Particle p = i.next();
      
      // update position and lifespan
      p.move();
      
      // Remove particle if dead
      if (p.isDead()) {
        i.remove();
      } else {
        p.display();
      }
    }
    
    // Update the colour of the particle system
    colour.update();
    
    // Discover neighbours and draw triangles
    discoverNeighbours();
    
  }
}
