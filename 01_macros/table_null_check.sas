/**********************************************************************************************
Macro Naam: 		table_null_check
Doel: 				Het controleren van het aantal missende waardes in een table
Beschrijving:		Alle kolommen worden gezocht en op basis van het aantal hiervan wordt er, 
					in een do loop, apart elke kolom aangeroepen. Vervolgens wordt dit aan een
					"master" dataset toegevoegd en deze krijg je uiteindelijk te zien.
Opmerkingen: 		LET OP! Er wordt per kolom de database aangeroepen. 
					Hierdoor kan dit voor problemen leiden. Zie ook het bevindingen overzicht 001
Afhankelijkheden: 	- dsdeletes van de MIAZ Macros
 
Parameters: 
Naam		Optioneel (Y/N)	Voorbeld input	Beschrijving

Libn		Y				SASHELP			Moet een database/libref referentie zijn, default is work.
Dataset		N				CLASS			Betreft de dataset die je wilt bekijken
Output		Y				0 of 1			Print het resultaat van de macro of geeft output naar een dataset


Voorbeeld van gebruik:
%tabel_null_check(libn=SASHELP, dataset=class);

Voorbeeld output:

Tabelnaam		Kolomnaam		Aantal_regels		Aantal_gevulde_regels		Missende_regels		Percentage_gevuld
---------		---------		-------------		---------------------		---------------		-----------------
FCT_SCHADE		ID_BRON			1.000.000			900.000						100.000				90.00%
FCT_SCHADE		NR_SCHNOT		1.000.000			1.000.000					0					100.00%

=========================================================================================================

Wijzigingshistorie:
Vnr 	Wie   					Wanneer  	Wat
--- 	---------------------	---------- 	-------------------------------------------------------------
001 	Jesper van Beemdelust	29-04-2023	Eerste opzet Macro
	
=========================================================================================================


Bevindingenoverzicht
Vnr 	Wie   					Wanneer  	Wat
--- 	---------------------	----------	-------------------------------------------------------------

=========================================================================================================

TODO:
- logging toevoegen

=========================================================================================================
**********************************************************************************************/
%macro table_null_check

(

        libn	 		=	work /*LIBREF voor een database, voorbeeld: DMMIAZ. Default work*/,

        dataset	 		=		 /*De dataset die je wilt bekijkt zien*/,

        output			=	0	 /*0 Print de dataset. 1 output de dataset*/

);

	/*Aangeven dat de macro begonnen is*/
	%put ---------------------------------------------------------------;

	%put --- Start van %upcase (&sysmacroname) macro;

	%put ---;
	
	/*Elke macro waarde naar de log schrijven*/
	%put --- Macro parameter waardes;

	%put --- libn		=		&libn;

	%put --- dataset	=		&dataset;

	%put --- output		=		&output;

	%put ---------------------------------------------------------------;
	
	/*Ophalen metadata gegevens van de library*/
	PROC SQL;
		CREATE TABLE &libn AS
			SELECT 
				 	(libname||'.'||memname)	AS Database_tabel
				,	memname					AS Tabelnaam
				, 	name					AS Kolomnaam
			FROM dictionary.columns
			WHERE libname = %UPCASE("&libn") AND memname = %UPCASE("&dataset");
	RUN;

	/*Toevoegen volgnummer om een dynamische do loop te maken*/
	DATA metadata;
		SET &libn;
		volgnummer = _N_;
	RUN;

	PROC SQL NOPRINT;
		SELECT MAX(volgnummer) into: aantal_tabelkolommen
		FROM metadata;
	RUN;

	DATA null_controle;
		LENGTH Tabelnaam $40.;
		LENGTH Kolomnaam $40.;
		LENGTH Aantal_regels 8;
		LENGTH Aantal_gevulde_regels 8;
		LENGTH Aantal_unieke_waardes 8;
	RUN;

	/*Doorloopt elke kolom in de database en voert hier de acties op uit*/
	%DO i=1 %to &aantal_tabelkolommen;

		PROC SQL NOPRINT;
			SELECT Database_tabel, Tabelnaam, Kolomnaam
			INTO :database_tabel, :tabelnaam, :kolomnaam
			FROM metadata
			WHERE volgnummer = &i.;
		RUN;
		
		%put ------------------;
		%put &database_tabel;
		%put &kolomnaam;
		%put ------------------;

		PROC SQL;
			CREATE TABLE stap1_&i. AS
				SELECT 
						"&tabelnaam"						AS Tabelnaam
					,	"&kolomnaam"						AS Kolomnaam
					,	COUNT(*) 							AS Aantal_regels
					,	COUNT(&kolomnaam)					AS Aantal_gevulde_regels
					,	COUNT(DISTINCT &kolomnaam.)			AS Aantal_unieke_waardes
				FROM &database_tabel;
		RUN;

		DATA stap2_&i.;
			LENGTH Tabelnaam $40.;
			LENGTH Kolomnaam $40.;
			LENGTH Aantal_regels 8;
			LENGTH Aantal_gevulde_regels 8;
			LENGTH Aantal_unieke_waardes 8;
			SET stap1_&i.;
		RUN;
		
		PROC APPEND 
			BASE=null_controle
			DATA=stap2_&i.;
        RUN;

		%dsdelete(ds=stap1_&i.);
		%dsdelete(ds=stap2_&i.);
  
	%END;	

	PROC SQL;
		CREATE TABLE output_null_controle AS
			SELECT 
					Tabelnaam
				,	Kolomnaam
				,	aantal_regels														FORMAT COMMA10.0
				,	aantal_gevulde_regels												FORMAT COMMA10.0
				,	aantal_unieke_waardes												FORMAT COMMA10.0
				,	(aantal_regels-aantal_gevulde_regels) 		AS Missende_regels		FORMAT COMMA10.0
				,	(aantal_gevulde_regels/aantal_regels)		AS Percentage_gevuld 	FORMAT PERCENT10.2
				,	(aantal_unieke_waardes/aantal_regels)		AS Percentage_uniek		FORMAT PERCENT10.2
			FROM null_controle
			WHERE tabelnaam IS NOT NULL;
	RUN;

	/*Opschonen van macro files*/
	%dsdelete(ds=metadata);
	%dsdelete(ds=&libn);
	%dsdelete(ds=null_controle);

	/*Printer functie aanroepen*/
	%printer(dataset=output_null_controle, title=Data kwaliteit check, output=&output);

	/*Aangeven dat de macro klaar is*/
	%put ---------------------------------------------------------------;

	%put --- Einde van %upcase (&sysmacroname) macro;

	%put ---------------------------------------------------------------;

%mend;