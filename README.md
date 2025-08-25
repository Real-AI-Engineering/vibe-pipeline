# Vibe Pipeline

A development pipeline repository with integrated Claude Code support for AI-assisted development workflows.

## Features

- **Claude Code Integration**: AI-powered development assistance through GitHub Actions
- **DevContainer Support**: Fully configured development environment with VS Code extensions
- **Automated Workflows**: GitHub Actions for continuous integration and code review

## Getting Started

### Prerequisites

- Docker (for DevContainer)
- VS Code with Remote-Containers extension (recommended)
- Git

### Development Environment

This repository includes a pre-configured DevContainer for consistent development experience:

1. **Clone the repository**:
   ```bash
   git clone https://github.com/Real-AI-Engineering/vibe-pipeline.git
   cd vibe-pipeline
   ```

2. **Open in DevContainer**:
   - Open the repository in VS Code
   - When prompted, click "Reopen in Container" or use Command Palette: `Remote-Containers: Reopen in Container`

3. **DevContainer Features**:
   - Pre-installed Claude Code
   - ESLint and Prettier for code formatting
   - GitLens for enhanced Git integration
   - Zsh terminal with optimized configuration
   - Network capabilities for development tools

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

## Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature-name`
3. Make your changes
4. Commit with descriptive messages
5. Push to your fork and submit a pull request

## Repository Structure

```
vibe-pipeline/
├── .devcontainer/          # DevContainer configuration
│   ├── devcontainer.json   # Container settings and VS Code config
│   ├── Dockerfile          # Development environment setup
│   └── init-firewall.sh    # Network configuration script
├── .github/
│   └── workflows/          # GitHub Actions workflows
│       ├── claude.yml      # Claude Code integration
│       └── claude-code-review.yml  # Automated code review
└── README.md               # This file
```

## Configuration

### DevContainer Settings

The DevContainer includes:
- Node.js environment with 4GB memory allocation
- VS Code extensions for ESLint, Prettier, and GitLens
- Zsh shell with Git integration disabled for performance
- Persistent volumes for bash history and Claude configuration

### GitHub Actions

- **Claude Code**: Automated AI assistance triggered by `@claude` mentions
- **Permissions**: Read access to contents, pull requests, and issues
- **Model**: Claude Sonnet 4 (configurable to Claude Opus 4.1)

## License

This project is part of Real-AI-Engineering organization. Please refer to the organization's licensing terms.

## Support

For issues related to:
- **Repository**: Create an issue in this repository
- **Claude Code**: Check the [Claude Code documentation](https://docs.anthropic.com/en/docs/claude-code)
- **DevContainer**: Refer to VS Code DevContainer documentation
