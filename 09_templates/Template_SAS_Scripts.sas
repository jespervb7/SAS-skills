/* =====================================================================================================
  Programma  : 
  Doel       :  
  Auteur     : Jesper van Beemdelust 
  Creatie    : 
  Databases  : 
  Draaien met: SAS Enterprise Guide 7.1
  Korte naam : 
  Versienr   : 1.0
  Aanvrager  : Rob Schooten
  Parameters : 
  Frequentie : Onbekend
  Invoer     : CSV-bestand
  Uitvoer    : Excel-bestand, CSV-bestand
  Locatie    : \\EUR.TLD\Progdata\ZKA\Operations Support\WLZ\97. Teammap Support\08. Persoonlijk\Jesper van Beemdelust
  Korte beschrijving:

---------------------------------------------------------------------------------------------------------
Wijzigingshistorie:
Vnr 	Wie   					Wanneer  	Wat
--- 	---------------------	---------- 	-------------------------------------------------------------
001 	Jesper van Beemdelust	
	
=========================================================================================================

Bevindingenoverzicht
Vnr 	Wie   					Wanneer  	Wat
--- 	---------------------	----------	-------------------------------------------------------------

=========================================================================================================

**************************************************************************************************
STAP 1: Referen naar brondata en definieren van macro's/variabelen
STAP 1.1: Refereer naar de brondata
**************************************************************************************************/
/*PROC IMPORT*/
/*	FILE='\\EUR.TLD\Progdata\ZKA\Operations Support\WLZ\97. Teammap Support\08. Persoonlijk\Jesper van Beemdelust'*/
/*	OUT=data*/
/*	DBMS=xlsx*/
/*	REPLACE;*/
/*RUN;*/
/**************************************************************************************************
STAP 1.2: Definieer variabele die gebruikt worden in het programma
**************************************************************************************************/

/**************************************************************************************************
STAP 1.3: Definieer macro programma die later worden aangeroepen
**************************************************************************************************/

/**************************************************************************************************
STAP 2: Ophalen van brondata 	(Extract)
**************************************************************************************************/

/**************************************************************************************************
STAP 3: Transformaties			(Transform)
**************************************************************************************************/

/**************************************************************************************************
STAP 4:	Tabellen om te exporten	(Output tabellen)
**************************************************************************************************/

/**************************************************************************************************
STAP 5:	Export(s) aanmaken.
**************************************************************************************************/
/*PROC EXPORT*/
/*	DATA=*/
/*	OUTFILE='\\EUR.TLD\Progdata\ZKA\Operations Support\WLZ\97. Teammap Support\08. Persoonlijk\Jesper van Beemdelust\test.xlsx'*/
/*	DBMS=xlsx*/
/*	REPLACE;*/
/*RUN;*/