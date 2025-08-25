# Claude Code Development Container

A convenient development container setup for [Claude Code](https://claude.ai/code) with automatic mounting of Claude configuration, SSH keys, and project directories.

## Quick Start

### Prerequisites

- Docker installed and running
- Claude Code configured locally (`~/.claude` directory and `~/.claude.json` file)
- SSH keys in `~/.ssh` (optional, for Git operations)

### Usage

#### Start development container with current directory:
```bash
./dev.sh
```

#### Start development container with specific project directory:
```bash
./dev.sh /path/to/your/project
```

## Features

- **Auto-mounting**: Automatically mounts your Claude configuration, SSH keys, and project directory
- **Docker Hub**: Pre-built images available at `realaiengineering/claude-dev`
- **Security**: Claude and SSH configurations mounted read-only
- **Persistence**: Bash history persisted across container restarts
- **Network capabilities**: Includes firewall configuration for secure development

## Scripts

### `dev.sh`
Main script to launch the development container. Pulls the latest image from Docker Hub and starts an interactive shell.

### `build-and-push.sh`
Build and publish the container image to Docker Hub (for maintainers).

## Container Details

- **Base**: Node.js 20
- **Shell**: Zsh with Oh My Zsh and Powerlevel10k theme
- **Tools**: Git, GitHub CLI, FZF, Delta, and development essentials
- **Claude Code**: Latest version pre-installed
- **Security**: Built-in firewall with allowlist for essential services

## Automatic Builds

Container images are automatically built and published to Docker Hub when changes are made to `.devcontainer/` files via GitHub Actions.

## Configuration

The container mounts the following directories from your host:

- `~/.claude` → `/home/node/.claude` (read-only)
- `~/.claude.json` → `/home/node/.claude.json` (read-only)
- `~/.ssh` → `/home/node/.ssh` (read-only)
- Project directory → `/workspace`

## Troubleshooting

### Missing Claude configuration
If you see warnings about missing `~/.claude` or `~/.claude.json`, ensure you have Claude Code configured on your host system first.

### Docker Hub pull fails
If the image pull fails, the script will automatically fall back to building locally using the Dockerfile in `.devcontainer/`.
