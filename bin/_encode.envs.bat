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
echo -- ENCODING ENVS %PATCHING%
echo --------------------------------------------------------------------------
echo.

rem ---------------------------------------------------
setlocal enableDelayedExpansion

rem ---------------------------------------------------
rem --- encode all envs
rem ---------------------------------------------------
if not exist "%DIR_OUTPUT_ENVS%" mkdir "%DIR_OUTPUT_ENVS%"
set ENV_WILDCARD=%DIR_DEF_ENVS%\%ENV_DEF_PREFIX%*.yml

rem overwrite wildcard with specific id if provided
if "%ENVID%" NEQ "" (
  SET ENV_WILDCARD=%DIR_DEF_ENVS%\%ENV_DEF_PREFIX%%ENVID%.yml
)

set COUNT=0

for /f "delims=" %%f in ('dir "%ENV_WILDCARD%" /b /s') do (
  set FILENAME=%%~ff
  echo --------------------------------------------------------------------------
  echo  ^>^> encoding: %%~nxf
  echo --------------------------------------------------------------------------

  PUSHD "%DIR_DEF_ENVS%"
  "%DIR_ENCODER%\w3env.exe" --output-dir "%DIR_OUTPUT_ENVS%" --encode "!FILENAME!" --create-subdirs %LOG_LEVEL%
  POPD
  set /A COUNT+=1
  IF /I "!ERRORLEVEL!" NEQ "0" GOTO:SomeError
)
echo.

if %COUNT% == 0 GOTO NoneFound
rem ---------------------------------------------------
endlocal
EXIT /B 0

rem ---------------------------------------------------
:SomeError
echo.
echo ERROR! Something went WRONG! Envs were NOT ENCODED!
echo.
exit /B 1

rem ---------------------------------------------------
:NoneFound
echo no envs to process. (file must be named: "%ENV_DEF_PREFIX%<some name>.yml")
echo.
rem endlocal

exit /B 0
