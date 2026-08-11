#!/bin/bash

# Exit on error
set -e

echo "[Entrypoint] Verificando conexão com o Banco de Dados..."

# Se um comando explícito for passado (ex.: celery worker), executa-o diretamente.
# Permite que serviços como celery_worker reutilizem este mesmo entrypoint
# em vez de executarem o servidor web.
if [ $# -gt 0 ]; then
    echo "[Entrypoint] Executando comando: $*"
    exec "$@"
fi

echo "[Entrypoint] Base de dados pronta!"

echo "[Entrypoint] Aplicando migrações..."
python manage.py migrate --noinput

echo "[Entrypoint] Coletando arquivos estáticos..."
python manage.py collectstatic --noinput

# O modo (dev/prod) é decidido unicamente pela variável de ambiente DJANGO_ENV.
if [ "$DJANGO_ENV" = "production" ]; then
    echo "[Entrypoint] Iniciando Gunicorn em modo produção..."
    exec gunicorn core.wsgi:application --bind 0.0.0.0:"${WEB_PORT:-8000}" --workers "${GUNICORN_WORKERS:-3}"
else
    echo "[Entrypoint] Iniciando servidor de desenvolvimento Django (runserver)..."
    exec python manage.py runserver 0.0.0.0:"${WEB_PORT:-8000}"
fi
