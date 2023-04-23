/**********************************************************************************************
Macro Naam: printer
Doel: Print of output geven van een bepaalde dataset
Beschrijving: 	Het printen of het aanmaken van een dataset. Voornamelijk in het leven geroepen voor leesbaarheid van code
				en het voorkomen van herschrijven van code.
Opmerkingen:
Afhankelijkheden: Geen
   
Parameters: 
Naam		Optioneel (Y/N)		Voorbeld input		Beschrijving

libn		Y					DMAZRACT			Refereerd naar een LIBREF, standaard WORK
dataset		N					DM_AZR_MUT			De dataset die geprint of een dataset moet worden
output		Y					0 of 1				Specifeerd of er geprint of output moet komen
													0 is voor print (default) en 1 is voor output

Voorbeeld van gebruik:

=========================================================================================================

Wijzigingshistorie:
Vnr 	Wie   					Wanneer  	Wat
--- 	---------------------	---------- 	-------------------------------------------------------------
001 	Jesper van Beemdelust	23-04-2023	Eerste opzet
	
=========================================================================================================

Bevindingenoverzicht
Vnr 	Wie   					Wanneer  	Wat
--- 	---------------------	----------	-------------------------------------------------------------

=========================================================================================================

TODO:

=========================================================================================================
**********************************************************************************************/
%macro printer

(

        libn 		=		/*LIBREF voor een database, voorbeeld: DMMIAZ. Default = Work*/,

        dataset	 	=		/*De dataset die je wilt bekijkt zien*/,
        
        output		=	0	/*Aangeven of er een output dataset moet komen of dat er alleen een printversie moet komen*/

);
	
	/*Check welke library aangewezen moet worden */
	%if &libn.= %then %do;
		%let lib=work;
	%end;
	
	%else %do;
		%let lib=&libn.;
	%end;

	/*Aangeven dat de macro begonnen is*/
	%put ---------------------------------------------------------------;

	%put --- Start van %upcase (&sysmacroname) macro;

	%put ---;
	
	/*Elke macro waarde naar de log schrijven*/
	%put --- Macro parameter waardes;
	
	%put --- libn			=		&libn;

	%put --- dataset		=		&dataset;
	
	%put --- output			=		&output;

	%put ---------------------------------------------------------------;

	%IF &output. = 0 %THEN %DO;
		PROC PRINT DATA=&libn..&dataset.;
		RUN;
	%END;
	
	%ELSE %DO;
		DATA output_&sysmacroname.;
			SET &libn..&dataset.;
		RUN;
	%END

	/*Aangeven dat de macro klaar is*/
	%put ---------------------------------------------------------------;

	%put --- Einde van %upcase (&sysmacroname) macro;

	%put ---------------------------------------------------------------;

%mend;