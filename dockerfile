# Verwende Debian 12 (Bookworm) als Basis-Image
FROM debian:12-slim

# Setze Umgebungsvariablen
ENV PYTHONUNBUFFERED=1

# Aktualisiere das System und installiere benötigte Pakete
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    && rm -rf /var/lib/apt/lists/*

# Setze das Arbeitsverzeichnis im Container
WORKDIR /app

# Kopiere lokale Dateien in das Arbeitsverzeichnis im Container
COPY . .

# Erstelle und aktiviere eine virtuelle Umgebung
RUN python3 -m venv venv
ENV PATH="/app/venv/bin:$PATH"

# Installiere die Python-Abhängigkeiten
RUN venv/bin/pip3 install --upgrade pip && \
    venv/bin/pip3 install --no-cache-dir -r requirements.txt && \
    venv/bin/pip3 install -Iv discord.py==1.7.3

# Führe den Bot aus
CMD ["python3", "-m", "Source", "rss"]