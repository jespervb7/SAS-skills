/**********************************************************************************************
Macro Naam: column_overview
Doel: Printen van metadata voor gebruik in een sas sessie.
Beschrijving:
Opmerkingen:
Afhankelijkheden: 	- dsdeletes van de MIAZ Macros
					- printer macro	
   
Parameters: 
Naam		Optioneel (Y/N)		Voorbeld input		Beschrijving

libn		Y					Datamartmiaz		De libref waar de dataset staat, default = work
dataset		N					fct_schade			Neemt de dataset en geeft output van de verschillende kolommen + metadata
output		Y					0 of 1				Print de output als default, maar kan de dataset ook outputten met 1

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
%macro column_overview

(

        libn 		=	work /*LIBREF voor een database, voorbeeld: DMMIAZ. Default = Work*/,

        dataset	 	=		/*De dataset die je wilt bekijkt zien*/,
        
        output		=	0	/*0 Print de dataset. 1 output de dataset*/

);

	/*Aangeven dat de macro begonnen is*/
	%put ---------------------------------------------------------------;

	%put --- Start van %upcase (&sysmacroname) macro;

	%put ---;
	
	/*Elke macro waarde naar de log schrijven*/
	%put --- Macro parameter waardes;

	%put --- libn			=		&libn;

	%put --- dataset		=		&dataset;

	%put ---------------------------------------------------------------;

	PROC CONTENTS data=&libn..&dataset. out=overview NOPRINT;
	RUN;
	
	DATA overview1;
		SET overview (keep=NAME TYPE LENGTH LABEL FORMAT);
	RUN;
	
	PROC SQL;
		CREATE TABLE overview2 AS
			SELECT
					NAME
				,	CASE
						WHEN TYPE = 1
						THEN "Numeric"
						WHEN TYPE = 2
						THEN "Character"
						ELSE "Unknown"
					END AS datatypes
				,	LENGTH
				,	LABEL
				,	FORMAT
			FROM overview1;
	RUN;
	
	%printer(dataset=overview2, title=Metadata van de kolommen, output=&output);
	%dsdelete(ds=overview overview1 overview2);
	
	/*Aangeven dat de macro klaar is*/
	%put ---------------------------------------------------------------;

	%put --- Einde van %upcase (&sysmacroname) macro;

	%put ---------------------------------------------------------------;

%mend;