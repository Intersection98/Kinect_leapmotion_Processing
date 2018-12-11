class Triangle
{
  PVector A, B, C;
  
  Triangle(PVector p1, PVector p2, PVector p3)
  {
    A = p1;
    B = p2;
    C = p3;
  }
  
  void display()
  {
    vertex(A.x, A.y);
    vertex(B.x, B.y);
    vertex(C.x, C.y);
  }
}

class TriangleSystem
{
  ArrayList<Triangle> triangles = new ArrayList<Triangle>();
  
  void addTriangles(ArrayList<Particle> neighbours)
  {
    // Takes neighbours of a particle and adds triangles
    int size = neighbours.size();
    
    // Foreach neighbour (if there are over 2 neighbours)
    if (size > 2)
    {
      for (int i = 1; i < size - 1; i++)
      {
        for (int j = i + 1; j < size; j++)
        {
          if (triangles.size() < MAX_TRIANGLES) {
            // Create new triangle for each neighbour (always use the particle itself as part of the triangle)
            triangles.add(new Triangle(neighbours.get(0).pos, neighbours.get(i).pos, neighbours.get(j).pos));
          }
        }
      }
    }
  }
  
  void display() 
  {
    noStroke();
    stroke(max(colour.R, 0), max(colour.G, 0), max(colour.B, 0), 13);// - 15, 0), max(colour.G - 15, 0), max(colour.B, 0), 13);
    fill(amplify(colour.R), amplify(colour.G), amplify(colour.B), 30);
    //noFill();
    
    beginShape(TRIANGLES);
    for (int i = 0; i < triangles.size(); i++)
    {
      Triangle t = triangles.get(i);
      t.display();
    }
    endShape();  
  }
  
  void clear()
  {
    // Clear triangles
    triangles = new ArrayList<Triangle>(); 
  }
  
}
