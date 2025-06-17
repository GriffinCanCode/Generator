# Generate System

A comprehensive template generation system for creating various files and project structures.

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

### Available Commands

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

**Examples:**
```bash
generate directory python my-python-app
generate directory node my-node-app ./projects/
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

**Examples:**
```bash
generate config docker
generate config eslint
generate config vscode
```

### Options

- `-h, --help` - Show help message
- `-l, --list` - List all available templates
- `-o, --output <path>` - Specify output path (default: current directory)

## Directory Structure

```
generate/
├── generate                    # Main executable script
├── README.md                   # This file
├── templates/                  # Template files
│   ├── gitignore/             # GitIgnore templates
│   │   ├── python.gitignore
│   │   ├── node.gitignore
│   │   ├── react.gitignore
│   │   ├── java.gitignore
│   │   ├── go.gitignore
│   │   ├── rust.gitignore
│   │   ├── csharp.gitignore
│   │   ├── cpp.gitignore
│   │   ├── macos.gitignore
│   │   └── docker.gitignore
│   ├── directory/             # Directory structure templates
│   └── config/                # Configuration templates
└── generators/                # Generator scripts
    ├── directory.sh           # Directory structure generator
    └── config.sh              # Configuration file generator
```

## Features

- **Comprehensive Templates**: Covers major programming languages and frameworks
- **Modular Design**: Separated concerns with dedicated generators
- **Extensible**: Easy to add new templates and generators
- **User-Friendly**: Colored output and helpful error messages
- **Safe Operations**: Prompts before overwriting existing files

## Adding New Templates

### GitIgnore Templates
1. Add a new `.gitignore` file in `templates/gitignore/`
2. Name it `<language>.gitignore`
3. The template will be automatically available

### Directory Templates
1. Add logic to `generators/directory.sh`
2. Create a new function following the existing pattern
3. Add the new type to the case statement

### Config Templates
1. Add logic to `generators/config.sh`
2. Create a new function following the existing pattern
3. Add the new type to the case statement

## Examples

### Create a Python project with gitignore
```bash
generate directory python my-awesome-app
cd my-awesome-app
generate gitignore python
```

### Setup a Node.js project with full configuration
```bash
generate directory node my-web-app
cd my-web-app
generate gitignore node
generate config eslint
generate config prettier
generate config vscode
generate config docker
```

### Quick gitignore for existing project
```bash
cd existing-project
generate gitignore python
```

## System Integration

The script is designed to be used as a system-wide command. After creating the symbolic link, you can use `generate` from anywhere in your terminal.

## Requirements

- Bash shell
- Standard Unix utilities (mkdir, touch, cat, etc.)
- Write permissions for target directories

## License

This tool is part of your custom scripts collection. 