rem ---------------------------------------------------
rem --- check for settings
rem ---------------------------------------------------
IF %SETTINGS_LOADED% EQU 1 goto :SettingsLoaded

echo ERROR! Settings not loaded! - do not start this file directly!
EXIT /B 1
rem ---------------------------------------------------
:SettingsLoaded

echo.
echo --------------------------------------------------------------------------
echo -- ENCODING HAIRWORKS %PATCHING%
echo --------------------------------------------------------------------------
echo.

rem ---------------------------------------------------
setlocal enableDelayedExpansion

set FURFILES_WILDCARD=%FUR_DEF_PREFIX%*.apx

rem overwrite wildcard with specific id if provided
if "%FURNAME%" NEQ "" (
  SET FURFILES_WILDCARD=%FUR_DEF_PREFIX%%FURNAME%.apx
)

if not exist "%DIR_OUTPUT_REDFUR%" mkdir "%DIR_OUTPUT_REDFUR%"

set COUNT=0

:: check if any files can be found (add * to wildcard so it always gets expanded)
for /R "%DIR_DEF_FUR%" %%f in ("%FURFILES_WILDCARD%*") do (
    set /A COUNT+=1
)
if %COUNT% == 0 GOTO NoneFound

PUSHD "%DIR_DEF_FUR%"
"%DIR_ENCODER%\w3redfur.exe" -e "%DIR_DEF_FUR%/**/%FURFILES_WILDCARD%" --output-dir "%DIR_OUTPUT_REDFUR%" --create-subdirs %LOG_LEVEL%
POPD
IF %ERRORLEVEL% NEQ 0 GOTO SomeError

rem ---------------------------------------------------
rem -- at least one apx was imported, setup followup flags

endlocal
if /I "%PATCH_MODE%" EQU "0" (
    :: full set of dependencies
    SET WCC_COOK=1
    SET WCC_REPACK_DLC=1
)
EXIT /B %ERRORLEVEL%

rem ---------------------------------------------------
:SomeError
echo.
echo ERROR! Something went WRONG! at least one Hairworks file was NOT ENCODED!
echo.
exit /B 1

rem ---------------------------------------------------
:NoneFound
echo no hairworks encoded. (file must be named: "%FUR_DEF_PREFIX%<some name>.apx")
echo.
exit /B 0
