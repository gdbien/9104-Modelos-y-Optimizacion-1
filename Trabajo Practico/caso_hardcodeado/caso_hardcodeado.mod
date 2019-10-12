/*********************************************
 * OPL 12.9.0.0 Model
 * Author: Franc
 * Creation Date: 11 oct. 2019 at 15:09:56
 *********************************************/

// Nodo = pasada

int M = 9999999;
float m = 0.001;
int cajasA = 10;
int cajasB = 20;
int cajasC = 5;

 dvar int Xpasada0;
 dvar int Xpasada1;
 dvar int Xpasada2;
 dvar int Xpasada3;
 dvar int Xpasada4;
 dvar int Xpasada5;
 dvar int Xpasada6;
 
 dvar boolean Mpasada0;
 dvar boolean Mpasada1;
 dvar boolean Mpasada2;
 dvar boolean Mpasada3;
 dvar boolean Mpasada4;
 dvar boolean Mpasada5;
 dvar boolean Mpasada6;
 
 dvar boolean EcodApasada0;
 dvar boolean EcodApasada1;
 dvar boolean EcodApasada2;
 dvar boolean EcodApasada3;
 dvar boolean EcodApasada4;
 dvar boolean EcodApasada5;
 dvar boolean EcodApasada6;
 
 dvar boolean EcodBpasada0;
 dvar boolean EcodBpasada1;
 dvar boolean EcodBpasada2;
 dvar boolean EcodBpasada3;
 dvar boolean EcodBpasada4;
 dvar boolean EcodBpasada5;
 dvar boolean EcodBpasada6;
 
 dvar boolean EcodCpasada0;
 dvar boolean EcodCpasada1;
 dvar boolean EcodCpasada2;
 dvar boolean EcodCpasada3;
 dvar boolean EcodCpasada4;
 dvar boolean EcodCpasada5;
 dvar boolean EcodCpasada6;
 
 dvar boolean Zeropasada0; // 0 si Xpasada 0 es 0; 1 sino
 dvar boolean Zeropasada1; // 0 si Xpasada 0 es 0; 1 sino
 dvar boolean Zeropasada2; // 0 si Xpasada 0 es 0; 1 sino

 
minimize
   cajasA*(EcodApasada0+EcodApasada1+EcodApasada2+EcodApasada3+EcodApasada4+EcodApasada5+EcodApasada6 - 1) +
   cajasB*(EcodBpasada0+EcodBpasada1+EcodBpasada2+EcodBpasada3+EcodBpasada4+EcodBpasada5+EcodBpasada6 - 1) +
   cajasC*(EcodCpasada0+EcodCpasada1+EcodCpasada2+EcodCpasada3+EcodCpasada4+EcodCpasada5+EcodCpasada6 - 1);

