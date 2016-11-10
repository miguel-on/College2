:-dynamic(ce/2).
ce(3,3).
ce(4,3).
ce(4,4).
ce(4,5).
ce(3,5).
:-dynamic(muerta/2).
:-dynamic(nace/2).
:-dynamic(generacion/2).
/*************************************************************************************************************/

vecino(F,C,Valor):-ce(F,C),
						Valor = 1.
vecino(F,C,Valor):-not(ce(F,C)),
						Valor = 0. 
nu_vecinos(F,C,Ac):- /*ce(F,C),*/
						AxC is C + 1,
						AxF is F + 1,
						vecino(AxF,AxC,V1),

						vecino(AxF,C,V2),

						vecino(F,AxC,V3),
					
						/********************************/
						AxC1 is C - 1,
						vecino(AxF,AxC1,V4),

						vecino(F,AxC1,V5),
						
						/********************************/
						AxF1 is F - 1,
						vecino(AxF1,AxC1,V6),

						vecino(AxF1,C,V7),
						/********************************/
						/*AxC is C + 1,*/
						vecino(AxF1,AxC,V8),

						Aux is V1 + V2 + V3 + V4 + V5 + V6 + V7 + V8,
						Ac is Aux.
/*************************************************************************************************************/


tipo(X,Y,A):-A<2,
	/*			write('La celula '),write(X),write(', '),write(Y),write(' esta muerta por aislamiento').*/
				assert(muerta(X,Y)).
tipo(X,Y,A):-A>3,
         	/*write('La celula '),write(X),write(', '),write(Y),write(' esta muerta por superpoblacion').*/
				assert(muerta(X,Y)).
tipo(X,Y,A):-A=2.
         	/*write('La celula '),write(X),write(', '),write(Y),write(' sobrevive').*/
tipo(X,Y,A).
/*************************************************************************************************************/

tipo1(X,Y,A):-A=3,
				not(ce(X,Y)),
				assert(nace(X,Y)),
         	write('La celula '),write(X),write(', '),write(Y),write(' nace'),nl.
tipo1(X,Y,A).
/*************************************************************************************************************/
recorrecolumna(Fil,Col,Dim):-Col = Dim.
recorrecolumna(Fil,Col,Dim):-Col < Dim,
										/*accion(Fil,Col),*/ /*Casilla visitada actualmente*/
         							/*write('Recorre Columna en [ '),write(Fil),write(', '),write(Col),write(' ]'),nl,*/
										nu_vecinos(Fil,Col,Num),
         							/*write('Numero de vecions de [ '),write(Fil),write(', '),write(Col),write(' ]'),write(' es '),write(Num),nl,*/
										tipo1(Fil,Col,Num),
										Ac is Col+1,
         							/*write('La celula ['),write(Fil),write(', '),write(Col),write('] Visitada'),nl,*/

										recorrecolumna(Fil,Ac,Dim).

/*************************************************************************************************************/
recorrefila(Fil,Dim):-Fil = Dim.										
recorrefila(Fil,Dim):-Fil < Dim,
         						/*write('Recorre fila en [ '),write(Fil),write(', '),write(Col),write(' ]'),nl,*/
									Ac is Fil+1,
									recorrecolumna(Fil,1,Dim),
									recorrefila(Ac,Dim). /*col en este procedimiento no se usaaria*/			
/*************************************************************************************************************/
imprimecolumna(Fil,Col,Dim):-Col = Dim.
imprimecolumna(Fil,Col,Dim):-Col < Dim,
										Ac is Col+1,
										not(ce(Fil,Col)),
										write('   '),
										imprimecolumna(Fil,Ac,Dim).
imprimecolumna(Fil,Col,Dim):-Col < Dim,
										Ac is Col+1,
										ce(Fil,Col),
										write(' X '),
										imprimecolumna(Fil,Ac,Dim).

/*************************************************************************************************************/
imprimefila(Fil,Dim):-Fil = Dim.										
imprimefila(Fil,Dim):-Fil < Dim,
         						/*write('Recorre fila en [ '),write(Fil),write(', '),write(Col),write(' ]'),nl,*/
									write('|'),
									Ac is Fil+1,
									imprimecolumna(Fil,1,Dim),
									write('|'),nl,
									imprimefila(Ac,Dim). /*col en este procedimiento no se usaaria*/			
/*************************************************************************************************************/
/* 
guarge(Ge):-findall(ce(X,Y), ce(X,Y), L),
         assert(generacion(Ge,L)).

generar(Ge):-findall(ce(X,Y), ce(X,Y), L),
assert(generacion(Ge,L)).
*/
llama([]).
llama([ce(X,Y)|T]):-nu_vecinos(X,Y,A),
						tipo(X,Y,A),
			/*			write('ESTAMOS EN LLAMA 1  '),write(A),nl,*/
						llama(T). 
/*************************************************************************************************************/
llama1([]):-write('lista vacia de llama1').
llama1([[X,Y]|T]):-nu_vecinos(X,Y,A),
						tipo1(X,Y,A),
						/*write('ESTAMOS EN LLAMA1 '),nl,*/
						llama1(T). 
/*************************************************************************************************************/
dimension(D):-write('Introduzca la dimension'),
                  read(D),nl.

/*************************************************************************************************************/
maximo(M):-write('Introduzca el numero de generaciones que quiere generar'),
                  read(M),nl.
/*************************************************************************************************************/
condicion(X,Y,Dim):-not(ce(X,Y)),
					X>0,
					X<Dim,
					Y>0,
					Y<Dim.
/*condicion(X):- X>0,X<10.*/
/*************************************************************************************************************/
lista1(L1,Dim):-findall([X,Y], condicion(X,Y,Dim),L1).

lista(L):-findall(ce(X,Y), ce(X,Y),L).
/*************************************************************************************************************/
elimina([]).
elimina([[X,Y]|T]):-muerta(X,Y),
						retract(muerta(X,Y)),
						retract(ce(X,Y)),
						elimina(T).
/*************************************************************************************************************/
crea([]).
crea([[X,Y]|T]):-nace(X,Y),
						retract(nace(X,Y)),
						assert(ce(X,Y)),
						elimina(T).

/*************************************************************************************************************/
quitar:-findall([X,Y],muerta(X,Y),LM),
			elimina(LM),
			findall([X,Y],nace(X,Y),LN),
			crea(LN).
/*************************************************************************************************************/
primero([],[]):-write('La generacion actual es igual a la primera'),nl,write('Fin'),nl.
primero([L1|T1],[L2|T2]):- L1 = L2,
								primero(T1,T2). 
/*************************************************************************************************************/
anterior([],[]):-write('La generacion actual es igual a dos generaciones anteriores'),nl,write('Fin'),nl.
anterior([L1|T1],[L2|T2]):- L1 = L2,
								anterior(T1,T2). 
/*************************************************************************************************************/
algo(M,Dim,M):-write('Se alcanzado el limite de generaciones prefijado'),nl,write('Fin'),nl.
algo(Ge,Dim,M):-generacion(Ge,L2),
						Aus is Ge -2,
						generacion(Aus,L3),
						anterior(L2,L3).
algo(Ge,Dim,M):-generacion(Ge,L2),
						generacion(0,L1),
						primero(L1,L2).
algo(Ge,Dim,M):-Aux is Ge+1,
					write('GENERACION ACTUAL '),write(Aux),nl,nl,nl,
			      /*lista1(L1,Dim),
					llama1(L1),*/ /*buscamos a los que nacen*/
					/*write('El valor de M es '),write(M),nl,*/
			
					/*write('creamos la lista de los que existen'),*/
					lista(L),
					asserta(generacion(Ge,L)),
					/*write('creamos la lista de los que mueren'),*/
					llama(L), 				/*Busca los que mueren*/
					recorrefila(1,Dim), 	/*Buscamos las que nacen*/
					quitar,
					imprimefila(1,Dim),
					nl,nl,nl,
					algo(Aux,Dim,M).
/*************************************************************************************************************/

vida:-maximo(M),
		dimension(Dim),
 		write('El valor de M es '),write(M),nl,
		write('El valor de DIM es '),write(Dim),nl,
		algo(0,Dim,M).
