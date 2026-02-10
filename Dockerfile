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

FROM jenkins/jenkins:lts

USER root

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    git \
    curl \
    unzip \
 && rm -rf /var/lib/apt/lists/*

# Sonar Scanner
RUN curl -fsSL https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-5.0.1.3006-linux.zip \
    -o sonar-scanner.zip \
 && unzip sonar-scanner.zip \
 && mv sonar-scanner-* /opt/sonar-scanner \
 && ln -s /opt/sonar-scanner/bin/sonar-scanner /usr/local/bin/sonar-scanner \
 && rm sonar-scanner.zip

USER jenkins
