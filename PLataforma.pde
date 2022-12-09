class Plataforma extends FBox//Nuestra plataforma es un objeto de tipo FBox
//Estamos extendiendo la libreria piso
 {
   /*-------Cuando se añade el extends se elimina todo esto y se cambia por el super
  FBox cuerpo; //Rectangulo
  Plataforma(float _w, float _h)//Ancho y alto
  { cuerpo= new FBox (_w,_h);} */
  Plataforma(float _w, float _h)
  { super (_w,_h); }
  void inicializar(float _x, float _y, Boolean _piso)
  {
    /*-------Se elimina los cuerpos
    cuerpo.setName("plataforma");
    cuerpo.setPosition(_x,_y);
    cuerpo.setStatic(true);//No se cae por la gravedad, se queda fija en el lugar*/
    setName("plataforma");
    setPosition(_x,_y);
    setStatic(true);
    if (!_piso)
     attachImage(loadImage("plataform.png"));
  }
}
