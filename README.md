# Docker Discord Bot - Whiteout Survival

A Docker containerization setup for the Whiteout Survival Discord Bot. This project provides an easy way to build, deploy, and run the Discord bot in a containerized environment.

## Overview

This repository contains the Docker configuration for the Whiteout Survival Discord Bot. The bot is cloned from the [Whiteout Survival Discord Bot repository](https://github.com/Reloisback/Whiteout-Survival-Discord-Bot) and containerized using Docker.

## Features

- 🐳 Dockerized Discord bot with Python 3.12
- 👤 Non-root user execution for security
- 📦 Pre-configured with all required dependencies

## Prerequisites

- Docker installed and running

## Quick Start

### Building the Docker Image

```bash
docker build -t discord-bot-wos .
```

To build without cache:

```bash
docker build --no-cache -t discord-bot-wos .
```

### Running the Container

```bash
docker run -d \
  --name discord-bot-wos \
  -e PUID=1000 \
  -e PGID=1000 \
  discord-bot-wos
```

**Note:** You'll need to provide environment variables for the bot to function (e.g., Discord bot token). See the [Configuration](#configuration) section below.

## Configuration

The bot requires environment variables to run. You can provide them using:

### Environment File

Create a `.env` file or pass environment variables when running:

```bash
docker run -d \
  --name discord-bot-wos \
  --env-file .env \
  discord-bot-wos
```

### Required Environment Variables

Check the original bot repository for required environment variables. Common ones include:
- Discord bot token
- Database connection strings (if applicable)
- API keys (if applicable)

## Project Structure

```
.
├── Dockerfile          # Docker image configuration
├── LICENSE            # MIT License
└── README.md          # This file
```

## Docker Image Details

- **Base Image:** `python:3.12-slim`
- **Working Directory:** `/app`
- **User:** `bot` (non-root, UID/GID configurable via `PUID`/`PGID`)
- **Default Command:** `python3 main.py`

### Installed Dependencies

- discord.py
- colorama
- requests
- aiohttp
- python-dotenv
- aiohttp-socks
- pytz
- pyzipper

## Customization

### Changing User/Group IDs

Set `PUID` and `PGID` environment variables when building or running:

```bash
docker build --build-arg PUID=1000 --build-arg PGID=1000 -t discord-bot-wos .
```

Or when running:

```bash
docker run -e PUID=1000 -e PGID=1000 discord-bot-wos
```

### Changing the Bot Repository

Edit the `Dockerfile` and update the git clone URL:

```dockerfile
RUN git clone https://github.com/YOUR_USERNAME/YOUR_REPO.git /app && \
    rm -rf /app/.git
```

## Troubleshooting

### Container exits immediately

- Check if required environment variables are set
- Verify the bot's main.py file exists in the cloned repository
- Check container logs: `docker logs discord-bot-wos`

### Permission issues

- Ensure `PUID` and `PGID` match your system user/group IDs
- Check file permissions in the mounted volumes (if any)

### Build failures

- Ensure you have internet access (clones from GitHub)
- Check Docker daemon is running
- Try building with `--no-cache` flag

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test the Docker build
5. Submit a pull request

## Related Projects

- [Whiteout Survival Discord Bot](https://github.com/Reloisback/Whiteout-Survival-Discord-Bot) - The original bot repository

## Support

For issues related to:
- **Docker setup:** Open an issue in this repository
- **Bot functionality:** Refer to the original bot repository

---

**Note:** This is a Docker wrapper for the Whiteout Survival Discord Bot. For bot-specific features, commands, and documentation, please refer to the original repository.

