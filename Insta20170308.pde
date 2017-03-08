ArrayList<Particle> particles;
FlowField field;

void setup()
{
  size(512, 512, P3D);
  frameRate(30);
  blendMode(ADD);
  colorMode(HSB);
  hint(DISABLE_DEPTH_TEST);
  
  particles = new ArrayList<Particle>();
  for(int i = 0; i < 256; i++)
  {
    particles.add(new Particle(random(width), random(height), random(-150, 150)));
  }
  
  field = new FlowField(20);
}

void draw()
{
  background(0);
 
  float angle = frameCount % 360;
  float x = 458 * cos(radians(angle));
  float z = 458 * sin(radians(angle));   
  camera(x + width / 2.0, height / 2.0, z, 
         width / 2.0, height / 2.0, 0.0, 
         0.0, 1.0, 0.0);

  for(Particle p : particles)
  {
    p.follow(field);
    p.update();
    p.display();
  }
  
  /*
  println(frameCount);
  saveFrame("screen-#####.png");
  if(frameCount > 900)
  {
     exit();
  }
  */
}