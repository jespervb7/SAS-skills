%macro dsdelete(libn=, ds=, par=);
 
	%if &libn.= %then %do;
		%let lib=work;
	%end;
	%else %do;
		%let lib=&libn.;
	%end;
 
	%if &par.=1 %then %do;
		%goto exit;
	%end;
	%else %do;
		proc datasets library=&lib. nolist;
			delete &ds.;
		run;
	%end;
 
	%exit:
 
%mend dsdelete;