rem ---------------------------------------------------
rem --- check for settings
rem ---------------------------------------------------
IF %SETTINGS_LOADED% EQU 1 goto :SettingsLoaded

echo ERROR! Settings not loaded! - do not start this file directly!
EXIT /B 1
rem ---------------------------------------------------
:SettingsLoaded

:: check for any shadowlayer definitions
if EXIST "%DIR_UNCOOKED%\*-shadowlayer.yml" (
  goto :EncodeShadowMeshes
)
:: none found
EXIT /B 0

:EncodeShadowMeshes
echo.
echo --------------------------------------------------------------------------
echo -- ENCODING SHADOW MESHES
echo --------------------------------------------------------------------------
echo.

rem ---------------------------------------------------
"%DIR_ENCODER%\w3world.exe" --repo-dir "%DIR_REPO_WORLDS%" --repo-shadowmeshes-dir "%DIR_ENCODER%\repo.shadowmeshes" --output-dir "%DIR_UNCOOKED%\%DIR_DLC_GAMEPATH%" --encode-shadowmesh-layers "%DIR_UNCOOKED%\*-shadowlayer.yml" %LOG_LEVEL%
IF %ERRORLEVEL% NEQ 0 GOTO SomeError

rem ---------------------------------------------------
rem -- shadow meshes were encoded, setup followup flags

if /I "%PATCH_MODE%" EQU "1" (
  :: NO dependent steps (e.g. repacking must be toggled by caller)
  echo.
) else (
  :: full set of dependencies
  SET WCC_ANALYZE=1
  SET WCC_COOK=1
  SET WCC_REPACK_DLC=1
)
EXIT /B 0

rem ---------------------------------------------------
:SomeError
echo.
echo ERROR! Something went WRONG! Quest was NOT ENCODED!
echo.
exit /B 1
