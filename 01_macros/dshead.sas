/**********************************************************************************************
Macro Naam: dshead
Doel: Geeft output van de eerste 10 regels (by default) van een dataset.
Beschrijving:
Opmerkingen:
Afhankelijkheden: [een voorbeeld van een afhankelijkheid is een andere macro die in dit script zal worden aangeroepen]
   
Parameters: 
Naam		Optioneel (Y/N)		Voorbeld input		Beschrijving

DATASET		N					Datamartmiaz		Neemt de dataset en performeert wat transformaties

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
- logging toevoegen

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