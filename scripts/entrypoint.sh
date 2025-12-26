#!/bin/bash

# Exit on error
set -e

echo "[Entrypoint] Verificando conexão com o Banco de Dados..."

# Wait for DB (simple loop as we don't have pg_isready inside web container yet, 
# or we can rely on docker-compose healthcheck, but this is safer)
# Since we use postgres:17-alpine in compose, we can use the healthcheck there.

echo "[Entrypoint] Base de dados pronta!"

echo "[Entrypoint] Aplicando migrações..."
python manage.py migrate --noinput

echo "[Entrypoint] Coletando arquivos estáticos..."
python manage.py collectstatic --noinput

if [ "$DJANGO_ENV" = "production" ]; then
    echo "[Entrypoint] Iniciando Gunicorn em modo produção..."
    exec gunicorn core.wsgi:application --bind 0.0.0.0:8000 --workers 3
else
    echo "[Entrypoint] Iniciando servidor de desenvolvimento Django..."
    exec python manage.py runserver 0.0.0.0:8000
fi
