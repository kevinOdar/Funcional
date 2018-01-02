# Night Club 2 - Functional Fest

## El dominio
Un amigo nuestro es encargado de un boliche, necesita modelar su negocio para mejorar la forma en que lo administra. En el relevamiento surgieron las siguientes entidades:
* Los clientes son personas mayores de edad. Al ingresar se registra su nombre, la resistencia, y los otros clientes a quienes considera amigos.
* Los clientes van teniendo nuevos amigos. Ningún cliente puede agregar a sí mismo como amigo y no tiene sentido volver a hacerse amigo de alguien a quien ya considera amigo.
* Cuando un cliente toma ciertas bebidas, suele verse afectado de forma diferente:
   * el grog XD deja sin resistencia al cliente.
   * la jarra loca baja 10 unidades de resistencia al cliente y a todos sus amigos.
   * el Klusener tiene diferentes gustos, como “Huevo”, “Chocolate” y “Frutilla”, entre otros, y disminuyen tanta resistencia como la cantidad de letras que tenga el gusto. Ej: Alguien toma Klusener de Huevo, eso le baja la resistencia 5 unidades.
   * el Tintico (café colombiano) le sube 5 puntos de resistencia al cliente por cada amigo que tenga.
   * la Soda, que dependiendo de la fuerza agrega “erp” al inicio del nombre del cliente, con tantas r como indique la fuerza. Por ejemplo, si Rodri se toma una soda con fuerza 2 y luego una soda con fuerza 5, su nombre queda “errrrrperrpRodri” (y queda con la misma resistencia y amigos).
* Pero como no es todo jarana, los clientes pueden decidir “rescatarse” un cierto tiempo medido en horas, que siempre es mayor a 0. Eso le devuelve 200 de resistencia si son más de 3 horas o 100 en caso contrario.
## Primer entrega
### Temas a evaluar
* Modelado de información
* Composición
* Aplicación parcial
* Definición con Guardas


### Punto 1
Modelar el tipo de dato cliente. Justificar el criterio utilizado.


### Punto 2
* Modelar a Rodri, que tiene 55 de resistencia y no considera a nadie como amigo. 
* También modelar a Marcos, un cliente que tiene resistencia 40 y considera a Rodri como su único amigo.
* Tenemos a Cristian, un cliente cuya resistencia es 2, y no considera a nadie como amigo.
* Por último está Ana, una cliente que tiene 120 de resistencia y considera a Marcos y a Rodri como amigos.


### Punto 3
Desarrollar la función comoEsta que dice cómo está un cliente
* Si su resistencia es mayor a 50, está “fresco”
* Si no está “fresco”, pero tiene más de un amigo, está “piola”
* En caso contrario, está “duro”


### Punto 4 
Hacer que un cliente reconozca como amigo a otro cliente, respetando las restricciones definidas por el negocio (no agregar más de una vez al mismo amigo ni agregarse a sí mismo como amigo, basándose en que dos clientes son iguales si tienen el mismo nombre).


### Punto 5
Representar con la abstracción que crea conveniente 
* a cada una de las bebidas mencionadas 
* y cómo queda un cliente luego de tomar cualquiera de las bebidas mencionadas. 


### Punto 6
Hacer que un cliente pueda rescatarse.


### Punto 7
Escribir la consulta en la consola que permita realizar el siguiente itinerario con Ana: tomarse una jarra loca, un klusener de chocolate, rescatarse 2 horas y luego tomar un klusener de huevo.
## Casos de prueba
### Punto 3
* Cristian debe estar “duro”
* Rodri debe estar “fresco”
* Marcos debe estar “duro”
* Si Marcos se hace amigo de Ana y Rodri, está “piola”


### Punto 4
* Intentar agregar a Rodri como amigo de Rodri. ¿Qué debe pasar?
* Hacer que Marcos reconozca a Rodri como amigo (que ya lo conoce). ¿Qué debe pasar?
* Hacer que Rodri reconozca a Marcos como amigo. Debe arrancar con 0 amigos y luego agregarlo a Rodri como único amigo.


