# Beyond the Terminal - Self-Motivation Landing Page 

## **Overview**
This project is a **personal self-motivation landing page** aimed at guiding individuals on:
- **Daily motivation practices** (prayer, meditation, self-reflection).
- **Navigating life challenges** (overcoming self-doubt, finding purpose).
- **Transitioning into DevOps** (step-by-step beginner-friendly learning resources).

The goal is to **create a functional, aesthetically pleasing web page** that not only shares valuable resources but also reflects **my personal journey** as I transition into tech. This is an evolving project that I will improve over time.

---

## **Why This Project?**
This project started as a **way to document my journey** and help others who might be feeling **lost or overwhelmed**. Whether you're:
- **Looking for motivation** to start your day right.
- **Struggling with self-doubt** and feeling left behind in life.
- **Exploring DevOps** and need a structured roadmap.

This webpage serves as a simple starting point. 

---


---

## **Setting Up CI/CD with GitHub Actions**
To ensure **smooth deployment** and **automated testing**, we’ll use **GitHub Actions** for **CI/CD (Continuous Integration & Deployment).**  

### **What CI/CD Does Here**
- ✅ **Build:** Ensures all project files (**HTML, CSS, JavaScript**) are correctly structured.
- ✅ **Test:** Runs basic checks like:
  - **Linting JavaScript** (checking for errors & best practices).
  - **Validating HTML** (ensuring correct structure).
  - **Checking CSS for styling issues.**
- ✅ **Deploy:** Automatically pushes updates to **GitHub Pages** if all tests pass.

---

## **⚙Steps to Set Up CI/CD**
### **Step 1: Create the GitHub Actions Workflow**
Inside the project, create a **`.github/workflows`** folder. Inside that folder, create a **`deploy.yml`** file.

Here’s the **GitHub Actions workflow file**:

```
name: Deploy to GitHub Pages

on:
  push:
    branches:
      - main  # Runs the workflow when code is pushed to 'main'
  pull_request:
    branches:
      - main  # Also runs when a pull request is created

jobs:
  build:
    name: Build & Test
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Repository
        uses: actions/checkout@v3

      - name: Lint JavaScript
        run: |
          npx eslint js/*.js || true  # Checks for JS errors, but doesn't stop the workflow if errors exist

      - name: Validate HTML
        run: |
          npx html-validator-cli --file index.html --format text || true

      - name: Check CSS
        run: |
          npx stylelint "css/*.css" || true  # Checks CSS for issues

  deploy:
    name: Deploy to GitHub Pages
    needs: build
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Repository
        uses: actions/checkout@v3

      - name: Deploy to GitHub Pages
        uses: JamesIves/github-pages-deploy-action@v4
        with:
          branch: gh-pages
          folder: .

     
```

## Breaking Down the Workflow
### 1. Build Step
Ensures all project files are correctly structured before deployment.

### 2. Test Step
- JavaScript Linter (ESLint): Checks for syntax errors & best practices.

- HTML Validator: Ensures the HTML structure is correct.

- CSS Style Checker: Checks for CSS issues.

### 3. Deploy Step
Automatically pushes updates to GitHub Pages only if all previous steps pass.
