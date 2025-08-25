# GitHub Actions Templates

This repository provides reusable GitHub Actions templates and composite actions for various programming languages and common CI/CD tasks.

## 🎯 Quick Start

### Using Composite Actions

Reference our composite actions directly in your workflows:

```yaml
# Use Python setup action
- uses: Real-AI-Engineering/vibe-pipeline/.github/actions/setup-python@main
  with:
    python-version: '3.12'
    install-dev-deps: 'true'

# Use Go setup action
- uses: Real-AI-Engineering/vibe-pipeline/.github/actions/setup-go@main
  with:
    go-version: '1.25'
    install-tools: 'true'

# Use Docker build action
- uses: Real-AI-Engineering/vibe-pipeline/.github/actions/docker-build@main
  with:
    image-name: 'myorg/myapp'
    registry-username: ${{ secrets.DOCKERHUB_USERNAME }}
    registry-password: ${{ secrets.DOCKERHUB_TOKEN }}
```

### Using Workflow Templates

Copy our complete workflow templates to your repository:

1. **Via GitHub UI**: Go to Actions → New Workflow → search for templates from this repo
2. **Via GitHub CLI**:
   ```bash
   gh workflow init --repo Real-AI-Engineering/vibe-pipeline
   ```
3. **Manual Copy**: Copy workflow files from `.github/workflow-templates/` to your `.github/workflows/`

### Using Reusable Workflows

Call our workflows from your repository:

```yaml
name: Python CI
on: [push, pull_request]

jobs:
  python-ci:
    uses: Real-AI-Engineering/vibe-pipeline/.github/workflows/python-ci.yml@main
    with:
      python-version: '3.12'
    secrets:
      ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}
```

## 📚 Available Components

### Composite Actions

| Action | Description | Inputs |
|--------|-------------|---------|
| [`setup-python`](.github/actions/setup-python) | Python environment setup with caching | `python-version`, `install-dev-deps`, `working-directory` |
| [`setup-go`](.github/actions/setup-go) | Go environment setup with modules caching | `go-version`, `install-tools`, `working-directory` |
| [`setup-node`](.github/actions/setup-node) | Node.js setup with package manager detection | `node-version`, `package-manager`, `install-dev-deps` |
| [`setup-rust`](.github/actions/setup-rust) | Rust toolchain setup with cargo caching | `rust-version`, `components`, `targets`, `install-tools` |
| [`claude-code`](.github/actions/claude-code) | Claude Code AI integration | `anthropic-api-key`, `model`, `trigger-phrase` |
| [`docker-build`](.github/actions/docker-build) | Docker build and push with multi-arch support | `image-name`, `platforms`, `registry-username` |

### Workflow Templates

| Template | Language | Features |
|----------|----------|-----------|
| [`python-ci.yml`](.github/workflow-templates/python-ci.yml) | Python 3.12 | Ruff, Black, MyPy, Pytest, Bandit, Safety |
| [`go-ci.yml`](.github/workflow-templates/go-ci.yml) | Go 1.25 | gofmt, golangci-lint, gosec, govulncheck |
| [`node-ci.yml`](.github/workflow-templates/node-ci.yml) | Node.js 20 | ESLint, Prettier, TypeScript, Jest/Vitest |
| [`rust-ci.yml`](.github/workflow-templates/rust-ci.yml) | Rust stable | rustfmt, clippy, cargo-audit, cross-compilation |
| [`claude-code.yml`](.github/workflow-templates/claude-code.yml) | Any | AI-powered code assistance |
| [`docker-publish.yml`](.github/workflow-templates/docker-publish.yml) | Any | Multi-platform Docker builds |

## 🔧 Detailed Usage

### Python Projects

```yaml
name: Python CI
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Python
        uses: Real-AI-Engineering/vibe-pipeline/.github/actions/setup-python@main
        with:
          python-version: '3.12'
          install-dev-deps: 'true'
          
      - name: Run tests
        run: pytest --cov=. --cov-report=xml
```

### Go Projects

