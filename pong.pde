//pong
Ball bob=new Ball();
Stick jim=new Stick(10,35);
Stick clide=new Stick(90,35);
int jimScore=0;
int clideScore=0;
float timer=0;
Boolean paused=true;
void setup(){
  size(800,700);
  surface.setResizable(true);
  scale(-1,1);
}

void draw(){
   background(#00FF00);
   fill(0,0,0);
   textSize(60);
   text(jimScore,30*width  /100,10*height/70);
   text(clideScore,70*width  /100,10*height/70);
   stroke(#ff3399);
   fill(#ff3300);
   if(!paused){
   bob.move(jim,clide); clide.move(); jim.move();}
   bob.display();
   jim.display();
   clide.display();
   timer++;
}



class Vector{
    float x,y;
    Vector(float a, float b){
        x=a; y=b;
    }
    void add(Vector a){
       this.x+=a.x;  this.y+=a.y;
    }
  
}
class Ball{
   Vector pos;
   Vector v; //velocity
   Ball(){
      pos= new Vector(50,50);
      v= new Vector(0.4,0.4);
   }
   void move(Stick a, Stick b){
      v.x=v.x*(1+pow(timer,0.4)*0.00005);
      v.y=v.y*(1+pow(timer,0.4)*0.00005);
      this.pos.add(this.v);
      if(pos.x>100){
        a.bounced=false; b.bounced=false;
        jimScore++;
        timer=0;
        v.x=0.4;
        v.y=0.4;
        pos.x=50;
        pos.y=35;
        v.x=-v.x;
      }
      if(pos.x<0){
        clideScore++;
        a.bounced=false; b.bounced=false;
        timer=0;
        v.x=0.4;
        v.y=0.4;
        pos.x=50;
        pos.y=35;
        v.x=-v.x;
      }
      if(pos.y>70 || pos.y<0){
        v.y=-v.y;
      }
      if(pow(pos.x-a.pos.x,2)<1  && pow(pos.y-a.pos.y,2)<36 && a.bounced==false){
        v.x=-v.x;
        pos.x+=1.5*v.x;
        a.bounced=true; b.bounced=false;
      }
      if(pow(pos.x-b.pos.x,2)<1 && pow(pos.y-b.pos.y,2)<36 && b.bounced==false){
        v.x=-v.x;
        pos.x+=1.5*v.x;
        a.bounced=false; b.bounced=true;
      }
   }
   
     void display(){
     ellipse(pos.x*width  /100,(pos.y)*height/70,1*width /100,1*width/100);}
}

class Stick{
    Boolean bounced=false;
    Vector pos;
    Vector v=new Vector(0,0);
    Stick(float x, float y){pos=new Vector(x,y);}
    void move(){
        v.y/=1.05;
        pos.y+=v.y;
        if (pos.y>64){
           pos.y=64; v.y=-0.5*v.y;
        }
        else if (pos.y<7){
           pos.y=7; v.y=-0.5*v.y;
        }
    }
    void display(){
       line(pos.x*width /100,(pos.y-6)*height/70,pos.x*width /100,(pos.y+6)*height/70);
       rect((pos.x-0.5)*width/100,(pos.y-6)*height/70,width/100,12*height/70);
    }
    
}

void keyPressed(){
   if (keyCode==ENTER){
      paused=!paused;
   }
   if(!paused){
   if (keyCode==DOWN){
      if (clide.pos.y<=65){
      clide.v.y+=0.75;
      }
   }
    if (keyCode==UP){
      if(clide.pos.y>=5){
      clide.v.y-=0.75;
      }
   }
   if (key=='s'||key=='S'){
      if (jim.pos.y<=65){
      jim.v.y+=0.75;
      }
   }
    if (key=='w'||key=='W'){
      if (jim.pos.y>=5){
      jim.v.y-=0.75;
      }
   }
   }
}