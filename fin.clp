;Es = k el fichero ascensor11.clp pero con los comandos especiales para k el
;ascensor se mueva;
;
;Funciona bastante bien con 2 ascensores ante pulsaciones externas e internas
;añadido la consideracion de la mejor eleccion del ascensor a mover segun a k 
;distancia se encuentren
;
;
;indicar k se mueva a planta 0 si no esta ahí
(deffacts inicio 
	(inicio) 
	(puerta b cerrada)
	(puerta a cerrada)
	;(parado b 0)
	;(parado a 0)
	(posicion b 0)
	(posicion a 0)
	;(pulsado a 1) ;prueba*****	
	;(pulsado 2 subir)
	;(pulsado 3 bajar)
	;(pulsado 1 bajar)
	)

;*****************************************************
;Controlar peticiones del exterior al subir
(defrule rule0
?pos<-(posicion ?asc ?planta_now)
(or 
   (test(> ?planta_now 3))
   (test(< ?planta_now 0)))
=>
(printout t "regla0...ERROR.El ascensor ha salido por encima de la azotea o por debajo del sotano" crlf)
(retract ?pos)
(assert (ERROR))
)

;*****************************************************
;Controlar peticiones del exterior al subir
(defrule rule7
(declare (salience 15))
?ini<-(inicio)
=>
(retract ?ini)
(printout t "regla 7.INICIALIACION" crlf)
(envia-mensaje (format nil "mover a 0")) 
(envia-mensaje (format nil "mover b 0")) 
(envia-mensaje (format nil "puerta a cerrar"))
(envia-mensaje (format nil "puerta b cerrar"))
)
;*****************************************************
;REGLA 1
;
;Abrir puerta en planta x si el ascensor esta ahi y se 
;pulsa el boton exterior (pulsado 1 subir) o el del 
;interior  (pulsado a 1)
;NO lo hace del todo bien(ARREGLAR)
(defrule rule1  
;(declare (salience 6))
(or (posicion ?asc ?planta_now) (parado ?asc ?planta_now))
?puerta<-(puerta ?asc cerrada)
						;Controla tanto si la pulsacion es externa o interna
?pulsar<-(pulsado ?asc|?planta_now subir|bajar|?planta_now)  
=>
(printout t "regla1...Abrir puerta en misma planta" crlf)
(retract ?puerta ?pulsar)
;wait 5 seconds for the people...  
(printout t "	** Puerta abierta durante 5 segundos **" crlf)
(assert (puerta ?asc cerrar))
;(printout t "Escriba (pulsado nº_planta subir): " crlf)
;(assert-string (readline))
)

;*****************************************************
;REGLA 11
;
;El ascensor ha llegado a una planta que pulsó boton
(defrule rule11
(declare (salience 5))
(posicion ?asc ?planta_now)
?mov<-(mover ?asc ?planta_now)  
?puerta<-(puerta ?asc cerrada)
						;Controla tanto si la pulsacion es externa o interna
?pulsar<-(pulsado ?asc|?planta_now subir|bajar|?planta_now)  
=>
(printout t "regla11...Se ha llegado a una planta k pulso boton" crlf)
(retract ?mov ?puerta ?pulsar)
;wait 5 seconds for the people...  
;(envia-mensaje (format nil "puerta %s abrir" ?asc)) ;OJO.Añadira una serto de puerta abierta
(format t "(envia-mensaje 'puerta %s abrir)'%n" ?asc)  
(envia-mensaje (format nil "puerta %s cerrar" ?asc)) 
(format t "(envia-mensaje 'puerta %s cerrar)'%n" ?asc)
(assert (puerta ?asc cerrada)) 
)

;*****************************************************
;REGLA 12
;
;Recoger a una persona por el camino si debe recogerla
(defrule rule12
(posicion ?asc ?planta_now)
(mover ?asc ?planta_mov) 
?pulsar<-(pulsado ?planta_now ?sentido) 
(pulsado ?planta_mov ?sentido)
?puerta<-(puerta ?asc cerrada)
=>
(printout t "regla12...Recogemos por el camino a otro pasajero" crlf)
(retract ?puerta ?pulsar)
;wait 5 seconds for the people...  

;(envia-mensaje (format nil "puerta %s abrir" ?asc)) 
(format t "(envia-mensaje 'puerta %s abrir)'%n" ?asc) 
(envia-mensaje (format nil "puerta %s cerrar" ?asc)) 
(format t "(envia-mensaje 'puerta %s cerrar)'%n" ?asc) 
(assert (puerta ?asc cerrada)) 
)

