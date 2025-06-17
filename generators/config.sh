#!/bin/bash

# Configuration File Generator
# Usage: generate config <type>

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATES_DIR="$SCRIPT_DIR/../templates/config"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

generate_docker_config() {
    local output_path="${1:-./}"
    
    echo -e "${BLUE}Creating Docker configuration files${NC}"
    
    # Create Dockerfile
    cat > "$output_path/Dockerfile" << EOF
# Use official Node.js runtime as base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy application code
COPY . .

# Expose port
EXPOSE 3000

# Create non-root user
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nextjs -u 1001

# Change ownership of the app directory
RUN chown -R nextjs:nodejs /app
USER nextjs

# Start the application
CMD ["npm", "start"]
EOF

    # Create docker-compose.yml
    cat > "$output_path/docker-compose.yml" << EOF
version: '3.8'

services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
    volumes:
      - ./data:/app/data
    restart: unless-stopped
    
  db:
    image: postgres:15-alpine
    environment:
      POSTGRES_DB: myapp
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
    volumes:
      - postgres_data:/var/lib/postgresql/data
    restart: unless-stopped

volumes:
  postgres_data:
EOF

    # Create .dockerignore
    cat > "$output_path/.dockerignore" << EOF
node_modules
npm-debug.log
.git
.gitignore
README.md
.env
.nyc_output
coverage
.nyc_output
.coverage
.cache
.parcel-cache
.next
.nuxt
dist
EOF

    echo -e "${GREEN}Docker configuration files created successfully!${NC}"
}

generate_eslint_config() {
    local output_path="${1:-./}"
    
    echo -e "${BLUE}Creating ESLint configuration${NC}"
    
    cat > "$output_path/.eslintrc.js" << EOF
module.exports = {
  env: {
    browser: true,
    es2021: true,
    node: true,
  },
  extends: [
    'eslint:recommended',
    '@typescript-eslint/recommended',
    'prettier',
  ],
  parser: '@typescript-eslint/parser',
  parserOptions: {
    ecmaVersion: 'latest',
    sourceType: 'module',
  },
  plugins: [
    '@typescript-eslint',
  ],
  rules: {
    'indent': ['error', 2],
    'linebreak-style': ['error', 'unix'],
    'quotes': ['error', 'single'],
    'semi': ['error', 'always'],
    '@typescript-eslint/no-unused-vars': 'error',
    '@typescript-eslint/no-explicit-any': 'warn',
  },
};
EOF

    cat > "$output_path/.eslintignore" << EOF
node_modules
dist
build
.next
.nuxt
coverage
*.min.js
EOF

    echo -e "${GREEN}ESLint configuration created successfully!${NC}"
}

generate_prettier_config() {
    local output_path="${1:-./}"
    
    echo -e "${BLUE}Creating Prettier configuration${NC}"
    
    cat > "$output_path/.prettierrc" << EOF
{
  "semi": true,
  "trailingComma": "es5",
  "singleQuote": true,
  "printWidth": 80,
  "tabWidth": 2,
  "useTabs": false,
  "bracketSpacing": true,
  "arrowParens": "avoid"
}
EOF

    cat > "$output_path/.prettierignore" << EOF
node_modules
dist
build
.next
.nuxt
coverage
*.min.js
package-lock.json
yarn.lock
EOF

    echo -e "${GREEN}Prettier configuration created successfully!${NC}"
}

generate_vscode_config() {
    local output_path="${1:-./}"
    
    echo -e "${BLUE}Creating VS Code configuration${NC}"
    
    mkdir -p "$output_path/.vscode"
    
    cat > "$output_path/.vscode/settings.json" << EOF
{
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true
  },
  "typescript.preferences.importModuleSpecifier": "relative",
  "files.exclude": {
    "**/node_modules": true,
    "**/dist": true,
    "**/build": true
  },
  "search.exclude": {
    "**/node_modules": true,
    "**/dist": true,
    "**/build": true
  }
}
EOF

    cat > "$output_path/.vscode/extensions.json" << EOF
{
  "recommendations": [
    "esbenp.prettier-vscode",
    "dbaeumer.vscode-eslint",
    "ms-vscode.vscode-typescript-next",
    "bradlc.vscode-tailwindcss",
    "ms-vscode.vscode-json"
  ]
}
EOF

    echo -e "${GREEN}VS Code configuration created successfully!${NC}"
}

