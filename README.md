# Generate System

A comprehensive template generation system for creating various files and project structures with intelligent smart append functionality.

## Installation

1. Make the main script executable:
```bash
chmod +x generate/generate
```

2. Create a symbolic link to make it available system-wide:
```bash
sudo ln -sf "$(pwd)/generate/generate" /usr/local/bin/generate
```

## Usage

```bash
generate <type> [options]
```

### Smart Append Feature ✨

The smart append feature automatically generates related templates, configurations, and directory structures based on the technology you specify. Simply use:

```bash
generate <technology> [project-name] [options]
```

**Available Smart Append Commands:**

#### Frontend Technologies
```bash
generate electron my-app          # Electron app + Node gitignore + ESLint + Prettier + VS Code config
generate react my-frontend        # React frontend + React gitignore + ESLint + Prettier + VS Code config
generate nextjs my-fullstack      # Next.js fullstack + Next.js gitignore + ESLint + Prettier + VS Code config
```

#### Backend Technologies
```bash
generate python my-backend        # Python project + Python gitignore + VS Code config
generate fastapi my-api          # FastAPI backend + FastAPI gitignore + Docker + VS Code config
generate node my-server          # Node.js project + Node gitignore + ESLint + Prettier + VS Code config
```

#### Full-Stack & Complex Setups
```bash
generate microservices my-stack   # Microservices + Docker + Kubernetes + Monitoring configs
generate fullstack my-app        # Next.js + FastAPI + Docker + All configs
generate docker my-project       # Docker configs + Docker gitignore
```

**Smart Append Options:**
- `--dry-run` - Show what would be generated without creating files
- `-o, --output <path>` - Specify output directory

**Examples:**
```bash
# See what would be generated
generate electron --dry-run

# Create Electron app in specific directory
generate electron my-app -o ./projects/

# Create full-stack setup with custom name
generate fullstack awesome-app
```

### Traditional Commands

#### GitIgnore Generation
Generate `.gitignore` files for various languages and frameworks:

```bash
generate gitignore <language>
```

**Available languages:**
- `python` - Python projects
- `node` - Node.js projects  
- `react` - React applications
- `nextjs` - Next.js applications
- `fastapi` - FastAPI backend projects
- `java` - Java projects
- `go` - Go projects
- `rust` - Rust projects
- `csharp` - C# projects
- `cpp` - C++ projects
- `macos` - macOS specific files
- `docker` - Docker projects
- `microservices` - Microservices architecture

**Examples:**
```bash
generate gitignore python
generate gitignore node
generate gitignore react
```

#### Directory Structure Generation
Generate complete project directory structures:

```bash
generate directory <type> [project-name] [output-path]
```

**Available types:**
- `python` - Python project with src/, tests/, docs/, etc.
- `node` - Node.js project with proper structure
- `electron` - Electron desktop application structure
- `react-frontend` - React frontend with modern tooling
- `nextjs-fullstack` - Next.js with API routes and database
- `fastapi-backend` - FastAPI with SQLAlchemy and Alembic
- `microservices` - Complete microservices architecture

**Examples:**
```bash
generate directory python my-python-app
generate directory electron my-desktop-app
generate directory microservices my-stack ./projects/
```

#### Configuration File Generation
Generate configuration files for development tools:

```bash
generate config <type> [output-path]
```

**Available types:**
- `docker` - Dockerfile, docker-compose.yml, .dockerignore
- `eslint` - ESLint configuration
- `prettier` - Prettier configuration  
- `vscode` - VS Code settings and extensions
- `kubernetes` - Kubernetes manifests
- `terraform` - Terraform AWS infrastructure
- `github-actions` - GitHub Actions workflows
- `monitoring` - Prometheus & Grafana configuration

**Examples:**
```bash
generate config docker
generate config eslint
generate config kubernetes
```

### Options

- `-h, --help` - Show help message
- `-l, --list` - List all available templates
- `-s, --smart` - List available smart append options
- `-o, --output <path>` - Specify output path (default: current directory)
- `--dry-run` - Show what would be generated without creating files

