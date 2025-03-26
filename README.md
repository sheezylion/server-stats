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

## **⚙️ Steps to Set Up CI/CD**
### **Step 1: Create the GitHub Actions Workflow**
Inside the project, create a **`.github/workflows`** folder. Inside that folder, create a **`deploy.yml`** file.

Here’s the **GitHub Actions workflow file**:
