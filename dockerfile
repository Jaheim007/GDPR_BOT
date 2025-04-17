# 1) Start from slim Python
FROM python:3.11-slim

# 2) Prevent prompts during package installs
ENV DEBIAN_FRONTEND=noninteractive

# 3) Install wkhtmltopdf + required libs
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      wkhtmltopdf \
      libxrender1 \
      libfontconfig1 && \
    rm -rf /var/lib/apt/lists/*

# 4) Set working dir
WORKDIR /app

# 5) Copy & install Python deps
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 6) Copy your bot code
COPY . .

# 7) (Optional) If you read WKHTMLTOPDF_PATH from env, set default here:
# ENV WKHTMLTOPDF_PATH=/usr/bin/wkhtmltopdf

# 8) Expose no ports (bot is outgoing only), but declare a volume if you want to persist reports:
# VOLUME /app/static/reports

# 9) Run your bot
CMD ["python", "rgpdbot2.py"]