### Punto 5
* Ana toma GrogXD. Queda con resistencia 0.
* Ana toma la Jarra Loca. Queda con resistencia 110, su amigo Marcos queda con 30 de resistencia y su amigo Rodri queda con 45 de resistencia.
* Ana toma un Klusener de huevo, queda con 115 de resistencia
* Ana toma un Klusener de chocolate, queda con 111 de resistencia
* Cristian toma un Tintico, queda con 2 de resistencia por no tener amigos.
* Ana toma un Tintico, pasa de 120 a 130 de resistencia (tiene 2 amigos)
* Rodri toma una Soda de fuerza 2, queda con nombre "errpRodri"
* Ana toma una Soda de fuerza 10, queda con nombre "errrrrrrrrrpAna"
* Ana toma una Soda de fuerza 0, queda con nombre "epAna"


### Punto 6
* Rodri se rescata 5 horas, queda con 255 de resistencia (55 + 200 ya que son más de 3 horas)
* Rodri se rescata 1 hora, queda con 155 de resistencia (55 + 100 porque son menos de 3 horas)


### Punto 7
Luego de evaluar el itinerario de Ana, queda con 196 de resistencia, como amigos a Marcos (30 de resistencia) y Rodri (45 de resistencia).

## Segunda entrega

### Punto 1
De los clientes, además del nombre, resistencia y sus amigos, se desea saber qué bebidas tomó.
1. Hacer las modificaciones en la abstracción cliente y considerar
   1. Que Rodri tomó un tintico
   2. Que Marcos tomó un Klusener de guinda
   3. Que Ana no tomó nada
   4. Que Cristian tomó un grog XD y una jarraLoca


Nota 1: Para mantener la compatibilidad con lo desarrollado anteriormente, recordar que se considera que dos clientes son iguales si tienen el mismo nombre.  En otras palabras, al cambiar el tipo cliente, revisar que la entrega 1 siga funcionando de acuerdo al enunciado. 

Nota 2: Si aparece un error “no instance for Show” leer acá: http://wiki.uqbar.org/wiki/articles/no-hay-instancias-para-el-show.html


b. Hacer que un cliente pueda tomar una bebida. Además del efecto que le causa la bebida en sí, se debe registrar esa bebida en su historial de bebidas tomadas. 


1. Desarrollar la función tomarTragos, la cual recibe a un cliente y una lista de tragos y retorna al cliente luego de tomarlos todos los tragos. 


1. Hacer la función dameOtro, que hace que un cliente vuelva a tomarse el último trago que se tomó.



### Punto 2
1. Definir la función cualesPuedeTomar, la cual recibe a un cliente y una lista de tragos y nos dice cuáles de esas bebidas lo dejarían con una resistencia mayor a cero, en caso de tomarlas solas.


1. Definir la función cuantasPuedeTomar, que devuelva la cantidad de bebidas en base al punto a).



### Punto 3
Ahora, aparecen diferentes itinerarios que pueden realizar los clientes, de los cuales se registran su nombre, una duración estimada  y lo más importante, el detalle de las acciones que componen el itinerario.

Algunos itinerarios son los siguientes:
* Mezcla explosiva, se recomienda para 2.5 horas y consiste en  tomarse 2 Grog XD, 1 Klusener de Huevo y otro de Frutilla.
* Itinerario básico, es como el del punto 7 de la primera parte, en 5 horas.
* Salida de amigos, se recomienda para 1 hora, consiste en tomarse una soda, de nivel 1, un tintico, hacerse amigo de Roberto Carlos (sí, es cliente de este boliche[1]) y tomarse una jarra loca.


1. Modelar los itinerarios existentes, para lo cual considerar que
   1. Roberto Carlos no tiene amigos, tiene 165 de resistencia y no tomó nada.
   2. Deben utilizar como expresiones robertoCarlos, mezclaExplosiva, itinerarioBasico, salidaDeAmigos.
1. Mostrar cómo rodri hace una salida de amigos y marcos una mezcla explosiva. 

### Punto 4
1. Conocer la intensidad de un itinerario, que se calcula como la cantidad de acciones que realiza por hora. 
Tip: si tenés problemas de tipos, podés intentar usar la función genericLength en lugar de la función length. Para eso tenés que escribir import Data.List arriba de todo en tu archivo .hs.
2. Hacer que un cliente realice el itinerario más intenso, entre un conjunto de itinerarios dado. 

