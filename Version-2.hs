import Text.Show.Functions
import Data.List

data Cliente = UnCliente {nombre :: String, resistencia :: Int , amigos :: [Cliente], bebidas:: [Bebida]} deriving (Show)
type Bebida = Cliente-> Cliente

--Punto 1A

rodri = UnCliente "Rodri" 55 [] [tintico]
marcos = UnCliente "Marcos" 40 [rodri] [(klusener "guinda")]
cristian = UnCliente "Cristian" 2 [] [grogXD, jarraLoca]
ana = UnCliente "Ana"  120 [marcos, rodri] []

modificarResistencia :: Int -> Cliente -> Cliente
modificarResistencia resistenciaABajar cliente = cliente {resistencia = (resistencia cliente) - resistenciaABajar}

grogXD cliente = modificarResistencia (resistencia cliente) cliente 
jarraLoca cliente = modificarResistencia 10 (cliente {amigos = (map (modificarResistencia 10) (amigos cliente))}) 
klusener palabra = modificarResistencia (length palabra)
tintico cliente = modificarResistencia (-(((*5).length) (amigos cliente))) cliente 
soda fuerza cliente = cliente {nombre = ("e"++(replicate fuerza 'r')++"p"++(nombre cliente))}

--Punto 1B
tomarBebida :: (Cliente -> Cliente) -> Cliente -> Cliente
tomarBebida bebida cliente = (bebida cliente){bebidas = (bebidas cliente)++[bebida]}
--Marcos toma una soda de nivel 3, queda con 2 bebidas y 40 de resistencia  -> tomarBebida marcos (flip soda 3)

--Punto 1C
tomarTragos :: Cliente -> [Bebida] -> Cliente
tomarTragos cliente listaDeTragos = foldl (\semilla elemLista -> tomarBebida elemLista semilla) cliente listaDeTragos

--Rodri toma una soda de nivel 1 y una soda de nivel 2 y queda con nombre errperpRodri -> (tomarBebida (tomarBebida rodri (ponerFuerza soda 1))(ponerFuerza soda 2))
{-Marcos toma un klusener de huevo, un tintico y una jarraLoca , queda con 30 de resistencia y queda con 4 bebidas en el historial
-> (tomarBebida (tomarBebida (tomarBebida marcos (flip klusener "huevo")) tintico) jarraLoca)     -}

--Punto 1D
dameOtro :: Cliente -> Cliente
dameOtro cliente = tomarBebida (last (bebidas cliente)) cliente

--Ana pide “dame otro” y debe dar error -> dameOtro ana
--Marcos pide “dame otro” y tiene 2 bebidas en el historial y 34 de resistencia-> dameOtro marcos

{-Rodri toma una soda de nivel 1, y "dameOtro" da como resultado que tiene 3
bebidas y su nombre queda “erperpRodri” -> dameOtro (tomarBebida rodri (flip soda 1))   -}

--Punto 2A
bebidaQueDejaLaResistenciaMayorA0 :: Bebida -> Cliente ->  Bool
bebidaQueDejaLaResistenciaMayorA0 bebida =(>0).resistencia.tomarBebida bebida
cualesPuedeTomar :: Cliente -> [Bebida] -> [Bebida]
cualesPuedeTomar cliente listaDeTragos = filter (flip bebidaQueDejaLaResistenciaMayorA0 cliente) listaDeTragos

--Punto 2B
cuantasPuedeTomar :: Cliente -> [Bebida] -> Int
cuantasPuedeTomar cliente = length.cualesPuedeTomar cliente

--Rodri puede tomar dos bebidas, entre un grog XD, un tintico y un klusener de frutilla -> cuantasPuedeTomar rodri [grogXD, tintico, flip klusener "frutilla"]
{-   Entre un grog XD, un tintico, un klusener de "fruuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuutilla" se puede tomar una sola bebida 
-> cuantasPuedeTomar rodri [grogXD, tintico, flip klusener "fruuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuutilla"]      -}

--Punto 3A
data Itinerario = UnItinerario {nombreDelItinerario :: String, duracionEstimada :: Float, acciones :: [ElClienteHaceAlgo]} deriving (Show)
type ElClienteHaceAlgo = (Cliente -> Cliente)
robertoCarlos = UnCliente "Roberto Carlos" 165 [] []
mezclaExplosiva = UnItinerario "Mezcla Explosiva" 2.5 [tomarBebida grogXD, tomarBebida grogXD, tomarBebida (klusener  "huevo"), tomarBebida (klusener "frutilla")]
--Mezcla explosiva, se recomienda para 2.5 horas y consiste en tomarse 2 Grog XD, 1 Klusener de Huevo y otro de Frutilla
itinerarioBasico = UnItinerario "Itinerario Basico" 5 [tomarBebida jarraLoca, tomarBebida (klusener "chocolate"), rescatarse 2, tomarBebida (klusener "huevo")]
--Itinerario básico, es como el del punto 7 de la primera parte(tomarse una jarra loca, un klusener de chocolate, rescatarse 2 horas y luego tomar un klusener de huevo), en 5 horas
salidaDeAmigos = UnItinerario "Salida De Amigos" 1 [tomarBebida (soda 1), tomarBebida tintico, esAmigo robertoCarlos, tomarBebida jarraLoca]
--Salida de amigos, se recomienda para 1 hora, consiste en tomarse una soda de nivel 1, un tintico, hacerse amigo de Roberto Carlos y tomarse una jarra loca.

