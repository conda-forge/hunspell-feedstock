@echo on

autoreconf -vfi
if errorlevel 1 exit 1

configure --prefix=%PREFIX% --with-readine --with-ui
if errorlevel 1 exit 1

make
if errorlevel 1 exit 1

make check
if errorlevel 1 exit 1

make install
if errorlevel 1 exit 1

mv %LIBRARY_BIN%\hunspell.exe %LIBRARY_BIN%\.hunspell.exe
if errorlevel 1 exit 1

:: We have to make a wrapper to add a spelling dictionary path to hunspell,
:: since none of the default ones are relative to the binary (i.e., can be
:: installed as a conda package)
echo set DICPATH='%PREFIX%\share\hunspell_dictionaries' >> %LIBRARY_BIN%\hunspell.cmd
echo %LIBRARY_BIN%\.hunspell.exe %%* >> %LIBRARY_BIN%\hunspell.cmd
if errorlevel 1 exit 1
