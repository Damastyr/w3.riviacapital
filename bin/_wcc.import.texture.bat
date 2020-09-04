rem ---------------------------------------------------
rem --- check for settings
rem ---------------------------------------------------
IF %SETTINGS_LOADED% EQU 1 goto :SettingsLoaded

echo ERROR! Settings not loaded! - do not start this file directly!
EXIT /B 1
rem ---------------------------------------------------
:SettingsLoaded

SET TEXTURE_IN=%1
SET TEXTURE_OUT=%2
SET TEXTURE_PARAM=%3

if "%TEXTUREFILE%" NEQ "" (
    if "%TEXTUREFILE%" NEQ "%TEXTURE_IN%" (
        EXIT /B
    )
)

echo.
echo --------------------------------------------------------------------------
echo -- WCC_LITE: IMPORT TEXTURE %TEXTURE_IN%
echo --------------------------------------------------------------------------
echo.

if "%TEXTURE_PARAM%" NEQ "" (
    SET TEXTURE_PARAM=-texturegroup=%TEXTURE_PARAM%
)

PUSHD "%DIR_MODKIT_BIN%"
%WCC_LITE% import -depot="%DIR_MODKIT_DEPOT%" -file="%DIR_TEXTURE_IMPORT%\%TEXTURE_IN%" -out="%DIR_UNCOOKED_TEXTURES%\%DIR_DLC_GAMEPATH%\%TEXTURE_OUT%" %TEXTURE_PARAM%
POPD

IF %INTERACTIVE_BUILD% EQU 1 PAUSE

IF /I "%ERRORLEVEL%" NEQ "0" GOTO:SomeError

SET WCC_COOK=1
SET WCC_REPACK_DLC=1
SET WCC_TEXTURECACHE=1

set /A IMPORTED_TEXTURES+=1

EXIT /B %ERRORLEVEL%

rem ---------------------------------------------------
:SomeError
echo.
echo ERROR! Something went WRONG! at least one import FAILED!
echo.
exit /B 1
