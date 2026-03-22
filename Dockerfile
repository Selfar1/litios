FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Backup prompts.json so it survives Railway volume mount on /app/data
RUN mkdir -p /app/data-defaults && cp /app/data/prompts.json /app/data-defaults/prompts.json

RUN mkdir -p /app/data

EXPOSE 8080

CMD ["gunicorn", "--bind", "0.0.0.0:8080", "--workers", "1", "--threads", "8", "--timeout", "0", "server:app"]
