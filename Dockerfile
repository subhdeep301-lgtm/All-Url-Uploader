# FROM python:3.9

# RUN apt-get update -y && apt-get upgrade -y
# RUN apt-get install ffmpeg -y

# WORKDIR .
# COPY . .

# RUN pip3 install --no-cache-dir -r requirements.txt

# CMD ["python3", "bot.py"]



###############################



# Dockerfile (replace your current one)
FROM python:3.9-slim

# Prevent interactive prompts during apt
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
ARG PORT=8080

WORKDIR /app

# Install minimal ffmpeg (no recommended packages), then clean up
RUN apt-get update \
 && apt-get install -y --no-install-recommends ffmpeg \
 && apt-get purge -y --auto-remove \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy app
COPY . /app

# Install Python deps
RUN pip3 install --no-cache-dir -r requirements.txt

# Document port (Render sets $PORT at runtime)
EXPOSE 8080

CMD ["python3", "bot.py"]

