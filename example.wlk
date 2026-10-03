class Nave{
  var property velocidad = 0
  var property direccion = 0

  method acelerar(numero) {
    velocidad = (velocidad + numero).min(100000) 
  }
  method desacelerar(numero) {
    velocidad = (velocidad - numero).max(0)
  }
  method irHaciaElSol() {
    direccion = 10
  }
  method escaparDelSol() {
    direccion = -10
  }
  method ponerseParaleloAlSol(){
    direccion = 0
  }
  method acercarseUnPocoAlSol() {
    if(direccion < 10){
      direccion += 1
    }
  }
  method alejarseUnPocoDelSol() {
    if(direccion > -10){
      direccion -= 1
    }
  }

  method prepararViaje()
}

class NaveBaliza inherits Nave{
  var property color = "rojo"

  method cambiarColorDeBaliza(nuevoColor) {
    color = nuevoColor
  }

  override method prepararViaje() {
    self.cambiarColorDeBaliza("verde")
    self.ponerseParaleloAlSol()
  }   
}

class NavePasajeros inherits Nave{
  const property capacidad
  var property bebidas = 0
  var property comida = 0

  method cargarComida(cantidad) {
    comida += cantidad
  } 
  method descargarComida(cantidad) {
    comida -= cantidad
  }
  method cargarBebidas(cantidad) {
    bebidas += cantidad
  }
  method descargarBebidas(cantidad) {
    bebidas -= cantidad
  }

  override method prepararViaje() {
    self.cargarComida(capacidad * 4)
    self.cargarBebidas(capacidad * 6)
    self.acercarseUnPocoAlSol()
  }
}

class NaveCombate inherits Nave{
  var property invisible = invisible.condicion()
  var property misiles = misiles.condicion()
  var property mensaje = ""
  const property mensajesEmitidos = []

  method estaInvisible() = invisible
  method ponerInvisible() {
    invisible = invisible.activar()
  }
  method ponerVisible() {
    invisible = invisible.desactivar()
  }

  method misilesDesplegados() = misiles
  method desplegarMisiles() {
    misiles = misiles.desplegar()
  }
  method replegarMisiles() {
    misiles = misiles.replegar()
  }

  method emitirMensaje(mens) {
    mensaje = mens
    mensajesEmitidos.add(mens)
  }
  method mensajesEmitidos() = mensajesEmitidos
  method primerMensajeEmitido() = mensajesEmitidos.first()
  method ultimoMensajeEmitido() = mensajesEmitidos.last()
  method emitioMensaje(mens) = mensajesEmitidos.contains(mens)
  method esEscueta() = mensajesEmitidos.any({m => m.size() > 30})

  override method prepararViaje() {
    self.ponerVisible()
    self.replegarMisiles()
    self.acelerar(15000)
    self.emitirMensaje("Saliendo en mision")
  }
}

object invisible{
  var property condicion = false

  method activar() {
    condicion = true
  }
  method desactivar() {
    condicion = false
  }
}

object misiles{
  var property condicion = false

  method desplegar() {
    condicion = true
  }
  method replegar() {
    condicion = false
  }
}
