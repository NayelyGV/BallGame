import fisica.*;

PImage fondo,plataforma, suelo, imagenPortada, instrucciones;

FWorld world; //Nuevo mundo
// _=es una variable que esta dentro de una funcion
Plataforma piso;//Objeto del piso base del personaje
ArrayList<Plataforma> plataformas;

String cartel;
String estado;

 PFont arcadeFont;
Obstaculo caja, triangulo1, triangulo2, tubo;//cuantos triangulos seran
Personaje ball;



void setup()
{
 size(800,700);
 estado="portada";
 arcadeFont = loadFont("ArcadeClassic-48.vlw");
  textFont(arcadeFont);
 fondo=loadImage("cielo5.jpg");
 plataforma=loadImage("plataform.jpg");
 suelo=loadImage("plataforma.png");
 instrucciones= loadImage("db5.jpg");
 

 
 Fisica.init(this);
 world=new  FWorld();
 //Para controlar los saltos
 world.setGravity(0,400);
 world.setEdges();
 
 estado = "portada";
 imagenPortada = loadImage ("portada3.jpg");
 
 textSize(50);
 textAlign(CENTER);
 cartel="";
 
 plataformas = new ArrayList <Plataforma>();//Se inicializa el ArrayList de plataforma
 for(int i=0; i<4; i++)//<5 numero de rectangulos
 {
   Plataforma p = new Plataforma (150,16);//Tamaño de los rectangulos
   //height-150(altura que aparece)i*100(sobre que distancia se pone cada cuadrado)
   p.inicializar(i*100+420, height-160-(i*100), false);
   world.add(p);
   plataformas.add(p);
 }

 //---------PISO
 piso = new Plataforma(width,50);//Ancho de la pantalla con alto de 10
 piso.inicializar(width/2, height-10, true ); //Posicion del piso
 world.add(piso);//Añadimos el objeto dentro del piso//(se cambia el piso.cuerpo por piso)
 //--------OBSTACULO
 //Caja
 caja=new Obstaculo (40,40, "caja");//tamaño
 caja.inicializar(160, height-150 ); //Posicion
 world.add(caja);//Añadimos el objeto
 //Triangulo
 triangulo1=new Obstaculo (40,55, "triangulo");//tamaño
 triangulo1.inicializar(plataformas.get(2).getX(), plataformas.get(2).getY() - triangulo1.getHeight()/2 - plataformas.get(2).getHeight()); //Posicion
 world.add(triangulo1);//Añadimos el objeto
 
 triangulo2=new Obstaculo (40,55, "triangulo");//tamaño
 triangulo2.inicializar(plataformas.get(1).getX(), plataformas.get(1).getY() - triangulo2.getHeight()/2 - plataformas.get(1).getHeight()); //Posicion
 world.add(triangulo2);//Añadimos el objeto
 //Tubo
 tubo=new Obstaculo (100,100, "tubo");//tamaño
 tubo.inicializar(plataformas.get(3).getX(), plataformas.get(3).getY() - triangulo2.getHeight()/2 - plataformas.get(3).getHeight()); //Posicion
 world.add(tubo);//Añadimos el objeto
 
 //------PERSONAJE
 ball=new Personaje (50,50);//tamaño
 ball.inicializar(40, height*0.75); //Posicion
 world.add(ball);//Añadimos el objeto
}

void draw()
{
  if (estado=="portada")
  {
    imagenPortada.resize(800, 700);
    image(imagenPortada, 0, 0);
    fill(0);
    pushStyle();
     noSmooth();
    textSize(72);
    textLeading(66);
    text("JUGAR", width/2,height/2-30);
    textSize(40);
    textLeading(40);
    text("Enter para continuar", width/2,height/2-110);
    
    popStyle();
    
  }
  else if(estado=="juego" || estado=="fin")
  {
    fondo.resize(800, 700);
    image(fondo, 0, 0);
    ball.actualizar();
    world.step();
    world.draw();
     for(int i=0; i<width; i+=50)
   { image(loadImage("suelo1.png"), i , height-35);  }
   if (estado=="fin")
   {
     pushStyle();
     noSmooth();
     textSize(74);
     textLeading(66);
     text(cartel, width/2,height/2-10);
     textSize(40);
     textLeading(40);
     text("PRESIONA ENTER", width/2,height/2+100);
     popStyle();
   }
  }
 
  
  
 
  

}

void keyPressed()
{
  if (estado=="portada")
  { 
     if (keyCode == 10){
      estado="juego";
       ball.inicializar(40,height-60);
       world.add(ball);
       caja.inicializar(width-80, height-60);
       }
  }
    
     
  else if (estado =="juego")
  {
  if (keyCode == 37)
  { ball.izqPresionado=true; }
  if (keyCode == 39)
  { ball.derPresionado=true; } 
  if (keyCode == 32)
  { ball.arribaPresionado=true; } 
  }
  else if (estado == "fin")
  {
    if (keyCode == 10)
    { estado = "portada";
    }
  }
}
void keyReleased()
{
  if (keyCode == 37)
  { ball.izqPresionado=false; }
  if (keyCode == 39)
  { ball.derPresionado=false; } 
  if (keyCode == 32)
  { ball.arribaPresionado=false; } 
}

void contactStarted(FContact contact)//Devuelve un parametro de tipo FContact
{
 FBody _body1 = contact.getBody1(); 
 FBody _body2 = contact.getBody2();
 
 //-----------CONTACTO ENTRE EL PERSONAJE Y PLATAFORMA/CAJA
 //Si el body1 su nombre es personajey si el body2 su nombre es plataforma o es caja
 if ((_body1.getName() == "personaje" && (_body2.getName() == "plataforma" || _body2.getName() == "caja"))
 //O el body2 su nombre es personajey si el body1 su nombre es plataforma o es caja
 || (_body2.getName() == "personaje" && (_body1.getName() == "plataforma" || _body1.getName() == "caja")))
 {
   //Normal=direccion del contacto   
   //Si la direccion desde arriba o abajola normal en x sera 0 && Si la velocidad es mayor a 0 cae
   if (contact.getNormalX() == 0 && ball.getVelocityY() >= 0)
   {
     //El contacto se genera cuando esta arriba
     if ( _body1.getName() == "personaje"  && contact.getNormalY()>0)
     {
       ball.puedeSaltar = true;
     }
     //El contacto se genera cuando esta abajo
     else if ( _body2.getName() == "personaje"  && contact.getNormalY()<0)
     {
       ball.puedeSaltar = true;
     }
   }
 }
 
  //-----------CONTACTO ENTRE EL PERSONAJE Y TRIANGULO
 if ((_body1.getName() == "personaje" && _body2.getName() == "triangulo")
 || (_body2.getName() == "personaje" && _body1.getName() == "triangulo"))
 {
    if (ball.vivo)
    {
      perder();
    }
  }
  //-----------CONTACTO ENTRE EL PERSONAJE Y TUBO
  if ((_body1.getName() == "personaje" && _body2.getName() == "tubo" )
  || (_body2.getName() == "personaje" && _body1.getName() == "tubo"))
 {
   if (contact.getNormalX() == 0 && ball.getVelocityY() >= 0)
   {
     if ( _body1.getName() == "personaje"  && contact.getNormalY()>0)
     { ganar(); }
     else if ( _body2.getName() == "personaje"  && contact.getNormalY()<0)
     { ganar(); }
   }
 }
}
 void perder()
 {
 estado="fin";
 cartel= "GAME OVER";
 ball.matar();
 world.remove(ball);
 }
 
 void ganar()
 {
   estado="fin";
   cartel = "Cograts";
   ball.matar();
   world.remove (ball);
 }
