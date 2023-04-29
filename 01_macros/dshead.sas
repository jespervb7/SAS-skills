/**********************************************************************************************
Macro Naam: dshead
Doel:
Beschrijving: Neemt een dataset en print hiervan de eerste N regels, default van N is 10.
Opmerkingen:
Afhankelijkheden: printer macro
   
Parameters: 
Naam		Optioneel (Y/N)		Voorbeld input		Beschrijving

libn		Y					sashelp				De libref waar de dataset zich bevind, default is work
dataset		N					Datamartmiaz		Neemt de dataset en performeert wat transformaties
nobs		Y					100					Neemt een numerieke waarde, hiermee geef je aan hoeveel
													regels je in je output wilt zien.

Voorbeeld van gebruik:

=========================================================================================================

Wijzigingshistorie:
Vnr 	Wie   					Wanneer  	Wat
--- 	---------------------	---------- 	-------------------------------------------------------------
001 	Jesper van Beemdelust	
	
=========================================================================================================

Bevindingenoverzicht
Vnr 	Wie   					Wanneer  	Wat
--- 	---------------------	----------	-------------------------------------------------------------

=========================================================================================================

TODO:


=========================================================================================================
**********************************************************************************************/
%macro dshead

(

        libn 		=	work /*input library, default = work */	,

        dataset 	=		/*De dataset die je wilt bekijkt zien*/,
        
        nobs		= 	10 /*Aantal regels dat wordt opgezocht en geprint*/

);

	/*Aangeven dat de macro begonnen is*/
	%put ---------------------------------------------------------------;

	%put --- Start van %upcase (&sysmacroname) macro;

	%put ---;
	
	/*Elke macro waarde naar de log schrijven*/
	%put --- Macro parameter waardes;

	%put --- libn			=		&libn;

	%put --- dataset		=		&dataset;
	
	%put --- nobs			=		&nobs;

	%put ---------------------------------------------------------------;

	PROC SQL OUTOBS=&nobs;
		CREATE TABLE dshead AS
			SELECT * 
			FROM &libn..&dataset.;
	RUN;
	
	%printer(dataset=dshead, title=Eerste &nobs regels);

	/*Aangeven dat de macro klaar is*/
	%put ---------------------------------------------------------------;

	%put --- Einde van %upcase (&sysmacroname) macro;

	%put ---------------------------------------------------------------;

%mend;