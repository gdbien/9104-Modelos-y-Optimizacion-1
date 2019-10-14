/*********************************************
 * OPL 12.9.0.0 Model
 * Author: Franc
 * Creation Date: 10 oct. 2019 at 16:00:07
 *********************************************/
 
//Datos de entrada
{string} COD_POST = ...;
int CAJAS[COD_POST] = ...;
int DESTINOS_POR_PASADA = ...;
int TIEMPO_PROC_CAJA = ...;

//Variables ctes
int M = 9999999;
float m = 0.001;

int DPP = DESTINOS_POR_PASADA;
//Para la sumatoria y obtener la cantidad de nodos totales
int cantCodPost = card(COD_POST);
float aux1 = (cantCodPost-1);
float aux2 = (DPP-1);
float aux3 = ceil(aux1/aux2);
int finSum = ftoi(aux3);
range S = 1..finSum;
//La sumatoria propiamente dicha
float aux4 = sum(s in S) pow(DPP,s);
int cantTotNodos = ftoi(aux4)+1;

range rangoPasadas = 0..cantTotNodos-1;

//Como no sé extraer de la fórmula los nodos de la última pasada, uso una cuenta auxiliar
float aux5 = (((DPP - 1) * cantTotNodos) + 1)/ DPP;
int cantNodosUltNivel = ftoi(aux5);

int indIniUltNivelPas = cantTotNodos-cantNodosUltNivel;
range rangoUltNivelPas = indIniUltNivelPas..cantTotNodos-1;

//Para calcular los hijos, siendo ni el indice del nodo y k los dpp, uso:
// (ni*k)+1,......(ni*k)+k
// y para calcular el padre del indice ni:
// floor((ni-1)/k)

range rangoPadres = 0..indIniUltNivelPas-1;


//Variables del problema
dvar int Xpasadas[rangoPasadas];
dvar boolean Mpasadas[rangoPasadas];
dvar boolean Ecodpas[COD_POST][rangoPasadas];
dvar boolean Zeropasadas[rangoPadres];

minimize
  (sum(cod in COD_POST, pas in rangoPasadas) CAJAS[cod] * Ecodpas[cod][pas])-
  (sum(cod in COD_POST) CAJAS[cod]);

subject to {
	forall(pas in rangoPadres) { 
		//Restriccion 0
		Zeropasadas[pas] <= Xpasadas[pas];
		m * Xpasadas[pas] <= Zeropasadas[pas];

		-M * (1 - Zeropasadas[pas]) + Mpasadas[pas] <= Xpasadas[pas] -1;
		m * (Xpasadas[pas] - 1) <= Mpasadas[pas] + M * (1 - Zeropasadas[pas]);
		1 - 2 * Zeropasadas[pas] <= Mpasadas[pas];	
	
		//Restriccion 1
		
		(sum(hijo in (pas*DPP)+1..(pas*DPP)+DPP) Xpasadas[hijo]) <= Mpasadas[pas] * M;
		Xpasadas[pas] - M * (1 - Mpasadas[pas]) <= (sum(hijo in (pas*DPP)+1..(pas*DPP)+DPP) Xpasadas[hijo]);
		(sum(hijo in (pas*DPP)+1..(pas*DPP)+DPP) Xpasadas[hijo]) <= Xpasadas[pas] + (1 - Mpasadas[pas]) * M;	
	}
	
	forall(cod in COD_POST) {
		Restriccion2: Ecodpas[cod][0] == 1;
	}
	
	forall(pas in rangoPasadas) {
		Restriccion3: (sum(cod in COD_POST) Ecodpas[cod][pas]) == Xpasadas[pas];
	}
	
	//Restriccion 4
	forall(pas in rangoPadres) {
		forall(cod in COD_POST) {		
			(sum(hijo in (pas*DPP)+1..(pas*DPP)+DPP) Ecodpas[cod][hijo]) <= Mpasadas[pas] * M;
			Ecodpas[cod][pas] - M * (1 - Mpasadas[pas]) <= (sum(hijo in (pas*DPP)+1..(pas*DPP)+DPP) Ecodpas[cod][hijo]);
			(sum(hijo in (pas*DPP)+1..(pas*DPP)+DPP) Ecodpas[cod][hijo]) <= Ecodpas[cod][pas] + (1 - Mpasadas[pas]) * M;		
		}
	}
	
	forall(pas in rangoUltNivelPas) {
		Restriccion5: Xpasadas[pas] <= 1;	
	}
	
	forall(pas in 1..cantTotNodos-2) {
		if (floor((pas-1)/DPP) == floor((pas)/DPP)) { //Esto es si tienen el mismo padre
			Restriccion6: Xpasadas[pas] <= Xpasadas[pas+1];		
		}
	}	
}
