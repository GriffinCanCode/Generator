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

### Quick License Generation 🆕

Generate licenses with intelligent auto-detection:

```bash
# Basic usage - auto-detects name and date
generate license MIT

# Specify custom name, auto-detect date
generate license Apache-2.0 "Your Name"

# Full manual control
generate license BSD-3-Clause "Company Name" 2024
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

#### License Generation 🆕
Generate proper license files with intelligent name and date detection:

```bash
generate license <type> [fullname] [year]
```

**Available license types:**
- `MIT` - MIT License (simple and permissive)
- `Apache-2.0` - Apache License 2.0 (with patent protection)
- `BSD-3-Clause` - BSD 3-Clause License (with attribution requirements)
- `GRIFFIN` - Custom Griffin License (with special attribution requirements)

**Smart Detection Features:**
- **Automatic Name Detection**: Scans `package.json`, `pyproject.toml`, `Cargo.toml`, git config, and more
- **Intelligent Date Ranges**: Auto-detects project start year from git history (e.g., "2020-2025")
- **Project-Aware**: Prioritizes project-specific information over generic settings

**Examples:**
```bash
# Auto-detect name and date from project context
generate license MIT

# Auto-detect name, specify year
generate license Apache-2.0 "" 2023

# Manual override
generate license BSD-3-Clause "Your Company Inc" 2024

# See what would be detected
generate license MIT --dry-run
```

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

### Intelligent Detection System 🧠

The license generator features sophisticated auto-detection capabilities:

#### Name Detection Priority
1. **Project Files** (Highest Priority)
   - `package.json` → `"author": "Name"` or author object
   - `pyproject.toml` → `authors = [{name = "Name"}]`
   - `Cargo.toml` → `authors = ["Name"]`
   - `composer.json` → author information

2. **Existing License Files**
   - Extracts current copyright holder from LICENSE files

3. **Git Configuration & History**
   - `git config user.name` (when different from system user)
   - Primary contributor analysis from commit history

4. **Repository Context**
   - GitHub/GitLab repository owner names
   - Converts usernames to readable format

5. **System Fallback**
   - System username as last resort

#### Date Detection Features
- **Git History Analysis**: Finds earliest commit year
- **File System Scanning**: Checks source file modification dates
- **Smart Ranges**: Creates "2020-2025" format for multi-year projects
- **Current Year Fallback**: Uses current year for new projects

### Options

- `-h, --help` - Show help message
- `-l, --list` - List all available templates (including licenses) 🆕
- `-s, --smart` - List available smart append options
- `-o, --output <path>` - Specify output path (default: current directory)
- `--dry-run` - Show what would be generated without creating files

### Available Commands

| Command | Description | Example |
|---------|-------------|---------|
| `license <type>` | Generate license with smart detection 🆕 | `generate license MIT` |
| `gitignore <lang>` | Generate .gitignore file | `generate gitignore python` |
| `directory <type>` | Generate project structure | `generate directory python` |
| `config <type>` | Generate config files | `generate config docker` |
| `<technology>` | Smart append generation | `generate electron my-app` |

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
│   ├── config/                # Configuration templates
│   │   ├── dockerfile.template
│   │   ├── eslintrc.template
│   │   └── ...
│   └── license/               # License templates 🆕
│       ├── MIT.template
│       ├── Apache-2.0.template
│       ├── BSD-3-Clause.template
│       └── GRIFFIN.template
└── generators/                # Generator scripts
    ├── directory.sh           # Directory structure generator
    └── config.sh              # Configuration file generator
```

## Features

- **Smart Append**: Automatically generates related files based on technology
- **Intelligent License Generation**: Auto-detects names and dates from project context 🆕
- **Comprehensive Templates**: Covers major programming languages and frameworks
- **Intelligent Matching**: Flexible pattern matching for technology names
- **Context-Aware Detection**: Scans project files for author information 🆕
- **Multi-Source Date Detection**: Analyzes git history and file timestamps 🆕
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

### Generate Licenses with Smart Detection 🆕
```bash
# Auto-detect everything from project context
generate license MIT
# Output: Copyright (c) 2020-2025 Griffin Strier

# For a Node.js project with package.json
generate license Apache-2.0
# Automatically uses author from package.json

# For a Python project with pyproject.toml  
generate license BSD-3-Clause
# Uses author from pyproject.toml
```

### Preview Before Creating
```bash
generate microservices --dry-run
# Shows what would be generated without creating files

generate license MIT --dry-run
# Shows what name and date would be detected
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

### License Templates 🆕
1. Add new license template to `templates/license/`
2. Name it `<LICENSE-NAME>.template`
3. Use `{{YEAR}}` and `{{FULLNAME}}` placeholders
4. The template will be automatically available

**Example license template:**
```
My Custom License

Copyright (c) {{YEAR}} {{FULLNAME}}

[License text here...]
```

## System Integration

The script is designed to be used as a system-wide command. After creating the symbolic link, you can use `generate` from anywhere in your terminal with full smart append functionality.

## Requirements

- Bash shell (version 4.0+ for associative arrays)
- Standard Unix utilities (mkdir, touch, cat, etc.)
- Write permissions for target directories

## License

This tool is part of your custom scripts collection. 