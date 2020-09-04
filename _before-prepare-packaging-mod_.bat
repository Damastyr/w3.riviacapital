::
:: will be called AFTER cooking but BEFORE packaging MOD data
::
@echo off
:: ---------------------------------------------------
:: --- check for settings
:: ---------------------------------------------------
IF %SETTINGS_LOADED% EQU 1 goto :SettingsLoaded

echo ERROR! Settings not loaded! - do not start this file directly!
EXIT /B 1

:SettingsLoaded

:: ---------------------------------------------------
:: keep moving assets minimal:
::  only to override vanilla files, otherwise prefer packaging as dlc.
:: e.g:
::
:: SET DIR_TGT=%DIR_COOKED_MOD%\characters\models\main_npc\ciri
:: if NOT EXIST "%DIR_TGT%" mkdir "%DIR_TGT%"
::
:: move /y "%DIR_COOKED_DLC%/%DIR_DLC_GAMEPATH%\data\entities\ciri_hw_hairs.w2ent" "%DIR_TGT%\c_01_wa__ciri.w2ent"
