# CI/CD Pipeline Project
[![CI](https://github.com/rayanhassan0/ci-cd-pipeline/actions/workflows/python-app.yml/badge.svg?branch=main)](https://github.com/rayanhassan0/ci-cd-pipeline/actions/workflows/python-app.yml)

This project demonstrates a complete CI/CD pipeline using **GitHub Actions**, **Azure Pipelines**, and **Azure App Service**.

---

## Project Overview
The project applies DevOps best practices:

- **Continuous Integration (CI):**
  - Code tested with `pytest`.
  - Code quality checked with `pylint`.
  - GitHub Actions workflow runs automatically on each push/PR to enforce lint & tests.

- **Continuous Delivery (CD):**
  - Azure Pipelines build and package the application.
  - Automatic deployment to Azure App Service.
  - Deployment verified with `curl` and browser access.

---

## Architectural Diagram
```mermaid
flowchart LR
    A[GitHub Repo] -->|Push Code| B[GitHub Actions: CI]
    B -->|Build + Lint + Test| C[Azure Pipelines: CD]
    C -->|Deploy App| D[Azure App Service]
    D -->|Access| E[Browser / curl]

# Project Management

- Trello Board:[CI/CD Pipeline Project Trello Board](https://trello.com/invite/b/68bdf6f0d4f3624dcd1caa4f/ATTI793a346e5d601a2e966a8a1683ede3bcC5C83614/ci-cd-pipeline-project)  
- Spreadsheet: [ci_cd_tasks.xlsx](https://docs.google.com/spreadsheets/d/195USB3uK46NjKlYLbJAeFR8yt1A4te37/edit?usp=sharing&ouid=107624253403469308209&rtpof=true&sd=true)  
- Demo Video: [YouTube Link Here]()
