FROM python:3.12-alpine

WORKDIR /app

RUN pip install --no-cache-dir aiohttp python-dotenv mcp


COPY server.py /app/


COPY .env /app/.env


EXPOSE 8020


ENV VIRUSTOTAL_API_KEY="VIRUSTOTAL_API_KEY"

ENTRYPOINT ["python", "server.py"]
