FROM python:3.12-slim

RUN mkdir -p /app && \
cd /app && \
apt update && \
apt install -y git && \
apt clean && \
git clone https://github.com/rhasspy/piper && \
cd piper && \
rm -rf .git

WORKDIR /app/piper/src/python_run

RUN pip install --no-cache-dir --upgrade pip && \
pip install --no-cache-dir -e . && \
pip install --no-cache-dir -r requirements.txt && \
pip install --no-cache-dir -r requirements_http.txt && \
pip install --no-cache-dir wget

EXPOSE 5000

CMD ["python", "-m", "piper.http_server", "-m", "/app/models/model.onnx"]