/**********************************************************************************************
Macro Naam: [placeholder]
Doel: 
Beschrijving:
Opmerkingen:
Afhankelijkheden: [een voorbeeld van een afhankelijkheid is een andere macro die in dit script zal worden aangeroepen]
   
Parameters: 
Naam		Optioneel (Y/N)	Voorbeld input	Beschrijving

DATASET		N				Datamartmiaz	Neemt de dataset en performeert wat transformaties


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
%macro <macro name>

(

        Aaaa 		=		,

        bbbb 		=		,

        cccc 		=		,

        debug 		=

);

	/*Aangeven dat de macro begonnen is*/
	%put ---------------------------------------------------------------;

	%put --- Start van %upcase (&sysmacroname) macro;

	%put ---;
	
	/*Elke macro waarde naar de log schrijven*/
	%put --- Macro parameter waardes;

	%put --- input_dataset		=		&aaaa;

	%put ---------------------------------------------------------------;

	

	/*Aangeven dat de macro klaar is*/
	%put ---------------------------------------------------------------;

	%put --- Einde van %upcase (&sysmacroname) macro;

	%put ---------------------------------------------------------------;

%mend;