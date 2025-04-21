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

# Set environment variables
ENV VIRUSTOTAL_API_KEY="7374c808abccce2b73e1033bfe96f1a8fd47acf887252b348fbf38c2ca1d3114"

# Set the entrypoint to run your server
ENTRYPOINT ["python", "server.py"]
