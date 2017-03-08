class Particle
{
  PVector location;
  PVector velocity;
  PVector acceleration;
  float size;
  float max_force;
  float max_speed;
  float color_value;
  color body_color;
  
  Particle(float x, float y, float z)
  {
    location = new PVector(x, y, z);
    velocity = new PVector(0, 0, 0);
    acceleration = new PVector(0, 0, 0);
    size = 15;
    max_force = 2;
    max_speed = 8;
    color_value = random(255);
    body_color = color(color_value, 255, 255);    
  }
  
  void follow(FlowField flow)
  {
    PVector desired = flow.lookup(location);
    desired.limit(max_speed);
    
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(max_force);
    applyForce(steer);
  }
  
  void seek(PVector target)
  {
    PVector desired = PVector.sub(target, location);
    float distance = desired.mag();
    desired.normalize();
    if(distance < 100)
    {
      float m = map(distance, 0, 100, 0, max_speed);
      desired.mult(m);
    }else
    {   
      desired.mult(max_speed);
    }
    
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(max_force);
    applyForce(steer);
  }
  
  void applyForce(PVector force)
  {
    acceleration.add(force);
  }
  
  void update()
  {
    PVector future = velocity.copy();
    future.normalize();
    future.mult(100);
    future.add(location);

    float angle_1 = random(360);
    float angle_2 = random(360);
    float x = 50 * cos(radians(angle_1)) + future.x;
    float y = 50 * sin(radians(angle_1)) + future.y;
    float z = 50 * cos(radians(angle_2)) + future.z;
    
    seek(new PVector(x, y, z));
    
    velocity.add(acceleration);
    velocity.limit(max_speed);
    location.add(velocity);
    acceleration.mult(0);
    
    if(PVector.dist(new PVector(width / 2, height / 2, 0), location) > width) 
    {  
      /*
      location.x = width / 2; 
      location.y = height / 2;
      location.z = 0;
      */
      
      seek(new PVector(width / 2, height / 2, 0));
    }
    
    color_value = (color_value + random(1, 10)) % 255;
    body_color = color(color_value, 255, 255);
  }
  
  void display()
  {
    fill(body_color, 128);
    noStroke();
    
    pushMatrix();
    translate(location.x, location.y, location.z);
    
    sphere(size);
    
    popMatrix();
  }
}