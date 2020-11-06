
class Cell{
  
  PVector location;
  int timeAtCycle;
  int aggression;
  float oxygen;
  final float R= 400;

 Cell(PVector loc){
    location=loc;
    timeAtCycle=millis();
}
Cell(float r, float theta){
    float x= r*cos(theta)+R;
    float y=r*sin(theta)+R;
    location=new PVector(x,y);
}

Cell(Cell rand){
 location= new PVector(min(max(10,rand.x())+random(80)-40,width-10), min(max(rand.y()+random(80)-40,10),height-10));
float initial= pow(0.8*r,4)/pow(crowdInitial,2);
 if ( 7*random(initial)>rand.o2()){
   aggression=rand.aggression+1;
 }
 else aggression=rand.aggression;
   
  
}

float r(){
  return sqrt(pow(location.x-R,2)+pow(location.y-R,2));
}

void setO2(float oxy){
oxygen=oxy;
}
float o2(){
    return oxygen;
  }
float x()
{

  return location.x;
}
float y(){
  return location.y;
}
int elapsed(){
  return millis()-timeAtCycle;
}
int cycleLength(){
  return 3000-500*(aggression);
}
void cycle(){
  timeAtCycle=millis();
}
}