### Punto 5
   1. Definir a chuckNorris, que es un cliente que inicialmente se llamaba “Chuck”, tiene resistencia 1000, es amigo de Ana y tomó todas las sodas que existen en el universo, comenzando por una soda de nivel 1, luego una de nivel 2, y así sucesivamente.
   2. Justificar: ¿Puede chuckNorris pedir otro trago con la función dameOtro?
   3. Justificar: ¿puedo hacer que chuckNorris realice el itinerario básico y conocer su resistencia resultante?
   4. Justificar: ¿puedo preguntar si chuckNorris tiene más resistencia que ana?

### Punto 6: BONUS
¡Se agrega al boliche la jarra popular! Cuando un cliente toma de la jarra popular, se vuelve amigo de los amigos de sus amigos, y de los amigos de los amigos de sus amigos, etc. La cantidad máxima de indirecciones está determinado por el nivel de espirituosidad de la jarra popular. Debe tenerse en cuenta que, como ya se explicó anteriormente, no se agregue amigos que ya tiene, ni a sí mismo.

## Casos de prueba
A los casos de prueba de la entrega anterior (que deben volver a correrse y garantizar que todo siga funcionando), se incorporan estos nuevos tests.


### Punto 1b
   * Marcos toma una soda de nivel 3 y queda con 2 bebidas
   * Marcos toma una soda de nivel 3 y queda con 40 de resistencia


### Punto 1c
   * Rodri toma una soda de nivel 1 y una soda de nivel 2 y queda con nombre errperpRodri
   * Marcos toma un klusener de huevo, un tintico y una jarraLoca y queda con 30 de resistencia
   * Marcos toma un klusener de huevo, un tintico y una jarraLoca y queda con 4 bebidas en el historial


### Punto 1d
   * Ana pide “dame otro” y debe dar error
   * Marcos pide “dame otro” y tiene 2 bebidas en el historial
   * Marcos pide “dame otro” y lo deja con 34 de resistencia
   * Rodri toma una soda de nivel 1, y "dameOtro" da como resultado que tiene 3 bebidas
   * Rodri toma una soda de nivel 1, y "dameOtro" da como resultado que su nombre queda “erperpRodri”


### Punto 2b
   * Rodri puede tomar dos bebidas, entre un grog XD, un tintico y un klusener de frutilla
   * Entre un grog XD, un tintico, un klusener de "fruuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuutilla" se puede tomar una sola bebida


### Punto 3b
   * Rodri hace una salida de amigos y debe quedar con un amigo
   * Rodri hace una salida de amigos y se debe llamar “erpRodri”
   * Rodri hace una salida de amigos y debe quedar con 45 de resistencia
   * Rodri hace una salida de amigos y su primer y único amigo Roberto Carlos debe quedar con 155 de resistencia
   * Rodri hace una salida de amigos y debe quedar con 4 bebidas en su historial. 


### Punto 4a
   * la intensidad de la mezcla explosiva es 1.6
   * la intensidad de la salidaDeAmigos es 4.0
   * la intensidad del itinerario basico es 0.8


### Punto 4b
   * Entre la salida de amigos, la mezcla explosiva y el itinerario básico, el itinerario más intenso es la salida de amigos (tip: se puede reconocer por el nombre)
   * Rodri hace el itinerario más intenso entre una salida de amigos, la mezcla explosiva y el itinerario básico y queda con el nombre "erpRodri"
   * Rodri hace el itinerario más intenso entre una salida de amigos, la mezcla explosiva y el itinerario básico y queda con resistencia 45
   * Rodri hace el itinerario más intenso entre una salida de amigos, la mezcla explosiva y el itinerario básico y queda con un amigo: Roberto Carlos


### Punto 6
   * Roberto Carlos se hace amigo de Ana, toma una jarra popular de espirituosidad 0, sigue quedando con una sola amiga (Ana)
   * Roberto Carlos se hace amigo de Ana, toma una jarra popular de espirituosidad 3, queda con 3 amigos (Ana, Marcos y Rodri)
   * Cristian se hace amigo de Ana. Roberto Carlos se hace amigo de Cristian, toma una jarra popular de espirituosidad 4, queda con 4 amigos (Cristian, Ana, Marcos y Rodri)