generate_kubernetes_config() {
    local output_path="${1:-./}"
    
    echo -e "${BLUE}Creating Kubernetes configuration files${NC}"
    
    mkdir -p "$output_path/k8s"
    
    # Create namespace
    cat > "$output_path/k8s/namespace.yaml" << 'EOF'
apiVersion: v1
kind: Namespace
metadata:
  name: myapp
  labels:
    name: myapp
EOF

    # Create deployment
    cat > "$output_path/k8s/deployment.yaml" << 'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp-deployment
  namespace: myapp
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
      - name: myapp
        image: myapp:latest
        ports:
        - containerPort: 3000
        env:
        - name: NODE_ENV
          value: "production"
        resources:
          requests:
            memory: "256Mi"
            cpu: "250m"
          limits:
            memory: "512Mi"
            cpu: "500m"
        livenessProbe:
          httpGet:
            path: /health
            port: 3000
          initialDelaySeconds: 30
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /ready
            port: 3000
          initialDelaySeconds: 5
          periodSeconds: 5
EOF

    # Create service
    cat > "$output_path/k8s/service.yaml" << 'EOF'
apiVersion: v1
kind: Service
metadata:
  name: myapp-service
  namespace: myapp
spec:
  selector:
    app: myapp
  ports:
    - protocol: TCP
      port: 80
      targetPort: 3000
  type: ClusterIP
EOF

    # Create ingress
    cat > "$output_path/k8s/ingress.yaml" << 'EOF'
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: myapp-ingress
  namespace: myapp
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - host: myapp.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: myapp-service
            port:
              number: 80
EOF

    echo -e "${GREEN}Kubernetes configuration files created successfully!${NC}"
}

generate_terraform_config() {
    local output_path="${1:-./}"
    
    echo -e "${BLUE}Creating Terraform configuration files${NC}"
    
    mkdir -p "$output_path/terraform"
    
    # Main configuration
    cat > "$output_path/terraform/main.tf" << 'EOF'
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

# Public Subnets
resource "aws_subnet" "public" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone = var.availability_zones[count.index]

  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-${count.index + 1}"
  }
}

# Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

# Route Table Association
resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}
EOF

    # Variables
    cat > "$output_path/terraform/variables.tf" << 'EOF'
variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "myapp"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b"]
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}
EOF

    # Outputs
    cat > "$output_path/terraform/outputs.tf" << 'EOF'
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = aws_subnet.public[*].id
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.main.id
}
EOF

    # Terraform variables file
    cat > "$output_path/terraform/terraform.tfvars.example" << 'EOF'
project_name       = "myapp"
aws_region         = "us-west-2"
vpc_cidr          = "10.0.0.0/16"
availability_zones = ["us-west-2a", "us-west-2b"]
environment       = "dev"
EOF

    echo -e "${GREEN}Terraform configuration files created successfully!${NC}"
}

generate_github_actions() {
    local output_path="${1:-./}"
    
    echo -e "${BLUE}Creating GitHub Actions workflows${NC}"
    
    mkdir -p "$output_path/.github/workflows"
    
    # CI/CD Pipeline
    cat > "$output_path/.github/workflows/ci-cd.yml" << 'EOF'
name: CI/CD Pipeline

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

env:
  NODE_VERSION: '18'
  PYTHON_VERSION: '3.11'

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v4
    
    - name: Setup Node.js
      uses: actions/setup-node@v4
      with:
        node-version: ${{ env.NODE_VERSION }}
        cache: 'npm'
    
    - name: Install dependencies
      run: npm ci
    
    - name: Run linting
      run: npm run lint
    
    - name: Run tests
      run: npm run test:coverage
    
    - name: Upload coverage to Codecov
      uses: codecov/codecov-action@v3
      with:
        token: ${{ secrets.CODECOV_TOKEN }}

  build:
    needs: test
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v4
    
    - name: Setup Node.js
      uses: actions/setup-node@v4
      with:
        node-version: ${{ env.NODE_VERSION }}
        cache: 'npm'
    
    - name: Install dependencies
      run: npm ci
    
    - name: Build application
      run: npm run build
    
    - name: Build Docker image
      run: docker build -t myapp:${{ github.sha }} .
    
    - name: Save Docker image
      run: docker save myapp:${{ github.sha }} | gzip > myapp-image.tar.gz
    
    - name: Upload build artifact
      uses: actions/upload-artifact@v3
      with:
        name: docker-image
        path: myapp-image.tar.gz

  deploy:
    needs: build
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    
    steps:
    - uses: actions/checkout@v4
    
    - name: Download build artifact
      uses: actions/download-artifact@v3
      with:
        name: docker-image
    
    - name: Load Docker image
      run: docker load < myapp-image.tar.gz
    
    - name: Deploy to production
      run: |
        echo "Deploying to production..."
        # Add your deployment commands here
EOF

    # Security scanning
    cat > "$output_path/.github/workflows/security.yml" << 'EOF'
name: Security Scan

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]
  schedule:
    - cron: '0 2 * * 1' # Weekly on Monday at 2 AM

