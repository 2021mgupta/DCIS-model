//import java.util.Vector;
float interval = 1000;
int lastRecordedTime = 0;
float maxDist;
int capacity=65;
float cellLength=30;
ArrayList <Cell> points;
 float cycleLength=3000;
 float sumX;
 float sumY;
 float avgX;
 float avgY;
 int r;
 int crowdInitial;
 
void setup() {
points=new ArrayList<Cell>();
maxDist=dist(0,0,width/2,height/2);
size(800, 800);
r=400;
  noStroke();
  colorMode(HSB);
  for (float i = 0; i < TAU; i+=TAU/50) {
    points.add(new Cell(r, i));//initialzing points
  }
   crowdInitial= crowdFactor(points.get(0));
   println("crowd Initial: "+crowdInitial);
  for(Cell c:points){
  sumX+=c.x();
  sumY+=c.y();
  }
 avgX=sumX/points.size();
  avgY=sumY/points.size();
 drawNoise();
  }
  
  

void cellFate(int index) {
 //float centerDist=0; 
 boolean dead =false;
Cell rand= points.get(index);
//centerDist=dist(rand.x(),rand.y(), avgX, avgY);
rand.setO2(pow(rand.r(),4-rand.aggression)/pow(crowdFactor(rand),1));
  float prob=rand.o2()/(.001*rand.elapsed());
float base=pow(r,4-rand.aggression)/pow(crowdInitial,2);
float probsimp=prob/base;
  //float randVal=random(pow(r,4)/pow(crowdInitial,2));
  float randVal=random(1);
    println("aggression"+ rand.aggression+"x"+rand.x()+" y "+rand.y()+" prob "+probsimp+"randVal: "+randVal);
if((randVal>(1+(0.25*rand.aggression))*probsimp))
{
     
    die(index);
     dead=true;
 }

if(!dead&&rand.elapsed()>rand.cycleLength()){
  //float cycleProb= (centerDist+5)/crowdFactor(rand);
  
  if(random(pow(r,4-rand.aggression)/pow(crowdInitial,2))<prob){
   divide(rand);
  
  
  }
}
avgX=sumX/points.size();
avgY=sumY/points.size();
}
void divide(Cell rand){
 
  //Cell c= new Cell(new PVector(min(max(10,rand.x())+random(80)-40,width-10), min(max(rand.y()+random(80)-40,10),height-10)));
  Cell c= new Cell(rand);
  points.add(c);
  sumX+=c.x();
  sumY+=c.y();
  rand.cycle();
  
}
void die(int index){
    Cell c=points.get(index);
    sumY-=c.y();
    sumX-=c.x();
    points.remove(index);
    
}
void draw() {
  //PVector.random2D().mult(5);

      if (millis()-lastRecordedTime>interval)
      {
        for(int x=0;x<points.size();x++){
        cellFate(x);
       
      
        }
     drawNoise();
          lastRecordedTime=millis();
      }

  //points.get(0).location.x = mouseX;
  //points.get(0).location.y = mouseY;
  
}

float dist2(int x1, int y1, int x2, int y2) {
  return abs(x2 - x1 + y2 - y1);

}

int crowdFactor(Cell c){
 float lowX=c.x()-100;
 float highX=c.x()+100;
 float lowY=c.y()-100;
 float highY=c.y()+100;
 int cellCount=0;
 for(Cell a: points)
 {
   if(lowX<a.x()&&lowY<a.y()&&highX>a.x()&&highY>a.y())
   {
     cellCount++;
   }

 }
 
     return cellCount;
  
}

void drawNoise() {
  
//  int index = int(random(points.size()));  
//PVector rand = points.get(index);//random vector from the array
//  rand.add(PVector.random2D().mult(2));


  int res = 3;
  int ag=0;
  for (int x = 0; x < width; x += res) {
    for (int y = 0; y < height; y += res) {
      float close = 100000;
      //PVector closeP= new PVector();
      for (Cell p: points) {
        if (dist(x, y, p.x(), p.y()) < close) {
          close = dist(x, y, p.x(), p.y());
          ag=p.aggression;
          //closeP = p;
        }
      }
      //int col = 255;
      //if (close < 75)
      //col = 0;
      //println("colour: "+max(100-close*4,0));
      fill(0,max(200-close*3,0) , 500);
      //fill(closeP.x, 100, 50)
      rect(x, y, res, res);
     
  
    }
  }
  for(Cell c: points){
fill(c.aggression*60, 200, 500);
rect(c.x()-3,c.y()-3, 6, 6);
  }
}
