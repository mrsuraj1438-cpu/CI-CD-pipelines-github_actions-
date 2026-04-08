# -------- Stage 1: Build --------
FROM python:3.11-slim AS builder

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir --user -r requirements.txt --target=/app/package

COPY . .

# -------- Stage 2: Distroless --------
FROM gcr.io/distroless/python3

WORKDIR /app

# Copy installed packages
COPY --from=builder /app/package /app/package

# Copy app code
COPY --from=builder /app /app

# Set PATH for packages
ENV PYTHONPATH=/app/package

ENV PYTHONUNBUFFERED=1

EXPOSE 80

CMD ["app.py"]