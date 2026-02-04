FROM python:3.11-slim

# Sécurité : ne pas tourner en root
RUN useradd -m appuser

WORKDIR /app

# Copier uniquement les dépendances d'abord (cache Docker)
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# Copier le code applicatif
COPY app/ app/

# Droits utilisateur
RUN chown -R appuser:appuser /app
USER appuser

EXPOSE 5000

CMD ["python", "-m", "app.app"]
