powershell Invoke-WebRequest -o levilamina-release-nonmimalloc-windows-x64.zip https://github.com/CodeBedrock/levilamina-endstone/releases/download/v%1/levilamina-release-nonmimalloc-windows-x64.zip
powershell Invoke-WebRequest -o endstone-cp312-cp312-win_amd64.zip https://github.com/CodeBedrock/endstone-levilamina/releases/download/v%2/endstone-%2-cp312-cp312-win_amd64.whl
powershell Invoke-WebRequest -o cmdfix-windows-x64.zip https://github.com/CodeBedrock/cmdfix/releases/download/v%3/cmdfix-windows-x64.zip
powershell Invoke-WebRequest -o lip-windows-amd64.zip https://github.com/futrime/lip/releases/download/v0.23.1/lip-windows-amd64.zip
powershell -Command "Expand-Archive -LiteralPath levilamina-release-nonmimalloc-windows-x64.zip"
powershell -Command "Expand-Archive -LiteralPath endstone-cp312-cp312-win_amd64.zip"
powershell -Command "Expand-Archive -LiteralPath cmdfix-windows-x64.zip"
powershell -Command "Expand-Archive -LiteralPath lip-windows-amd64.zip"
mkdir server
cd server
..\lip-windows-amd64\lip install -y github.com/LiteLDev/LeviLamina\@%1
xcopy ..\levilamina-release-nonmimalloc-windows-x64\LeviLamina .\plugins\LeviLamina /-y
mkdir .\plugins\cmdfix
xcopy ..\cmdfix-windows-x64\cmdfix .\plugins\cmdfix /-y
mkdir .\plugins\endstone
echo {"name": "endstone","entry": "../../../Lib/site-packages/endstone/_internal/endstone_runtime.dll","version": "0.5.0","type": "preload-native"} > .\plugins\endstone\manifest.json
cd ..
py -m venv .
call .\Scripts\activate.bat
pip install endstone
xcopy /E .\endstone-cp312-cp312-win_amd64\ .\Lib\site-packages