## Smart Mapping System

The smart append feature uses intelligent pattern matching to determine what related files should be generated:

| Technology | Generated Components |
|------------|---------------------|
| `electron` | Directory structure + Node.js gitignore + ESLint + Prettier + VS Code config |
| `python` | Python project structure + Python gitignore + VS Code config |
| `react` | React frontend + React gitignore + ESLint + Prettier + VS Code config |
| `nextjs` | Next.js fullstack + Next.js gitignore + ESLint + Prettier + VS Code config |
| `fastapi` | FastAPI backend + FastAPI gitignore + Docker config + VS Code config |
| `microservices` | Microservices structure + Docker + Kubernetes + Monitoring configs |
| `fullstack` | Next.js + FastAPI + Docker + All development configs |

## Directory Structure

```
generate/
├── generate                    # Main executable script with smart append
├── README.md                   # This file
├── templates/                  # Template files
│   ├── gitignore/             # GitIgnore templates
│   │   ├── python.gitignore
│   │   ├── node.gitignore
│   │   ├── react.gitignore
│   │   ├── electron.gitignore
│   │   └── ...
│   ├── directory/             # Directory structure templates
│   │   ├── python/
│   │   ├── node/
│   │   ├── electron/
│   │   └── ...
│   └── config/                # Configuration templates
│       ├── dockerfile.template
│       ├── eslintrc.template
│       └── ...
└── generators/                # Generator scripts
    ├── directory.sh           # Directory structure generator
    └── config.sh              # Configuration file generator
```

## Features

- **Smart Append**: Automatically generates related files based on technology
- **Comprehensive Templates**: Covers major programming languages and frameworks
- **Intelligent Matching**: Flexible pattern matching for technology names
- **Dry Run Mode**: Preview what will be generated before creating files
- **Modular Design**: Separated concerns with dedicated generators
- **Extensible**: Easy to add new templates and smart mappings
- **User-Friendly**: Colored output and helpful error messages
- **Safe Operations**: Prompts before overwriting existing files

## Quick Start Examples

### Create a Complete Electron App
```bash
generate electron my-desktop-app
cd my-desktop-app
npm install
npm run dev
```

### Create a Python Project with Full Setup
```bash
generate python my-python-project
cd my-python-project
pip install -r requirements.txt
python src/my-python-project/main.py
```

### Create a Full-Stack Application
```bash
generate fullstack my-awesome-app
cd my-awesome-app
# Frontend and backend directories created with all configs
```

### Preview Before Creating
```bash
generate microservices --dry-run
# Shows what would be generated without creating files
```

## Adding New Smart Mappings

To add new smart append combinations, edit the `SMART_MAPPINGS` array in the main `generate` script:

```bash
# Add to SMART_MAPPINGS in generate/generate
["vue"]="directory:vue-frontend gitignore:node config:eslint config:prettier config:vscode"
["django"]="directory:django-backend gitignore:python config:docker config:vscode"
```

## Adding New Templates

### GitIgnore Templates
1. Add a new `.gitignore` file in `templates/gitignore/`
2. Name it `<language>.gitignore`
3. The template will be automatically available

### Directory Templates
1. Create a new directory in `templates/directory/`
2. Add template files with `{{PROJECT_NAME}}` placeholders
3. Update `generators/directory.sh` to handle the new type

### Config Templates
1. Add template files to `templates/config/`
2. Use `{{PROJECT_NAME}}` placeholders for substitution
3. Update `generators/config.sh` to handle the new type

## System Integration

The script is designed to be used as a system-wide command. After creating the symbolic link, you can use `generate` from anywhere in your terminal with full smart append functionality.

## Requirements

- Bash shell (version 4.0+ for associative arrays)
- Standard Unix utilities (mkdir, touch, cat, etc.)
- Write permissions for target directories

## License

This tool is part of your custom scripts collection. 