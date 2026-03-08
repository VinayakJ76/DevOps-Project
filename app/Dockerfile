FROM python:3.9-slim

WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application source
COPY src ./src

# Ensure Python can find the app modules
ENV PYTHONPATH=/app/src

# Application port
EXPOSE 5000

# Optional non-root user (kept commented like original)
# RUN adduser -D appuser
# USER appuser

# Start the application
ENTRYPOINT ["python", "src/run.py"]