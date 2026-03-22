# LITI Open Source - Self-hosted Psycholinguistic HR Analysis Tool
# Optimized for Railway deployment with persistent volume

FROM python:3.11-slim

WORKDIR /app

# Copy requirements first for better caching
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY . .

# Backup default data (prompts.json) so it survives volume mount
RUN mkdir -p /app/data-defaults && cp /app/data/prompts.json /app/data-defaults/prompts.json

# Create data directory (will be replaced by Railway volume)
RUN mkdir -p /app/data

# Fix line endings (GitHub web editor adds CRLF) and make executable
RUN sed -i 's/\r$//' /app/entrypoint.sh && chmod +x /app/entrypoint.sh

EXPOSE 8080
ENV PORT=8080

# Use entrypoint that ensures defaults are copied to volume
CMD ["/app/entrypoint.sh"]
