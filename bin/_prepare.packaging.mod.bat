rem ---------------------------------------------------
rem --- check for settings
rem ---------------------------------------------------
IF %SETTINGS_LOADED% EQU 1 goto :SettingsLoaded

echo ERROR! Settings not loaded! - do not start this file directly!
EXIT /B 1
rem ---------------------------------------------------
:SettingsLoaded

echo.
echo ---------------------------------------------------------------------------
echo -- PREPARE PACKING: COPY ADDITIONAL MOD POST-COOK DATA
echo ---------------------------------------------------------------------------
echo.

echo  ^> copying files to %DIR_COOKED_MOD%

if EXIST "%DIR_PROJECT_BASE%\_before-prepare-packaging-mod_.bat" (
  CALL "%DIR_PROJECT_BASE%\_before-prepare-packaging-mod_.bat"
  IF %ERRORLEVEL% NEQ 0 GOTO SomeError
)

rem check if there are any files to copy
for /F "delims=" %%I in ( 'DIR /A-D /B /S "%DIR_ADDITIONAL_MOD_POST_COOK%" ^| FIND /C /V ""' ) do SET FILE_COUNT=%%I

if EXIST "%DIR_ADDITIONAL_MOD_POST_COOK%\README.1ST" (
  IF "%FILE_COUNT%" EQU "1" (
    EXIT /B 0
  )
) else (
  IF "%FILE_COUNT%" EQU "0" (
    EXIT /B 0
  )
)

robocopy "%DIR_ADDITIONAL_MOD_POST_COOK%" "%DIR_COOKED_MOD%" /s /NFL /NJH /XX
echo  ^> done.

if %ERRORLEVEL% EQU 0 GOTO :Continue
:: One or more files were copied successfully (that is, new files have arrived).
if %ERRORLEVEL% EQU 1 GOTO :Continue
:: Some Extra files or directories were detected.
if %ERRORLEVEL% EQU 2 GOTO :Continue
:: (2+1) Some files were copied. Additional files were present. No failure was encountered.
if %ERRORLEVEL% EQU 3 GOTO :Continue
:: something else happened
EXIT /B %ERRORLEVEL%

rem ---------------------------------------------------
rem error
:SomeError
EXIT /B 1

:Continue
:: remove leftover
if exist "%DIR_COOKED_MOD%\README.1ST" del "%DIR_COOKED_MOD%\README.1ST"
EXIT /B 0
