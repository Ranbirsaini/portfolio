# Flutter Web GitHub Pages Deployment Guide 🚀

This guide explains how to upload, compile, and deploy a Flutter Web application to GitHub Pages from scratch. Follow these step-by-step instructions for any new project.

---

## 🏗️ Project Architecture & Branches
For any Flutter Web project hosted on GitHub, you need two branches:
1. **`main` (or `master`)**: Stores the Flutter source code (`.dart`, `pubspec.yaml`, configurations). This is for your development and backup.
2. **`gh-pages`**: Stores ONLY the compiled web release output (HTML, JS, CSS files inside `build/web/*`). GitHub Pages reads this branch to run your live website.

---

## 📋 Step-by-Step Deployment Guide (A to Z)

### Phase 1: Create a GitHub Repository
1. Go to [GitHub](https://github.com/) and click **New Repository**.
2. **Repository name**: Give it a name (e.g., `my-app`).
3. **Visibility**: Select **Public** (required for free hosting on GitHub Pages).
4. **Initialize options**: Leave all checkboxes (README, .gitignore) unchecked.
5. Click **Create repository** and copy the HTTPS repository URL (e.g., `https://github.com/username/my-app.git`).

---

### Phase 2: Push Source Code to `main` Branch
Open the terminal in your project's root directory and run:

```bash
# 1. Initialize local git repository
git init

# 2. Add all source files to staging
git add .

# 3. Create initial commit
git commit -m "Initial commit - Source Code"

# 4. Rename default branch to main
git branch -M main

# 5. Link local project to GitHub repo (paste your copied URL)
git remote add origin https://github.com/username/my-app.git

# 6. Push source code to GitHub
git push -u origin main --force
```

---

### Phase 3: Compile Web App for Release
Compile your Dart code into standard Web files.
> ⚠️ **IMPORTANT**: For GitHub Pages, the base-href must be matching your repository name. Replace `<REPO_NAME>` with your repository name.

```bash
flutter build web --release --base-href "/<REPO_NAME>/"
```
*Example: If your repo name is `portfolio`, command will be: `flutter build web --release --base-href "/portfolio/"`*

---

### Phase 4: Deploy Build Output to `gh-pages` Branch
Now you need to push the files inside `build/web` to the `gh-pages` branch on GitHub.

```bash
# 1. Navigate to the compiled build directory
cd build/web

# 2. Initialize a separate git repository inside this folder
git init

# 3. Create a gh-pages branch
git checkout -b gh-pages

# 4. Stage and commit the compiled web files
git add .
git commit -m "Deploy release build to GitHub Pages"

# 5. Add remote origin (use your repository URL)
git remote add origin https://github.com/username/my-app.git

# 6. Force push the files to gh-pages branch
git push origin gh-pages --force

# 7. Go back to main project folder
cd ../..
```

---

### Phase 5: Enable GitHub Pages in Repository Settings
1. Open your repository on GitHub.
2. Go to **Settings** -> **Pages** (in the left menu).
3. Under **Build and deployment**:
   - **Source**: Select `Deploy from a branch`.
   - **Branch**: Select **`gh-pages`** and folder **/ (root)**.
   - Click **Save**.
4. Wait 1-2 minutes. Your website will be live at:
   `https://<YOUR_USERNAME>.github.io/<REPO_NAME>/`

---

## ⚡ 1-Click Auto-Deploy Script (`deploy.bat`)
To make this process instant next time, you can create a `deploy.bat` file in your project root with the following commands. Running this batch file will automatically build your app and push it to GitHub Pages.

```batch
@echo off
echo ==============================================
echo Flutter Web Auto-Deploy to GitHub Pages
echo ==============================================

:: Configure these variables
set REPO_URL=https://github.com/Ranbirsaini/portfolio.git
set REPO_NAME=portfolio

echo.
echo Step 1: Building Flutter Web Release...
call flutter build web --release --base-href "/%REPO_NAME%/"

if %errorlevel% neq 0 (
    echo Error: Build failed!
    exit /b %errorlevel%
)

echo.
echo Step 2: Preparing gh-pages branch...
cd build\web
git init
git checkout -b gh-pages
git add .
git commit -m "Auto-deploy: %date% %time%"
git remote add origin %REPO_URL%

echo.
echo Step 3: Pushing build to GitHub Pages...
git push origin gh-pages --force

echo.
echo Step 4: Cleaning up...
cd ..\..
echo Done! Your site will be live soon on Pages.
pause
```
