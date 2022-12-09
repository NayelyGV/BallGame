class Personaje extends FBox//Personaje que extiende a FBox
 {
  
  Boolean izqPresionado, derPresionado, arribaPresionado;
  Boolean puedeSaltar;
  Boolean vivo;//si nuestro personaje esta vivo o no
   
  Personaje(float _w, float _h)//Llamamos al constructor
  { super (_w,_h); }
  void inicializar(float _x, float _y)
  {
    izqPresionado=false;
    derPresionado=false;
    arribaPresionado=false;
    puedeSaltar=false;
    vivo= true;
 
    
    setName("personaje");
    setPosition(_x,_y);
    setDamping(0);//Perdida de velocidad que tiene los objetos con el aire
    setRestitution(0);//rebote
    setFriction(0);
    setRotatable(false);//Para que el personaje no pueda rotar y este parado en el piso
  }
  void actualizar()
  {
   if (vivo)
   {
     attachImage(loadImage("personaje6.png"));
    if (izqPresionado)//si se presiona a la izqsera de 90 y el velocityY no se movera
    { setVelocity(-90,getVelocityY()); 
      //setPosition(getX()-10, getY());//No respeta las leyes de la fisica y atravesa las cajas
    }
    
    if (derPresionado)
    { 
      setVelocity(90,getVelocityY()); 
      //setPosition(getX()+10, getY());
    }
    //Esto hace que no se siga moviendo
    if (!izqPresionado && !derPresionado)
    { setVelocity(0,getVelocityY()); }
    
    //-----SALTAR
    if (arribaPresionado && puedeSaltar)
    { 
       setVelocity(getVelocityX(), -320);
       puedeSaltar = false;
     }
  }
 }
 void matar()
 {
   vivo=false;
 }
}
