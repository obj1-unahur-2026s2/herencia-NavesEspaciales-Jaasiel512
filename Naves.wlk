class Nave{
  var property velocidad = 0
  var property direccion = 0
  var property combustible = 0

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

  method cargarCombustible(cant){
    combustible += cant
  }
  method descargarCombustible(cant){
    combustible -= cant
  }

  method prepararViaje(){
    self.cargarCombustible(30000)
    self.acelerar(5000)
  }

  method estaTranquila() = combustible >= 4000 and velocidad < 12000

  method recibirAmenaza(){
    self.escapar()
    self.avisar()
  }
  method escapar()
  method avisar() 

  method estaRelajada() = self.estaTranquila() and self.pocaActividad()
  method pocaActividad()
  method nuevoDia()
}

class NaveBaliza inherits Nave{
  var property color = "azul"
  var property cambiosDeColor = 0

  method cambiarColorDeBaliza(nuevoColor) {
    color = nuevoColor
    cambiosDeColor += 1
  }

  override method nuevoDia() {
    cambiosDeColor = 0
  }

  override method prepararViaje() {
    super()
    self.cambiarColorDeBaliza("verde")
    self.ponerseParaleloAlSol()
  }

  override method estaTranquila() = super() and color != "rojo"

  override method escapar() {
    self.irHaciaElSol()
  }
  override method avisar() {
    self.cambiarColorDeBaliza("rojo")
  }

  override method pocaActividad() = cambiosDeColor == 0    
}

class NavePasajeros inherits Nave{
  const property capacidad
  var property bebidas = 0
  var property comida = 0
  var property comidaConsumida = 0

  method cargarComida(cantidad) {
    comida += cantidad
  } 
  method descargarComida(cantidad) {
    comida -= cantidad
    comidaConsumida += cantidad
  }
  method cargarBebidas(cantidad) {
    bebidas += cantidad
  }
  method descargarBebidas(cantidad) {
    bebidas -= cantidad
  }

  override method nuevoDia() {
    comidaConsumida = 0
  }

  override method prepararViaje() {
    super()
    self.cargarComida(capacidad * 4)
    self.cargarBebidas(capacidad * 6)
    self.acercarseUnPocoAlSol()
  }

  override method escapar() {
    self.acelerar(velocidad * 2)
  }
  override method avisar() {
    self.descargarComida(capacidad)
    self.descargarBebidas(capacidad * 2)
  }

  override method pocaActividad() = comidaConsumida < 50
}

class NaveCombate inherits Nave{
  var property invisible = false
  var property misiles = false
  const property mensajesEmitidos = []
  var property cantDeDespliegues = 0

  method estaInvisible() = self.invisible()
  method ponerInvisible() {
    invisible = true
  }
  method ponerVisible() {
    invisible = false
  }

  method misilesDesplegados() = self.misiles()
  method desplegarMisiles() {
    misiles = true
    cantDeDespliegues += 1
  }
  method replegarMisiles() {
    misiles = false
  }

  method emitirMensaje(mens) {
    mensajesEmitidos.add(mens)
  }
  method mensajesEmitidos() = mensajesEmitidos
  method primerMensajeEmitido() = mensajesEmitidos.first()
  method ultimoMensajeEmitido() = mensajesEmitidos.last()
  method emitioMensaje(mens) = mensajesEmitidos.contains(mens)
  method esEscueta() = mensajesEmitidos.any({m => m.size() > 30})

  override method prepararViaje() {
    super()
    self.ponerVisible()
    self.replegarMisiles()
    self.acelerar(15000)
    self.emitirMensaje("Saliendo en mision")
  }

  override method estaTranquila() = super() and not self.misilesDesplegados()

  override method escapar() {
    self.acercarseUnPocoAlSol()
    self.acercarseUnPocoAlSol()
  }
  override method avisar() {
    self.emitirMensaje("Amenaza recibida")
  }

  override method pocaActividad() = cantDeDespliegues == 0
  override method nuevoDia() {
    cantDeDespliegues = 0
  }
}

class NaveHospital inherits NavePasajeros{
  var property quirofanos = true 

  method quirofanosPreparados() {
    quirofanos = true
  }
  method quirofanosNoPreparados() {
    quirofanos = false
  }

  override method estaTranquila() = super() and not quirofanos

  override method recibirAmenaza() {
    super()
    self.quirofanosPreparados()
  }
}

class NaveCombateSigilosa inherits NaveCombate{
  override method estaTranquila() = super() and not self.estaInvisible()

  override method escapar() {
    super()
    self.desplegarMisiles()
    self.ponerInvisible()
  }
}


