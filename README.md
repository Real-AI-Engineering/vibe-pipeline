# Vibe Pipeline

A development pipeline repository with integrated Claude Code support for AI-assisted development workflows.

## Features

- **Claude Code Integration**: AI-powered development assistance through GitHub Actions
- **DevContainer Support**: Fully configured development environment with VS Code extensions
- **Docker Development Container**: Convenient Claude Code development setup with automatic mounting
- **Automated Workflows**: GitHub Actions for continuous integration and code review

## Getting Started

### Prerequisites

- Docker (for DevContainer and Docker development setup)
- VS Code with Remote-Containers extension (recommended)
- Claude Code configured locally (`~/.claude` directory and `~/.claude.json` file)
- Git
- SSH keys in `~/.ssh` (optional, for Git operations)

### Development Environment Options

#### Option 1: VS Code DevContainer (Recommended)

This repository includes a pre-configured DevContainer for consistent development experience:

1. **Clone the repository**:
   ```bash
   git clone https://github.com/Real-AI-Engineering/vibe-pipeline.git
   cd vibe-pipeline
   ```

2. **Open in DevContainer**:
   - Open the repository in VS Code
   - When prompted, click "Reopen in Container" or use Command Palette: `Remote-Containers: Reopen in Container`

#### Option 2: Docker Development Container

For a lightweight CLI-focused development environment:

##### Start development container with current directory:
```bash
./dev.sh
```

##### Start development container with specific project directory:
```bash
./dev.sh /path/to/your/project
```

## Docker Development Container Features

- **Auto-mounting**: Automatically mounts your Claude configuration, SSH keys, and project directory
- **Docker Hub**: Pre-built images available at `realaiengineering/claude-dev`
- **Security**: Claude and SSH configurations mounted read-only for safety
- **Persistence**: Bash history persisted across container restarts
- **Container Details**:
  - **Base**: Node.js 20
  - **Shell**: Zsh with Oh My Zsh and Powerlevel10k theme
  - **Tools**: Git, GitHub CLI, FZF, Delta, and development essentials
  - **Claude Code**: Latest version pre-installed
  - **Security**: Built-in firewall with allowlist for essential services

### Development Scripts

#### `dev.sh`
Main script to launch the development container. Pulls the latest image from Docker Hub and starts an interactive shell.

#### `build-and-push.sh`
Build and publish the container image to Docker Hub (for maintainers).

## Claude Code Integration

This repository is configured with Claude Code for AI-assisted development:

### Using Claude

- **In Issues**: Mention `@claude` in issue comments to get AI assistance
- **In Pull Requests**: Use `@claude` in PR comments for code review and suggestions
- **Supported Actions**: Code review, bug fixes, feature implementation, documentation updates

### Examples

```
@claude review this code for potential issues
@claude implement user authentication
@claude update the documentation
@claude fix the failing tests
```

## Configuration

### DevContainer Settings

The VS Code DevContainer includes:
- Node.js environment with 4GB memory allocation
- VS Code extensions for ESLint, Prettier, and GitLens
- Zsh shell with Git integration disabled for performance
- Persistent volumes for bash history and Claude configuration

### Docker Development Container Mounts

The Docker container mounts the following directories from your host:

- `~/.claude` → `/home/node/.claude` (read-only)
- `~/.claude.json` → `/home/node/.claude.json` (read-only)
- `~/.ssh` → `/home/node/.ssh` (read-only)
- Project directory → `/workspace`

### GitHub Actions

- **Claude Code**: Automated AI assistance triggered by `@claude` mentions
- **Permissions**: Read access to contents, pull requests, and issues
- **Model**: Claude Sonnet 4 (configurable to Claude Opus 4.1)
- **Automatic Builds**: Container images are automatically built and published to Docker Hub when changes are made to `.devcontainer/` files

## Repository Structure

```
vibe-pipeline/
├── .devcontainer/          # DevContainer configuration
│   ├── devcontainer.json   # Container settings and VS Code config
│   ├── Dockerfile          # Development environment setup
│   └── init-firewall.sh    # Network configuration script
├── .github/
│   ├── actions/            # Reusable GitHub Actions
│   ├── workflow-templates/ # Workflow templates for common CI/CD patterns
│   └── workflows/          # GitHub Actions workflows
│       ├── claude.yml      # Claude Code integration
│       └── docker-publish.yml  # Automated Docker image publishing
├── dev.sh                  # Quick Docker development container launcher
├── build-and-push.sh      # Docker image build and publish script
└── README.md               # This file
```

## Troubleshooting

### DevContainer Issues
- Ensure Docker is running before opening in VS Code
- If container fails to start, try rebuilding: Command Palette → `Remote-Containers: Rebuild Container`

### Docker Development Container Issues

#### Missing Claude configuration
If you see warnings about missing `~/.claude` or `~/.claude.json`, ensure you have Claude Code configured on your host system first.

#### Docker Hub pull fails
If the image pull fails, the script will automatically fall back to building locally using the Dockerfile in `.devcontainer/`.

## Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature-name`
3. Make your changes using either development environment option
4. Commit with descriptive messages
5. Push to your fork and submit a pull request

## License

This project is part of Real-AI-Engineering organization. Please refer to the organization's licensing terms.

## Support

For issues related to:
- **Repository**: Create an issue in this repository
- **Claude Code**: Check the [Claude Code documentation](https://docs.anthropic.com/en/docs/claude-code)
- **DevContainer**: Refer to VS Code DevContainer documentation
- **Docker Development Setup**: Check the troubleshooting section above
