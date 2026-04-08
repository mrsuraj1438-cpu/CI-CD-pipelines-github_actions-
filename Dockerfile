# Use smaller & safer base
FROM python:3.11-alpine

WORKDIR /app

# Copy only requirements first (better caching)
COPY requirements.txt .

# Install dependencies (clean)
RUN pip install --no-cache-dir -r requirements.txt

# Copy app code
COPY . .

# Run as non-root (security best practice)
RUN adduser -D appuser
USER appuser

EXPOSE 80

CMD ["python", "app.py"]