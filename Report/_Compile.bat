@ECHO OFF
CLS

REM What to do?
SET /P ACTION=Select action: 1, 2, 3, [D]elete, [O]pen, [Q]uit:

REM Assume bad compile
SET NUMCOMP=5

REM Well?
IF '%ACTION%'=='D' (GOTO DELETE)
IF '%ACTION%'=='d' (GOTO DELETE)
IF '%ACTION%'=='O' (SET NUMCOMP=4)
IF '%ACTION%'=='o' (SET NUMCOMP=4)
IF '%ACTION%'=='1' (SET NUMCOMP=1)
IF '%ACTION%'=='2' (SET NUMCOMP=2)
IF '%ACTION%'=='3' (SET NUMCOMP=3)

REM Bad action
IF %NUMCOMP% EQU 5 (EXIT)

REM Open
IF %NUMCOMP% EQU 4 (GOTO OPEN)

REM Create dir, setup compile x/y, jump to correct compile
MKDIR out
SET /A CCOMP=1
IF %NUMCOMP% EQU 1 (GOTO C1)
IF %NUMCOMP% EQU 2 (GOTO C2)

REM Compile full
:C3
CLS
TITLE pdflatex %CCOMP%/%NUMCOMP%
pdflatex Report.tex -output-directory out
SET /A CCOMP=%CCOMP%+1
REM With bibtex
CLS
TITLE bibtex 1/1
bibtex out/Report

REM Compile full, no cites
:C2
CLS
TITLE pdflatex %CCOMP%/%NUMCOMP%
pdflatex Report.tex -output-directory out
SET /A CCOMP=%CCOMP%+1

REM Compile fast
:C1
CLS
TITLE pdflatex %CCOMP%/%NUMCOMP%
pdflatex Report.tex -output-directory out

REM Open
:OPEN
IF NOT EXIST "out\Report.pdf" GOTO BADFILE
REM Special needs?
IF '%USERNAME%'=='ESJ' (GOTO MIKTEX)

REM Normal way of opening
:STD
START "" out\Report.pdf
EXIT

REM Open with MiKTeX
:MIKTEX
START "" miktex-texworks out\Report.pdf
EXIt

REM Delete aux files
:DELETE
RD out /S /Q
EXIT

REM File does not exists
:BADFILE
ECHO File does not exist
PAUSE
EXIT