;*****************************************************
;REGLA 2
;
;Actuar ante un pulsado externo para subir
;a planta y desde x
(defrule rule2 
(posicion ?asc ?planta_now)    
?pulsar<-(pulsado ?planta_mov ?sentido) 
(or (test (eq ?sentido subir)) (test (eq ?planta_mov 3)))      ;De esta manera no coje la otra version del pulsado interno
(test (< ?planta_now ?planta_mov))

(not (subiendo ?otro_asc&:(neq ?otro_asc ?asc))) 		;no hay otro subiendo
(not (bajando ?asc))         							;yo no estoy bajando

(posicion ?otro_asc ?planta_otro)
(test (<= 
			(abs (- ?planta_mov ?planta_now)) 
			(abs (- ?planta_mov ?planta_otro)) 
))
=>
(printout t "regla2...(pulsado exterior)Subir a planta " ?planta_mov crlf)
(assert (mover ?asc ?planta_mov))
(envia-mensaje (format nil "puerta %s cerrar" ?asc)) 
(format t "(envia-mensaje 'puerta %s cerrar)'%n" ?asc) 
(assert (puerta ?asc cerrada)) 
)

;*****************************************************
;REGLA 21
;
;Actuar ante un pulsado interno (pulsado a 1) para subir
(defrule rule21  
?pos<-(posicion ?asc ?planta_now)
?pulsar<-(pulsado ?asc ?planta_mov&:(< ?planta_now ?planta_mov)) ;pulsado dentro del ascensor
(not (bajando ?asc))         ;yo no estoy bajando
=>
(printout t "regla21...(pulsado interior) Subir a planta " ?planta_mov crlf)
(assert (mover ?asc ?planta_mov))
)

;*****************************************************
;REGLA 22
;
;Actuar ante un pulsado externo para bajar
;a planta y desde x
(defrule rule22  
(posicion ?asc ?planta_now)    
?pulsar<-(pulsado ?planta_mov bajar)
(not (subiendo ?asc))         						;yo no estoy subiendo
(not (bajando ?otro_asc&:(neq ?asc ?otro_asc)))   	;otro no esta bajando

(posicion ?otro_asc ?planta_otro)
(test (<= 
			(abs (- ?planta_mov ?planta_now)) 
			(abs (- ?planta_mov ?planta_otro)) 
))
=>
(printout t "regla22...(pulsado exterior)Bajar a planta " ?planta_mov crlf)
(assert (mover ?asc ?planta_mov))
(envia-mensaje (format nil "puerta %s cerrar" ?asc)) 
(format t "(envia-mensaje 'puerta %s cerrar)'%n" ?asc) 
(assert (puerta ?asc cerrada)) 
)

;*****************************************************
;REGLA 23
;
;Actuar ante un pulsado interno (pulsado a 1) para bajar
(defrule rule23  
?pos<-(posicion ?asc ?planta_now)
?pulsar<-(pulsado ?asc ?planta_mov&:(> ?planta_now ?planta_mov)) ;pulsado dentro del ascensor
(not (subiendo ?asc))         ;yo no estoy subiendo
=>
(printout t "regla23...(pulsado interior) Bajar a planta " ?planta_mov crlf)
(assert (mover ?asc ?planta_mov))
)

;*****************************************************
;Actualizar posicion del ascensor si no ha llegado a 
;donde debe (si esta subiendo)
(defrule rule3 
;(declare (salience 10));Es necesario + prioridad k regla 2 y 22
?pos<-(posicion ?asc ?planta_now)
(mover ?asc ?planta_mov)
(test (< ?planta_now ?planta_mov))
(test (< ?planta_now 3))
;(parado ?asc ?planta_now)
=>
(printout t "regla3...Aumentar posicion actual del ascensor" crlf)
(retract ?pos)
(assert	(subiendo ?asc))
(assert (posicion ?asc (+ ?planta_now 1)))
(envia-mensaje (format nil "mover %s %d" ?asc (+ ?planta_now 1))) 
(format t "(envia-mensaje 'mover %s %d)'%n" ?asc (+ ?planta_now 1)) 
)

;*****************************************************
;Actualizar posicion del ascensor si no ha llegado a 
;donde debe (si esta bajando)
(defrule rule31 
;(declare (salience 10));Es necesario + prioridad k regla 2 y 22
?pos<-(posicion ?asc ?planta_now)
(mover ?asc ?planta_mov)
(test (> ?planta_now ?planta_mov))
(test (> ?planta_now 0))
;(parado ?asc ?planta_now)
=>
(printout t "regla31...Disminuir posicion actual del ascensor" crlf)
(retract ?pos)
(assert	(bajando ?asc))
(assert (posicion ?asc (- ?planta_now 1)))
(envia-mensaje (format nil "mover %s %d" ?asc (- ?planta_now 1))) 
(format t "(envia-mensaje 'mover %s %d)'%n" ?asc (- ?planta_now 1)) 
)

;*****************************************************
;No hay mas movimientos que hacer => el ascensor esta parado
;En la simulacion hace falta pero con el ascensor de verdad NO CREO k haga falta
;(defrule rule4
;(not(mover ?asc ?planta_mov))
;(posicion ?asc ?planta_now)
;=>
;(printout t "regla4...Ascensor parado" crlf)
;(assert (parado ?asc ?planta_now)))

;*****************************************************
;Si ascensor en movimiento => quitar como parado
(defrule rule41
(declare (salience 10))
(posicion ?asc ?planta_now)
