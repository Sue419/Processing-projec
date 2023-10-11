
/*CONCEPTO: EL PROYECTO QUIERE MOSTRAR UNA FRACCIÓN DE UN BOSQUE A TRAVÉS DE UN
ÁRBOL DE FANTASÍA, SALIDO DESDE LO ONÍRICO.
LA CANCIÓN SE COMPLEMENTA CON LA CAÍDA DE LA LLUVIA Y LA APARICIÓN DE LAS FLORES.
*/

//IMAGEN  ARBOL

Drops d[];
//CREAMOS OBJETOS IMAGEN LLAMADO IMAGENARBOL E IMAGENFLOR
PImage imagenArbol, imagenFlor;

int posX[] = {1080, 1050, 1060, 1055, 985, 951, 1020, 995, 980, 955, 930, 925, 915, 895, 890, 850, 770, 770, 760, 735, 700, 740, 745, 710, 732, 722, 670, 690, 695, 750, 820, 740, 780, 730};
int posY[] = {690, 682, 650, 610, 560, 570, 490, 430, 410, 380, 410, 430, 370, 390, 410, 450, 480, 440, 405, 445, 500, 510, 560, 570, 600, 620, 610, 640, 662, 690, 660, 740, 700, 660};
int cont, i;
int numFlor = posX.length;
int tonos[] = new int[numFlor];

int tono;

//IMPORTAR BIBLIOTECA SOUND
import processing.sound. *;
//CREAMOS OBJETO AUDIO
SoundFile cancion;
int estaSonando;

// PROGRAMA
void setup(){
  size(1200, 900); //VENTANA DE 1200X900PX
  colorMode(HSB, 360, 100, 100); //MODO DE COLOR HSB
  background(0, 0, 100); //COLOR DE FONDO NEGRO
  
  //ASIGNAR AL OBJETO AUDIO UN ARCHIVO DE AUDIO
  println("Archivo de audio cargando...");
  cancion = new SoundFile(this, "song.mp3");
  
  cancion.play();

//ASIGNAMOS AL OBJETO IMAGENARBOL LA INFORMACIÓN DEL ARCHIVO arbol1.png
imagenArbol = loadImage("arbol 1.png");
//ASIGNAMOS AL OBJETO IMAGENFLOR LA IMFORMACIÓN DEL ARCHIVO flor.png
imagenFlor = loadImage("flor.png");

println(posX.length);

cont = 0;
  background(0, 0, 100);
  noTint();
  image(imagenArbol, 660, 360); //MOSTRAR LA IMAGEN ARBOL

//LLUVIA 
   d=new Drops[500];
  for(int i=0;i<500;i++){
    d[i]=new Drops();
  } 
}

void draw(){
  fill(0, 0, 99, 99);
 rect(0, 0, width, height);
 for(int i=0;i<500;i++){
   
   if(d[i].y>d[i].endPos){
     d[i].end();
   }
   else
    d[i].display();
  }
  
  noTint();
  image(imagenArbol, 660, 360); //MOSTRAR IMAGEN ARBOL
  for(i=0; i<cont; i=i+1){
    tint(tonos[i], 90, 90);
    image(imagenFlor, posX[i], posY[i]); //MOSTRAR IMAGEN FLOR
  }

}

class Drops{
  float x,y,speed;
  float ellipseX,ellipseY,endPos;
  color c;
  Drops(){
    init();
  }
  void init(){
    x=random(width);
    y=random(-300,0);
    speed=random(1,4)*2;
    c=color(random(360),random(360),random(360));
    ellipseX=0;
    ellipseY=0;
    endPos=height+100-(random(200));
  }
  
  void update(){
    y+=speed;
  }  

void display(){
  fill(c);
  noStroke();
  rect(x,y,2,15);
  update();
}

  void end(){
    stroke(c);
    noFill();
    ellipse(x,y,ellipseX,ellipseY);
  
    ellipseY+=speed*0.2;
    ellipseX+=speed*0.5;
    if(ellipseX>30) {
      init();
    }   
  }
}

//FLORES
void keyPressed(){
  if (key==' '){
      println(cont);
      tonos[cont] = int(random(270, 360));
      tint(tonos[cont], 90, 90);
      image(imagenFlor, posX[cont], posY[cont]);
      cont = cont +1;
      if (cont == posX.length){
        background(0, 0, 0);
        noTint();
        image(imagenArbol, 660, 360);
        cont = 0;
      }
  }
 //PLAY - STOP AUDIO 
  if(key == '1'){
    //Si audio no esta sonando => ejecutar play()
    if(estaSonando == 0){
      cancion.play();
      estaSonando = 1;
      println("play()");
    }
  }

  if(key == '2'){
    cancion.jump(0);
    cancion.pause();
    estaSonando = 0;
    println("stop()");
    background(0, 0, 100);
  }
}
