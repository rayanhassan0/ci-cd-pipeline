# CI/CD Pipeline Project
[![CI](https://github.com/rayanhassan0/ci-cd-pipeline/actions/workflows/python-app.yml/badge.svg?branch=main)](https://github.com/rayanhassan0/ci-cd-pipeline/actions/workflows/python-app.yml)

This project demonstrates a complete CI/CD pipeline using **GitHub Actions** (CI), **Azure Pipelines** (CD), and **Azure App Service** (runtime).

- **App tech:** Python + Flask + Gunicorn  
- **Endpoints:** `/` (health text), `/predict` (JSON: sum of numbers)  
- **Deployed App:** `https://rayan-ci-cd-app-we.azurewebsites.net`

---

## Project Overview
- **CI:** On each push/PR to `main`, GitHub Actions installs deps, runs **pylint** and **pytest**.
- **CD:** Azure Pipelines builds/archives the app and deploys to **Azure Web App** automatically.
- **Verification:** `curl` + browser check after deploy.

---

## Architectural Diagram
```mermaid
flowchart LR
  A[GitHub Repo] -->|Push Code| B[GitHub Actions: CI]
  B -->|Build + Lint + Test| C[Azure Pipelines: CD]
  C -->|Deploy App| D[Azure App Service]
  D -->|Access| E[Browser / curl]
  ```


Project Management

Trello Board: CI/CD Pipeline Project Trello Board

Spreadsheet: ci_cd_tasks.xlsx

Demo Video: YouTube Screencast

How to Run (Locally / Cloud Shell)
1) Clone
git clone https://github.com/rayanhassan0/ci-cd-pipeline.git
cd ci-cd-pipeline

2) Lint & Tests (one-shot)
make all
# or run step-by-step:
# python -m pip install -r requirements.txt
# python -m pylint --disable=R,C hello.py
# python -m pytest -vv

3) Run locally (optional)
# dev only
python hello.py
# open http://127.0.0.1:8000/

API Endpoints (Production on Azure)
Health (GET /)
APP="rayan-ci-cd-app-we"
curl -i "https://$APP.azurewebsites.net/"

Predict (POST /predict)
APP="rayan-ci-cd-app-we"
curl -i -X POST "https://$APP.azurewebsites.net/predict" \
  -H "Content-Type: application/json" \
  -d '{"data":[1,2,3,4]}'
# -> {"sum":10}