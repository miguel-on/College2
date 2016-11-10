#include <stdio.h>
#include <math.h>
#define DIM 8
/*******************************************************************************************************/
void ordenar (int NumNodos, float YO[DIM][1], float alfa[1] ){
	
	int j = 0,k;
	float distancia[NumNodos];
	int pos[NumNodos];
	float AUXYO[DIM][1];
	int min;
	float aux,auy ;
	/*que pasa */
	printf("Coordenadas que pasan al ordenar");
	for (j=0; j< NumNodos; j++)
		printf (" [%f, %f] ",YO[j][0], YO[j][1]);
	printf ("\n");
	/*Calculamos la distacia de los nodos al punto alfa*/
	for (j=0; j< NumNodos; j++){
		printf ("\n\t Cordenada[%f, %f] ",YO[j][0], YO[j][1]);
		printf ("\n\t Alfa[%f, %f] ",alfa[0], alfa[1]);
		aux = YO[j][0] - alfa[0];
		auy = YO[j][1] - alfa[1];
		printf ("La distancia del nodo %d es de x =%f y= %f ", j , aux, auy);
		distancia[j] = (aux*aux) + (auy*auy);
		printf ("\ndistancias [%d] .- %f\n",j,distancia[j]);

	}	
	//* ordenamos el vector. de menor a mayor distancia a la del punto alfa*//
	
	for (j = 0 ; j< NumNodos; j++){
		min = j;
		for (k = 0; k< NumNodos; k++){
			if ((distancia[k] < distancia[min])&&(distancia[k] != 0)){//si la distancia que vemos en el momento actual es menor
																		//que la que teniamos antes y la distancia no es cero osea ya analizada. 
																		//Esta es la mejor.
					min= k;
					printf ("Nuevo minimo es %d\n",min);
			}
			
		}	
		pos[j] = min;//cojemos el punto que tenga la distancia mas corta y lo ponemos en el vector de posiciones
		distancia[min] = 0;//machacamos el valor de la distancia para no comparar otra vez.
		printf ("Pos[%d].- %d\n",j,pos[j]);
	
	}
}

/*******************************************************************************************************/

/*******************************************************************************************************/

/*******************************************************************************************************/

/*******************************************************************************************************/

int main (void){
	
	float alfa[1];
	int NumNodos = 0;
	int i ;
	float Nodos[DIM];
	float YO[DIM][1];

	do{
		system("clear");
		printf ("\nCuantos nodos quiere introducir\n\t\t (recuerde el numero tiene que ser inferior a 8)\n");
		scanf ("%d", &NumNodos );
	}while ((DIM>NumNodos)&&(NumNodos < 1)); 
	
	for ( i = 0 ; i<NumNodos;i++){
		printf ("\nIntroduzca el Valor del nodo %d\t",i);
		scanf ("%f",&Nodos[i]);

	}
	printf("\n");
	/*for ( i = 0 ; i<NumNodos;i++){
		printf ("\nNodo [%d]\t%f",i,Nodos[i]);// *Provar que se introducen los datos correctamente. 
	}*/
	//ordenadas.
	for ( i = 0 ; i<NumNodos;i++){
		printf ("\nIntroduzca el Valor de la ordenada %d\t",i);
		scanf ("%f",&YO[i][0]);
		scanf ("%f",&YO[i][1]);
		printf ("\n\t Cordenada[%f, %f] ",YO[i][0], YO[i][1]);
	}
	printf ("\n");
	
	printf ("Introduzca el valor del punto Alfa \t");
	scanf ("%f",&alfa[0]);	
	scanf ("%f",&alfa[1]);	
//	printf ("\n\t Alfa[%f, %f] ",alfa[0], alfa[1]);
	printf ("\n----------------------------------------------------------------------------------\n");
	/*************Introduccion de datos.**********/

	printf("Coordenadas antes del ordenar");
	for (i=0; i< NumNodos; i++)
		printf (" [%f, %f] ",YO[i][0], YO[i][1]);
	printf("\n");
	ordenar (NumNodos, YO, alfa);
}

