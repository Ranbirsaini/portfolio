@echo off
echo ==============================================
echo Flutter Web Auto-Deploy to GitHub Pages
echo ==============================================

:: Configure these variables
set REPO_URL=https://github.com/Ranbirsaini/portfolio.git
set REPO_NAME=portfolio
set FLUTTER_PATH=D:\All_DATA\flutter_windows_3.38.3-stable\flutter\bin\flutter.bat

echo.
echo Step 1: Building Flutter Web Release...
call "%FLUTTER_PATH%" build web --release --base-href "/%REPO_NAME%/"

if %errorlevel% neq 0 (
    echo.
    echo [ERROR] Build failed! Check code compiler warnings.
    pause
    exit /b %errorlevel%
)

echo.
echo Step 2: Preparing gh-pages branch...
cd build\web
:: Remove old git configuration if exists to avoid conflicts
if exist .git (
    rmdir /s /q .git
)
git init
git checkout -b gh-pages
git add .
git commit -m "Auto-deploy update: %date% %time%"
git remote add origin %REPO_URL%

echo.
echo Step 3: Pushing build to GitHub Pages...
git push origin gh-pages --force

echo.
echo Step 4: Cleaning up...
cd ..\..
echo.
echo ==============================================
echo [SUCCESS] Deploy complete!
echo Live Site: https://Ranbirsaini.github.io/%REPO_NAME%/
echo ==============================================
pause
