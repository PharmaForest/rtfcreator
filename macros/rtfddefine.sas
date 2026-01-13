/*** HELP START ***//*

This is a macro for creating RTF styles.
By simply specifying the font and font size, you can create a template style using PROC TEMPLATE.
Parameters:
(Optional: default=PORTRAIT)LAYOUT: Page orientation -- either "PORTRAIT" or "LANDSCAPE"
(Optional: default=STUDY_RTF)STYLENAM: Name of the style to be created
(Optional: default=MS Mincho)FONT: Font name
(Optional: default=8pt)FONT_SIZE: Font size

*//*** HELP END ***/

%macro rtfdefine(LAYOUT=PORTRAIT,STYLENAM=STUDY_RTF,font=MS Mincho, font_size=8pt);
%** set layout ;
%if %upcase(&LAYOUT.)=LANDSCAPE %then %do;
%put Page style: LANDSCAPE - A4 -Margin is Top2.5cm Left-Right-Bottom-1.0cm;
options
nodate nonumber
papersize="A4"
orientation=landscape
topmargin   =2.5cm
bottommargin=1.0cm
leftmargin  =1.0cm
rightmargin =1.0cm
;
%end;
%if %upcase(&LAYOUT.) ne LANDSCAPE %then %do;
%if %upcase(&LAYOUT.) ne PORTRAIT %then %put WARNING: Parameter LAYOUT is not "LANDSCAPE" or "PORTRAIT". Create layout is PORTRAIT;
%put Page style: PORTRAIT - A4 -Margin is Left2.5cm Right-Top-Bottom-1.0cm;
options
nodate nonumber
papersize="A4"
orientation=portrait
topmargin   =1.0cm
bottommargin=1.0cm
leftmargin  =2.5cm
rightmargin =1.0cm
;
%end;
%** Template ;
proc template;
define style &STYLENAM. / store=work.TEMPLAT(UPDATE);
parent = Styles.rtf;
style fonts / 'docfont'           = ("&font.", &font_size.)
'headingfont'       = ("&font.", &font_size.)
'fixedfont'         = ("&font.", &font_size.)
'batchfixedfont'    = ("&font.", &font_size.)
'fixedstrongfont'   = ("&font.", &font_size.)
'fixedemphasisfont' = ("&font.", &font_size.)
'emphasisfont'      = ("&font.", &font_size.)
'strongfont'        = ("&font.", &font_size.)
'titlefont'         = ("&font.", &font_size.)
'titlefont2'        = ("&font.", &font_size.)
;
style color_list / 'fg' = black 'fgA' = black 'fgA1' = black 'fgA2' = black 'fgB1' = black 'fgB2' = black 'fgA4' = black 'link' = black
'bg' = white 'bgA' = white 'bgA1' = white 'bgA2' = white 'bgA3' = white 'bgA4' = white 'bgA4' = white  'bgH' = white  ;
style output from container / borderwidth = 1 bordercolor=black borderstyle=solid
frame = hsides rules = group cellspacing = 0 cellpadding = 0;
style table from output;
style table/
foreground = black
background = white
cellspacing = 0
cellpadding = 0
frame = hsides
rules = groups
just  = left
borderwidth = 1
bordercolor = black
borderstyle = solid
;
end;
run;
%put Create style -- &STYLENAM. - template style;
%mend rtfdefine;
/* eof */
