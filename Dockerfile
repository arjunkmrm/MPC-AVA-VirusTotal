# Build stage
FROM python:3.12-alpine AS builder

WORKDIR /app

# Install build dependencies including Rust
RUN apk add --no-cache \
    gcc \
    musl-dev \
    python3-dev \
    cargo \
    rust \
    openssl-dev

# Copy requirements first to leverage Docker cache
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Final stage
FROM python:3.12-alpine

WORKDIR /app

# Copy only necessary files from builder
COPY --from=builder /usr/local/lib/python3.12/site-packages /usr/local/lib/python3.12/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin

# Copy application files
COPY server.py .

# Create non-root user
RUN adduser -D appuser && chown -R appuser:appuser /app
USER appuser

# Expose port
EXPOSE 8020

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# Entrypoint
ENTRYPOINT ["python", "server.py"]
