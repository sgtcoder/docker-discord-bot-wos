# Use a lightweight official Python base
FROM python:3.12-slim

# Prevent Python from writing .pyc files and enable unbuffered logs
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PUID=1000
ENV PGID=1000

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    && rm -rf /var/lib/apt/lists/*

# Clone the bot repository to /app and remove .git folder to reduce image size
RUN git clone https://github.com/Reloisback/Whiteout-Survival-Discord-Bot.git /app && \
    rm -rf /app/.git

# Create bot user and group with specified UID/GID (use existing /app as home)
RUN groupadd -g $PGID bot && \
    useradd -u $PUID -g $PGID -d /app -s /bin/bash bot

# Set working directory
WORKDIR /app

# Change ownership of /app to bot user
RUN chown -R bot:bot /app

# Upgrade pip and install setuptools (provides pkg_resources)
RUN pip install --no-cache-dir --upgrade pip setuptools

# Install bot dependencies
RUN pip install --no-cache-dir \
    discord.py \
    colorama \
    requests \
    aiohttp \
    python-dotenv \
    aiohttp-socks \
    pytz \
    pyzipper

## Cleanup ##
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Switch to bot user
USER bot

# Default command to start the bot
CMD ["python3", "main.py"]