jobs:
  security:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v4
    
    - name: Run Trivy vulnerability scanner
      uses: aquasecurity/trivy-action@master
      with:
        scan-type: 'fs'
        scan-ref: '.'
        format: 'sarif'
        output: 'trivy-results.sarif'
    
    - name: Upload Trivy scan results to GitHub Security tab
      uses: github/codeql-action/upload-sarif@v2
      with:
        sarif_file: 'trivy-results.sarif'
    
    - name: Run npm audit
      run: npm audit --audit-level moderate
EOF

    echo -e "${GREEN}GitHub Actions workflows created successfully!${NC}"
}

generate_monitoring_config() {
    local output_path="${1:-./}"
    
    echo -e "${BLUE}Creating monitoring configuration${NC}"
    
    mkdir -p "$output_path/monitoring"
    
    # Prometheus configuration
    cat > "$output_path/monitoring/prometheus.yml" << 'EOF'
global:
  scrape_interval: 15s
  evaluation_interval: 15s

rule_files:
  - "alert_rules.yml"

alerting:
  alertmanagers:
    - static_configs:
        - targets:
          - alertmanager:9093

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']

  - job_name: 'node-exporter'
    static_configs:
      - targets: ['node-exporter:9100']

  - job_name: 'myapp'
    static_configs:
      - targets: ['app:3000']
    metrics_path: '/metrics'
    scrape_interval: 5s
EOF

    # Grafana dashboard
    cat > "$output_path/monitoring/grafana-dashboard.json" << 'EOF'
{
  "dashboard": {
    "id": null,
    "title": "Application Metrics",
    "tags": ["application"],
    "timezone": "browser",
    "panels": [
      {
        "id": 1,
        "title": "Request Rate",
        "type": "graph",
        "targets": [
          {
            "expr": "rate(http_requests_total[5m])",
            "legendFormat": "{{method}} {{status}}"
          }
        ]
      },
      {
        "id": 2,
        "title": "Response Time",
        "type": "graph",
        "targets": [
          {
            "expr": "histogram_quantile(0.95, rate(http_request_duration_seconds_bucket[5m]))",
            "legendFormat": "95th percentile"
          }
        ]
      }
    ],
    "time": {
      "from": "now-1h",
      "to": "now"
    },
    "refresh": "5s"
  }
}
EOF

    # Alert rules
    cat > "$output_path/monitoring/alert_rules.yml" << 'EOF'
groups:
  - name: application_alerts
    rules:
      - alert: HighErrorRate
        expr: rate(http_requests_total{status=~"5.."}[5m]) > 0.1
        for: 5m
        labels:
          severity: critical
        annotations:
          summary: "High error rate detected"
          description: "Error rate is above 10% for 5 minutes"

      - alert: HighResponseTime
        expr: histogram_quantile(0.95, rate(http_request_duration_seconds_bucket[5m])) > 1
        for: 5m
        labels:
          severity: warning
        annotations:
          summary: "High response time detected"
          description: "95th percentile response time is above 1 second"

      - alert: ServiceDown
        expr: up == 0
        for: 1m
        labels:
          severity: critical
        annotations:
          summary: "Service is down"
          description: "Service {{ $labels.instance }} is down"
EOF

    echo -e "${GREEN}Monitoring configuration created successfully!${NC}"
}

# Main function
case "$1" in
    docker)
        shift
        generate_docker_config "$@"
        ;;
    eslint)
        shift
        generate_eslint_config "$@"
        ;;
    prettier)
        shift
        generate_prettier_config "$@"
        ;;
    vscode|vs-code)
        shift
        generate_vscode_config "$@"
        ;;
    kubernetes|k8s)
        shift
        generate_kubernetes_config "$@"
        ;;
    terraform|tf)
        shift
        generate_terraform_config "$@"
        ;;
    github-actions|gh-actions)
        shift
        generate_github_actions "$@"
        ;;
    monitoring|prometheus)
        shift
        generate_monitoring_config "$@"
        ;;
    *)
        echo -e "${RED}Error: Unknown config type '$1'${NC}"
        echo "Available types:"
        echo ""
        echo -e "${GREEN}Development Tools:${NC}"
        echo "  docker          - Docker configuration (Dockerfile, docker-compose.yml)"
        echo "  eslint          - ESLint configuration"
        echo "  prettier        - Prettier configuration"
        echo "  vscode          - VS Code configuration"
        echo ""
        echo -e "${GREEN}Infrastructure:${NC}"
        echo "  kubernetes      - Kubernetes manifests (deployment, service, ingress)"
        echo "  terraform       - Terraform AWS infrastructure"
        echo ""
        echo -e "${GREEN}CI/CD & Monitoring:${NC}"
        echo "  github-actions  - GitHub Actions workflows"
        echo "  monitoring      - Prometheus & Grafana configuration"
        exit 1
        ;;
esac 