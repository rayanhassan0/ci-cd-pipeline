#!/usr/bin/env bash
set -euo pipefail

# ========= Variables =========
APP="rayan-ci-cd-app-we"
RG="ci-cd-rg-we"

echo "== CI locally / in Cloud Shell =="
make all

echo "== Test /predict endpoint =="
curl -s -X POST "https://${APP}.azurewebsites.net/predict" \
  -H "Content-Type: application/json" \
  -d '{"data":[1,2,3,4]}' | tee /dev/stderr

echo "== Create clean zip from current HEAD =="
git archive -o app.zip HEAD

# ========= Option A: Quick create (first time) =========
# NOTE: Only needed the very first time to create the Web App quickly.
# az webapp up -n "${APP}" -g "${RG}" -l "westeurope" -p "${APP}-plan" --runtime "PYTHON:3.10"

# ========= Option B: Deploy existing app (Zip Deploy) =========
echo "== Deploying zip to Azure Web App =="
az webapp deploy \
  --resource-group "${RG}" \
  --name "${APP}" \
  --src-path app.zip \
  --type zip \
  --clean true \
  --restart true

echo "== Ensure runtime settings (port + startup) =="
az webapp config appsettings set -g "${RG}" -n "${APP}" \
  --settings WEBSITES_PORT=8000

az webapp config set -g "${RG}" -n "${APP}" \
  --startup-file "bash -c 'cd /home/site/wwwroot && python -m pip install -r requirements.txt && gunicorn --bind 0.0.0.0:8000 --timeout 600 hello:app'"

echo "== Restart app =="
az webapp restart -g "${RG}" -n "${APP}"

echo "== Verify homepage contains CD header =="
curl -s "https://${APP}.azurewebsites.net/" | head -n 20

echo "== Verify /predict again =="
curl -s -X POST "https://${APP}.azurewebsites.net/predict" \
  -H "Content-Type: application/json" \
  -d '{"data":[1,2,3,4]}'
echo
