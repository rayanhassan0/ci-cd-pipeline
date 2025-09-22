#!/usr/bin/env bash
set -e

# متغيرات
APP="rayan-ci-cd-app-we"
RG="ci-cd-rg-we"

# تهيئة وتشغيل محلي (Cloud Shell)
make all

# اختبار الـ API
curl -s -X POST "https://$APP.azurewebsites.net/predict" \
  -H "Content-Type: application/json" \
  -d '{"data":[1,2,3,4]}'

# إعدادات App Service (تُشغّل مرة واحدة فقط)
az webapp config appsettings set -g "$RG" -n "$APP" \
  --settings SCM_DO_BUILD_DURING_DEPLOYMENT=true

az webapp config set -g "$RG" -n "$APP" \
  --startup-file "bash -c 'cd /home/site/wwwroot && python -m pip install -r requirements.txt && gunicorn --bind=0.0.0.0:8000 --timeout 600 hello:app'"

# إعادة التشغيل
az webapp restart -g "$RG" -n "$APP"