```yaml
name: Go CI
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Go
        uses: Real-AI-Engineering/vibe-pipeline/.github/actions/setup-go@main
        with:
          go-version: '1.25'
          install-tools: 'true'
          
      - name: Run tests
        run: go test -v -race -coverprofile=coverage.out ./...
```

### Node.js Projects

```yaml
name: Node.js CI
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Node.js
        uses: Real-AI-Engineering/vibe-pipeline/.github/actions/setup-node@main
        with:
          node-version: '20'
          package-manager: 'npm'  # or 'yarn', 'pnpm'
          
      - name: Run tests
        run: npm test
```

### Rust Projects

```yaml
name: Rust CI
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Rust
        uses: Real-AI-Engineering/vibe-pipeline/.github/actions/setup-rust@main
        with:
          rust-version: 'stable'
          components: 'clippy,rustfmt'
          
      - name: Run tests
        run: cargo test --all-features
```

### Docker Projects

```yaml
name: Docker Build
on: [push, pull_request]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Build and Push
        uses: Real-AI-Engineering/vibe-pipeline/.github/actions/docker-build@main
        with:
          image-name: 'myorg/myapp'
          platforms: 'linux/amd64,linux/arm64'
          registry-username: ${{ secrets.DOCKERHUB_USERNAME }}
          registry-password: ${{ secrets.DOCKERHUB_TOKEN }}
          push: ${{ github.event_name != 'pull_request' }}
```

### Claude Code Integration

```yaml
name: Claude Code
on:
  issue_comment:
    types: [created]

jobs:
  claude:
    if: contains(github.event.comment.body, '@claude')
    runs-on: ubuntu-latest
    permissions:
      contents: write
      pull-requests: write
      issues: write
    steps:
      - name: Run Claude Code
        uses: Real-AI-Engineering/vibe-pipeline/.github/actions/claude-code@main
        with:
          anthropic-api-key: ${{ secrets.ANTHROPIC_API_KEY }}
          model: 'claude-sonnet-4'
          custom-instructions: |
            Follow our coding standards.
            Ensure all code has tests.
```

## 🏷️ Versioning

We recommend using specific versions for production:

```yaml
# Use specific version (recommended for production)
- uses: Real-AI-Engineering/vibe-pipeline/.github/actions/setup-python@v1.0.0

# Use latest main branch (for development)
- uses: Real-AI-Engineering/vibe-pipeline/.github/actions/setup-python@main

# Use specific commit (maximum stability)
- uses: Real-AI-Engineering/vibe-pipeline/.github/actions/setup-python@abc1234
```

## 🔒 Security Features

All templates include security scanning:

- **Python**: Bandit (SAST), Safety (dependency vulnerabilities)
- **Go**: gosec (SAST), govulncheck (vulnerabilities), nancy (dependencies)
- **Node.js**: npm audit, Snyk security scanning
- **Rust**: cargo-audit, cargo-deny, cargo-geiger (unsafe code detection)
- **Docker**: Multi-stage builds, security scanning via registry

## ⚡ Performance Features

- **Intelligent Caching**: All actions use optimized caching strategies
- **Parallel Execution**: Matrix builds for multiple language versions
- **Incremental Builds**: Docker layer caching, dependency caching
- **Fast Feedback**: Early failure detection, parallel job execution

## 🤝 Contributing

1. Fork this repository
2. Create a feature branch: `git checkout -b my-feature`
3. Add your changes and tests
4. Submit a pull request

### Adding New Language Support

1. Create composite action in `.github/actions/setup-{language}/`
2. Create workflow template in `.github/workflow-templates/{language}-ci.yml`
3. Add properties file: `.github/workflow-templates/{language}-ci.properties.json`
4. Update this documentation

## 📝 License

MIT License - see [LICENSE](LICENSE) file for details.

## 🆘 Support

- 📖 Documentation: See individual action README files
- 🐛 Issues: [GitHub Issues](https://github.com/Real-AI-Engineering/vibe-pipeline/issues)
- 💬 Discussions: [GitHub Discussions](https://github.com/Real-AI-Engineering/vibe-pipeline/discussions)

---

Made with ❤️ by [Real AI Engineering](https://github.com/Real-AI-Engineering)