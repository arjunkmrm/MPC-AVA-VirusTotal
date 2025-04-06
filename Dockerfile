# Use the official Python image as the base image
FROM python:3.12-alpine

# Set the working directory
WORKDIR /app

# Install required dependencies
RUN pip install --no-cache-dir aiohttp python-dotenv mcp

# Copy your server file into the container
COPY server.py /app/

# Copy the .env file into the container
COPY .env /app/.env

# Expose the port used by your server (adjust if needed)
EXPOSE 8020

# Set the entrypoint to run your server
ENTRYPOINT ["python", "server.py"]
