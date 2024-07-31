powershell curl -o levilamina-release-nonmimalloc-windows-x64.zip https://github.com/CodeBedrock/levilamina-endstone/releases/download/v0.13.4/levilamina-release-nonmimalloc-windows-x64.zip
powershell curl -o endstone-0.5.0-cp312-cp312-win_amd64.zip https://github.com/CodeBedrock/endstone-levilamina/releases/download/v0.5.0/endstone-0.5.0-cp312-cp312-win_amd64.whl
powershell curl -o cmdfix-windows-x64.zip https://github.com/CodeBedrock/cmdfix/releases/download/v0.0.1/cmdfix-windows-x64.zip
powershell -Command "Expand-Archive -LiteralPath levilamina-release-nonmimalloc-windows-x64.zip"
powershell -Command "Expand-Archive -LiteralPath endstone-0.5.0-cp312-cp312-win_amd64.zip"
powershell -Command "Expand-Archive -LiteralPath cmdfix-windows-x64.zip"
mkdir server
cd server
lip install -y github.com/LiteLDev/LeviLamina
xcopy ..\levilamina-release-nonmimalloc-windows-x64\LeviLamina .\plugins\LeviLamina /-y
mkdir .\plugins\cmdfix
xcopy ..\cmdfix-windows-x64\cmdfix .\plugins\cmdfix /-y
mkdir .\plugins\endstone
echo {"name": "endstone","entry": "../../../Lib/site-packages/endstone/_internal/endstone_runtime.dll","version": "0.5.0","type": "preload-native"} > .\plugins\endstone\manifest.json
cd ..
py -m venv .
xcopy .\Scripts\activate.bat .\Scripts\modified.bat
echo pip install endstone>>.\Scripts\modified.bat
echo xcopy /E .\endstone-0.5.0-cp312-cp312-win_amd64\ .\Lib\site-packages>>.\Scripts\modified.bat
.\Scripts\modified.bat
