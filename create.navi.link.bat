echo --------------------------------------------------------------------------
echo -- LINKING NAVI FOLDER
echo --------------------------------------------------------------------------

if not exist ".\_settings_.bat" (
  echo ERROR! _settings_.bat was not found!
  echo.
  echo - make sure _settings_.bat is in the root folder of the project
  echo - run this script again
  echo.
  pause
  EXIT /b
)
call _settings_.bat
echo.

if exist ".\_settings_.bat" (
   
  mklink /J "%DIR_PROJECT_BASE%\additional.dlc.pre-cook\data\levels\riviacapital\navi" "%DIR_UNCOOKED%\dlc\dlcriviacapital\levels\riviacapital\navi"

  echo.
  echo links successfully created.
  echo.
  pause
  EXIT /b
)