--Punto 6(TP 1)
rescatarse :: Int -> Cliente -> Cliente
rescatarse tiempo 
   |tiempo > 3 = modificarResistencia (-200)
   |otherwise = modificarResistencia (-100)
--rescatarse 5 rodri -> Rodri se rescata 5 horas, queda con 255 de resistencia		

--Punto 4(TP 1)
esAmigo :: Cliente -> Cliente -> Cliente
esAmigo cliente otroCliente
   | ((nombre cliente) == (nombre otroCliente)) || (any (((==) (nombre otroCliente)).nombre) (amigos cliente)) = cliente
   | otherwise = cliente {amigos = otroCliente:(amigos cliente)}

--Punto 3B
realizarItinerario :: Cliente -> Itinerario ->  Cliente
realizarItinerario cliente itinerario = foldl (flip ($)) cliente (acciones itinerario)

{-     Rodri hace una salida de amigos: debe quedar con un amigo, se debe llamar “erpRodri”, 
debe quedar con 45 de resistencia, su primer y único amigo Roberto Carlos que debe quedar 
con 155 de resistencia y rodri debe quedar con 5 bebidas en su historial
-> realizarItinerario rodri salidaDeAmigos         -}

--Punto 4A
intensidad :: Itinerario -> Float
intensidad itinerario = (genericLength.acciones) itinerario / duracionEstimada itinerario

--la intensidad de la mezcla explosiva es 1.6 -> intensidad mezclaExplosiva
--la intensidad de la salidaDeAmigos es 4.0 -> intensidad salidaDeAmigos
--la intensidad del itinerario basico es 0.8 -> intensidad itinerarioBasico

--Punto 4B
realizarElItinerarioMasIntenso :: Cliente -> [Itinerario] -> Cliente
realizarElItinerarioMasIntenso cliente listaDeItinerarios = realizarItinerario cliente (foldl1 (\semilla elemLista -> quienEsMasIntenso semilla elemLista)  listaDeItinerarios)

quienEsMasIntenso :: Itinerario -> Itinerario -> Itinerario
quienEsMasIntenso itinerario otroItinerario
   |intensidad itinerario < intensidad otroItinerario = otroItinerario
   |otherwise = itinerario
   

{-   Entre la salida de amigos, la mezcla explosiva y el itinerario básico, el
itinerario más intenso es la salida de amigos 
-> foldl1 (\semilla elemLista -> quienEsMasIntenso semilla elemLista)  [salidaDeAmigos, mezclaExplosiva, itinerarioBasico]
  -}
{- Rodri hace el itinerario más intenso entre una salida de amigos, la mezcla
explosiva y el itinerario básico y queda: con el nombre "erpRodri", resistencia 45
 con un amigo: Roberto Carlos -> realizarElItinerarioMasIntenso rodri [salidaDeAmigos, mezclaExplosiva, itinerarioBasico] -}

--Punto 5 
chuckNorris = UnCliente "Chuck" 1000 [] (map soda [1..])

{-
-Justificar: ¿Puede chuckNorris pedir otro trago con la función dameOtro? -> dameOtro chuckNorris
-> chuckNorris no puede aplicarse a la función dameOtro ya que al ser definido como un cliente
 "que toma todas las sodas" en una lista de bebidas infinita, nunca hay una bebida última como para pueda ser tomada por la función

-Justificar: ¿puedo hacer que chuckNorris realice el itinerario básico y conocer
su resistencia resultante?
-> realizarItinerario chuckNorris itinerarioBasico
-> no, porque no termina de procesar todas las bebidas que tomó

-Justificar: ¿puedo preguntar si chuckNorris tiene más resistencia que ana?
-> resistencia chuckNorris > resistencia ana
-> Se puede poner en consola "resistencia chuckNorris > resistencia ana" ya que compara sólo la resistencia de los clientes y no necesita evaluar el resto de los datos de cada cliente
 -}

--punto 6
tomarJarraPopular :: Cliente -> Int -> Cliente
tomarJarraPopular cliente 0 = cliente
tomarJarraPopular cliente espirituosidad = tomarJarraPopular (amigarseDeLosAmigosDeMisAmigos cliente) (espirituosidad-1)
amigarseDeLosAmigosDeMisAmigos :: Cliente -> Cliente
amigarseDeLosAmigosDeMisAmigos cliente = foldl (\semilla elemLista -> foldl (\sem elem -> esAmigo sem elem) semilla (amigos elemLista)) cliente (amigos cliente)

{-Roberto Carlos se hace amigo de Ana, toma una jarra popular de
espirituosidad 0, sigue quedando con una sola amiga (Ana) 
-> tomarJarraPopular (esAmigo robertoCarlos ana) 0
-}
{- Roberto Carlos se hace amigo de Ana, toma una jarra popular de
espirituosidad 3, queda con 3 amigos (Ana, Marcos y Rodri)
-> tomarJarraPopular (esAmigo robertoCarlos ana) 3
-}

{- Cristian se hace amigo de Ana. Roberto Carlos se hace amigo de Cristian,
toma una jarra popular de espirituosidad 4, queda con 4 amigos (Cristian,
Ana, Marcos y Rodri)
-> tomarJarraPopular (esAmigo robertoCarlos (esAmigo cristian ana)) 4
-}
