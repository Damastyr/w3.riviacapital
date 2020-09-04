rem ---------------------------------------------------
rem --- check for settings
rem ---------------------------------------------------
IF %SETTINGS_LOADED% EQU 1 goto :SettingsLoaded

echo ERROR! Settings not loaded! - do not start this file directly!
EXIT /B 1
rem ---------------------------------------------------
:SettingsLoaded

if not exist "%DIR_ADDITIONAL_DLC_PRE_COOK%" EXIT /B

echo.
echo ---------------------------------------------------------------------------
echo -- PREPARE COOKING: CLEANUP OF UNCOOKED CONTENT
echo ---------------------------------------------------------------------------
echo.

if not exist "%DIR_TMP%" mkdir "%DIR_TMP%"

echo.
echo ---------------------------------------------------------------------------
echo -- PREPARE COOKING: COPY ADDITIONAL DLC PRE-COOK DATA
echo ---------------------------------------------------------------------------
echo.

echo  ^> copying files to %DIR_UNCOOKED%\%DIR_DLC_GAMEPATH%

robocopy "%DIR_ADDITIONAL_DLC_PRE_COOK%" "%DIR_UNCOOKED%\%DIR_DLC_GAMEPATH%" /s /NFL /NJH /XX
echo  ^> done.

if %ERRORLEVEL% EQU 0 EXIT /B 0
:: One or more files were copied successfully (that is, new files have arrived).
if %ERRORLEVEL% EQU 1 EXIT /B 0
:: Some Extra files or directories were detected.
if %ERRORLEVEL% EQU 2 EXIT /B 0
:: (2+1) Some files were copied. Additional files were present. No failure was encountered.
if %ERRORLEVEL% EQU 3 EXIT /B 0
:: something else happened
EXIT /B %ERRORLEVEL%
