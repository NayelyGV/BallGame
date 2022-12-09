class Obstaculo extends FBox//Nuestra plataforma es un objeto de tipo FBox
//Estamos extendiendo la libreria piso
 {
  //tipo de obstaculo
  String tipo;
  
  
  Obstaculo(float _w, float _h, String _tipo)
  { 
    super (_w,_h);
    tipo = _tipo;
  }
  void inicializar(float _x, float _y)
  {
    //Definiendo los obstaculos
    if (tipo.equals("caja"))
    {
      setName("caja");
      setStatic(false);
      setRestitution(0.5);
      attachImage(loadImage("suelo1.png"));
    }
    else if (tipo.equals("triangulo"))
    {
      setName("triangulo");
      setStatic(true);
      attachImage(loadImage("fuego.png"));
    }
    else if (tipo.equals("tubo"))
    {
      setName("tubo");
      setStatic(true);
      attachImage(loadImage("Ganar.png"));
    }
  
    setPosition(_x,_y);
    setRotatable(false);//false=para que rote true=para que no rote
  }
}