subject to
{

// Relacion Xpasada e Mpasada

// |Xpasada|Mpasada|
// |-------|-------|
// |   0   |   1   |
// |   1   |   0   |
// |   >1  |   1   |
// |---------------|

// para lograr esto se usa Zeropasada
// |Xpasada|Zeropasada|
// |-------|----------|
// |   0   |   0      |
// |   >0  |   1      |
// |------------------|

// para pasada 0
	Zeropasada0 <= Xpasada0;
	m * Xpasada0 <= Zeropasada0;

	-M * (1 - Zeropasada0) + Mpasada0 <= Xpasada0 -1;
	m * (Xpasada0 - 1) <= Mpasada0 + M * (1 - Zeropasada0);
	1 - 2 * Zeropasada0 <= Mpasada0;
// para pasada 1
	Zeropasada1 <= Xpasada1;
	m * Xpasada1 <= Zeropasada1;

	-M * (1 - Zeropasada1) + Mpasada1 <= Xpasada1 -1;
	m * (Xpasada1 - 1) <= Mpasada1 + M * (1 - Zeropasada1);
	1 - 2 * Zeropasada1 <= Mpasada1;
// para pasada 2
	Zeropasada2 <= Xpasada2;
	m * Xpasada2 <= Zeropasada2;

	-M * (1 - Zeropasada2) + Mpasada2 <= Xpasada2 -1;
	m * (Xpasada2 - 1) <= Mpasada2 + M * (1 - Zeropasada2);
	1 - 2 * Zeropasada2 <= Mpasada2;


// Restriccion 1
// para nodo 0 (hijos 1 y 2)
	Xpasada1 + Xpasada2 <= Mpasada0 * M;
	Xpasada0 - M * (1 - Mpasada0) <= Xpasada1 + Xpasada2;
	Xpasada1 + Xpasada2 <= Xpasada0 + (1 - Mpasada0) * M;
// para nodo 1 (hijos 3 y 4)
	Xpasada3 + Xpasada4 <= Mpasada1 * M;
	Xpasada1 - M * (1 - Mpasada1) <= Xpasada3 + Xpasada4;
	Xpasada3 + Xpasada4 <= Xpasada1 + (1 - Mpasada1) * M;
//para nodo 2 (hijos 5 y 6)
	Xpasada5 + Xpasada6 <= Mpasada2 * M;
	Xpasada2 - M * (1 - Mpasada2) <= Xpasada5 + Xpasada6;
	Xpasada5 + Xpasada6 <= Xpasada2 + (1 - Mpasada2) * M;

// Restriccion 2
	EcodApasada0 == 1;
	EcodBpasada0 == 1;
	EcodCpasada0 == 1;
	
// Restriccion 3
	EcodApasada0 + EcodBpasada0 + EcodCpasada0 == Xpasada0;
	EcodApasada1 + EcodBpasada1 + EcodCpasada1 == Xpasada1;
	EcodApasada2 + EcodBpasada2 + EcodCpasada2 == Xpasada2;
	EcodApasada3 + EcodBpasada3 + EcodCpasada3 == Xpasada3;
	EcodApasada4 + EcodBpasada4 + EcodCpasada4 == Xpasada4;
	EcodApasada5 + EcodBpasada5 + EcodCpasada5 == Xpasada5;
	EcodApasada6 + EcodBpasada6 + EcodCpasada6 == Xpasada6;
	
// Restriccion 4
// para nodo 0 (hijos 1 y 2)
	// codA
		EcodApasada1 + EcodApasada2 <= Mpasada0 * M;
		EcodApasada0 - M * (1 - Mpasada0) <= EcodApasada1 + EcodApasada2;
		EcodApasada1 + EcodApasada2 <= EcodApasada0 + (1 - Mpasada0) * M;
	// codB
		EcodBpasada1 + EcodBpasada2 <= Mpasada0 * M;
		EcodBpasada0 - M * (1 - Mpasada0) <= EcodBpasada1 + EcodBpasada2;
		EcodBpasada1 + EcodBpasada2 <= EcodBpasada0 + (1 - Mpasada0) * M;
	// codC
		EcodCpasada1 + EcodCpasada2 <= Mpasada0 * M;
		EcodCpasada0 - M * (1 - Mpasada0) <= EcodCpasada1 + EcodCpasada2;
		EcodCpasada1 + EcodCpasada2 <= EcodCpasada0 + (1 - Mpasada0) * M;
// para nodo 1 (hijos 3 y 4)
	// codA
		EcodApasada3 + EcodApasada4 <= Mpasada1 * M;
		EcodApasada1 - M * (1 - Mpasada1) <= EcodApasada3 + EcodApasada4;
		EcodApasada3 + EcodApasada4 <= EcodApasada1 + (1 - Mpasada1) * M;
	// codB
		EcodBpasada3 + EcodBpasada4 <= Mpasada1 * M;
		EcodBpasada1 - M * (1 - Mpasada1) <= EcodBpasada3 + EcodBpasada4;
		EcodBpasada3 + EcodBpasada4 <= EcodBpasada1 + (1 - Mpasada1) * M;
	// codC
		EcodCpasada3 + EcodCpasada4 <= Mpasada1 * M;
		EcodCpasada1 - M * (1 - Mpasada1) <= EcodCpasada3 + EcodCpasada4;
		EcodCpasada3 + EcodCpasada4 <= EcodCpasada1 + (1 - Mpasada1) * M;
// para nodo 2 (hijos 5 y 6)
	// codA
		EcodApasada5 + EcodApasada6 <= Mpasada2 * M;
		EcodApasada2 - M * (1 - Mpasada2) <= EcodApasada5 + EcodApasada6;
		EcodApasada5 + EcodApasada6 <= EcodApasada2 + (1 - Mpasada2) * M;
	// codB
		EcodBpasada5 + EcodBpasada6 <= Mpasada2 * M;
		EcodBpasada2 - M * (1 - Mpasada2) <= EcodBpasada5 + EcodBpasada6;
		EcodBpasada5 + EcodBpasada6 <= EcodBpasada2 + (1 - Mpasada2) * M;
	// codC
		EcodCpasada5 + EcodCpasada6 <= Mpasada2 * M;
		EcodCpasada2 - M * (1 - Mpasada2) <= EcodCpasada5 + EcodCpasada6;
		EcodCpasada5 + EcodCpasada6 <= EcodCpasada2 + (1 - Mpasada2) * M;

// Restriccion 5
// para nodo 3
	Xpasada3 <= 1;
// para nodo 4
	Xpasada4 <= 1;
// para nodo 5
	Xpasada5 <= 1;
// para nodo 6
	Xpasada6 <= 1;
}