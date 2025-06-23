#!/bin/bash

# Directory Structure Generator
# Usage: generate directory <type>

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATES_DIR="$SCRIPT_DIR/../templates"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper function to copy template files
copy_template() {
    local template_type="$1"
    local template_file="$2"
    local output_file="$3"
    local project_name="${4:-myapp}"
    
    if [ -f "$TEMPLATES_DIR/$template_type/$template_file" ]; then
        sed "s/{{PROJECT_NAME}}/$project_name/g" "$TEMPLATES_DIR/$template_type/$template_file" > "$output_file"
    else
        echo -e "${RED}Template file not found: $template_type/$template_file${NC}"
        return 1
    fi
}

generate_python_project() {
    local project_name="${1:-python-project}"
    local output_path="${2:-./}"
    
    echo -e "${BLUE}Creating Python project structure: $project_name${NC}"
    
    mkdir -p "$output_path/$project_name"
    cd "$output_path/$project_name"
    
    # Create directory structure
    mkdir -p src/$project_name
    mkdir -p tests
    mkdir -p docs
    mkdir -p scripts
    mkdir -p data
    mkdir -p config
    
    # Create files
    touch src/$project_name/__init__.py
    touch src/$project_name/main.py
    touch tests/__init__.py
    touch tests/test_main.py
    touch README.md
    touch requirements.txt
    touch setup.py
    touch .env.example
    touch pyproject.toml
    
    # Create basic content
    copy_template "directory/python" "main.py.template" "src/$project_name/main.py" "$project_name"
    copy_template "directory/python" "test_main.py.template" "tests/test_main.py" "$project_name"
    copy_template "directory/python" "README.md.template" "README.md" "$project_name"
    copy_template "directory/python" "pyproject.toml.template" "pyproject.toml" "$project_name"
    
    # Create requirements.txt
    cat > requirements.txt << EOF
# Add your dependencies here
pytest>=7.0.0
EOF

    echo -e "${GREEN}Python project structure created successfully!${NC}"
}

generate_node_project() {
    local project_name="${1:-node-project}"
    local output_path="${2:-./}"
    
    echo -e "${BLUE}Creating Node.js project structure: $project_name${NC}"
    
    mkdir -p "$output_path/$project_name"
    cd "$output_path/$project_name"
    
    # Create directory structure
    mkdir -p src
    mkdir -p tests
    mkdir -p docs
    mkdir -p public
    mkdir -p config
    
    # Create files
    touch src/index.js
    touch tests/index.test.js
    touch README.md
    touch package.json
    touch .env.example
    
    # Create basic content
    copy_template "directory/node" "index.js.template" "src/index.js" "$project_name"
    copy_template "directory/node" "package.json.template" "package.json" "$project_name"
    
    # Create test file
    cat > tests/index.test.js << EOF
const { main } = require('../src/index');

describe('Main module', () => {
    test('should run without errors', () => {
        expect(() => main()).not.toThrow();
    });
});
EOF

    # Create README
    cat > README.md << EOF
# $project_name

Description of your project.

## Installation

\`\`\`bash
npm install
\`\`\`

## Usage

\`\`\`bash
npm start
\`\`\`

## Development

\`\`\`bash
npm run dev
\`\`\`

## Testing

\`\`\`bash
npm test
\`\`\`
EOF

    echo -e "${GREEN}Node.js project structure created successfully!${NC}"
}

generate_nextjs_fullstack() {
    local project_name="${1:-nextjs-fullstack}"
    local output_path="${2:-./}"
    
    echo -e "${BLUE}Creating Next.js Fullstack project: $project_name${NC}"
    
    mkdir -p "$output_path/$project_name"
    cd "$output_path/$project_name"
    
    # Create directory structure
    mkdir -p {src/{app/{api/{auth,users,posts},components/{ui,layout,forms},lib,hooks,types,utils},public/{images,icons},prisma,docs,tests/{unit,integration,e2e},scripts}
    
    # Create configuration files
    cat > package.json << 'EOF'
{
  "name": "nextjs-fullstack",
  "version": "0.1.0",
  "private": true,
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint",
    "test": "jest",
    "test:watch": "jest --watch",
    "test:e2e": "playwright test",
    "db:push": "prisma db push",
    "db:migrate": "prisma migrate dev",
    "db:studio": "prisma studio",
    "type-check": "tsc --noEmit"
  },
  "dependencies": {
    "next": "14.0.0",
    "react": "^18",
    "react-dom": "^18",
    "@prisma/client": "^5.0.0",
    "next-auth": "^4.24.0",
    "zod": "^3.22.0",
    "tailwindcss": "^3.3.0",
    "lucide-react": "^0.290.0"
  },
  "devDependencies": {
    "typescript": "^5",
    "@types/node": "^20",
    "@types/react": "^18",
    "@types/react-dom": "^18",
    "prisma": "^5.0.0",
    "jest": "^29.0.0",
    "@testing-library/react": "^13.0.0",
    "playwright": "^1.40.0",
    "eslint": "^8",
    "eslint-config-next": "14.0.0"
  }
}
EOF

    cat > src/app/layout.tsx << 'EOF'
import type { Metadata } from 'next'
import { Inter } from 'next/font/google'
import './globals.css'

const inter = Inter({ subsets: ['latin'] })

export const metadata: Metadata = {
  title: 'Next.js Fullstack App',
  description: 'A comprehensive fullstack application',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body className={inter.className}>{children}</body>
    </html>
  )
}
EOF

    cat > src/app/page.tsx << 'EOF'
export default function Home() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-between p-24">
      <div className="z-10 max-w-5xl w-full items-center justify-between font-mono text-sm">
        <h1 className="text-4xl font-bold text-center">
          Welcome to Next.js Fullstack
        </h1>
        <p className="text-center mt-4">
          A comprehensive fullstack application template
        </p>
      </div>
    </main>
  )
}
EOF

    # Create API routes
    cat > src/app/api/users/route.ts << 'EOF'
import { NextRequest, NextResponse } from 'next/server'

export async function GET(request: NextRequest) {
  // Implement user fetching logic
  return NextResponse.json({ users: [] })
}

export async function POST(request: NextRequest) {
  // Implement user creation logic
  const body = await request.json()
  return NextResponse.json({ message: 'User created', user: body })
}
EOF

    # Create Prisma schema
    cat > prisma/schema.prisma << 'EOF'
generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

model User {
  id        String   @id @default(cuid())
  email     String   @unique
  name      String?
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt
  posts     Post[]

  @@map("users")
}

model Post {
  id        String   @id @default(cuid())
  title     String
  content   String?
  published Boolean  @default(false)
  authorId  String
  author    User     @relation(fields: [authorId], references: [id])
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt

  @@map("posts")
}
EOF

    # Create environment example
    cat > .env.example << 'EOF'
# Database
DATABASE_URL="postgresql://username:password@localhost:5432/mydb"

# NextAuth
NEXTAUTH_URL="http://localhost:3000"
NEXTAUTH_SECRET="your-secret-here"

# OAuth Providers
GOOGLE_CLIENT_ID=""
GOOGLE_CLIENT_SECRET=""
EOF

    # Create TypeScript config
    cat > tsconfig.json << 'EOF'
{
  "compilerOptions": {
    "target": "es5",
    "lib": ["dom", "dom.iterable", "es6"],
    "allowJs": true,
    "skipLibCheck": true,
    "strict": true,
    "noEmit": true,
    "esModuleInterop": true,
    "module": "esnext",
    "moduleResolution": "bundler",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "jsx": "preserve",
    "incremental": true,
    "plugins": [
      {
        "name": "next"
      }
    ],
    "baseUrl": ".",
    "paths": {
      "@/*": ["./src/*"]
    }
  },
  "include": ["next-env.d.ts", "**/*.ts", "**/*.tsx", ".next/types/**/*.ts"],
  "exclude": ["node_modules"]
}
EOF

    echo -e "${GREEN}Next.js Fullstack project created successfully!${NC}"
}

generate_fastapi_backend() {
    local project_name="${1:-fastapi-backend}"
    local output_path="${2:-./}"
    
    echo -e "${BLUE}Creating FastAPI Backend project: $project_name${NC}"
    
    mkdir -p "$output_path/$project_name"
    cd "$output_path/$project_name"
    
    # Create directory structure
    mkdir -p {app/{api/{v1/{endpoints,deps}},core,db,models,schemas,services,utils},tests/{unit,integration},scripts,docs,alembic/versions}
    
    # Create main application files
    cat > app/main.py << 'EOF'
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.api.v1.api import api_router
from app.core.config import settings

app = FastAPI(
    title=settings.PROJECT_NAME,
    version=settings.VERSION,
    description="A comprehensive FastAPI backend",
    openapi_url=f"{settings.API_V1_STR}/openapi.json"
)

# Set all CORS enabled origins
if settings.BACKEND_CORS_ORIGINS:
    app.add_middleware(
        CORSMiddleware,
        allow_origins=[str(origin) for origin in settings.BACKEND_CORS_ORIGINS],
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )

app.include_router(api_router, prefix=settings.API_V1_STR)

@app.get("/")
def read_root():
    return {"message": "Welcome to FastAPI Backend"}

@app.get("/health")
def health_check():
    return {"status": "healthy"}
EOF

    cat > app/core/config.py << 'EOF'
from typing import Any, Dict, List, Optional, Union
from pydantic import AnyHttpUrl, BaseSettings, PostgresDsn, validator

class Settings(BaseSettings):
    PROJECT_NAME: str = "FastAPI Backend"
    VERSION: str = "1.0.0"
    API_V1_STR: str = "/api/v1"
    
    # Database
    POSTGRES_SERVER: str = "localhost"
    POSTGRES_USER: str = "postgres"
    POSTGRES_PASSWORD: str = "password"
    POSTGRES_DB: str = "app"
    SQLALCHEMY_DATABASE_URI: Optional[PostgresDsn] = None
    
    @validator("SQLALCHEMY_DATABASE_URI", pre=True)
    def assemble_db_connection(cls, v: Optional[str], values: Dict[str, Any]) -> Any:
        if isinstance(v, str):
            return v
        return PostgresDsn.build(
            scheme="postgresql",
            user=values.get("POSTGRES_USER"),
            password=values.get("POSTGRES_PASSWORD"),
            host=values.get("POSTGRES_SERVER"),
            path=f"/{values.get('POSTGRES_DB') or ''}",
        )
    
    # CORS
    BACKEND_CORS_ORIGINS: List[AnyHttpUrl] = []
    
    # Security
    SECRET_KEY: str = "your-secret-key-here"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 60 * 24 * 8  # 8 days
    
    class Config:
        env_file = ".env"

settings = Settings()
EOF

    cat > requirements.txt << 'EOF'
fastapi==0.104.1
uvicorn[standard]==0.24.0
sqlalchemy==2.0.23
alembic==1.12.1
psycopg2-binary==2.9.9
pydantic[email]==2.5.0
python-jose[cryptography]==3.3.0
passlib[bcrypt]==1.7.4
python-multipart==0.0.6
pytest==7.4.3
pytest-asyncio==0.21.1
httpx==0.25.2
python-dotenv==1.0.0
EOF

    # Create API structure
    cat > app/api/v1/api.py << 'EOF'
from fastapi import APIRouter
from app.api.v1.endpoints import users, auth

api_router = APIRouter()
api_router.include_router(auth.router, prefix="/auth", tags=["authentication"])
api_router.include_router(users.router, prefix="/users", tags=["users"])
EOF

    cat > app/api/v1/endpoints/users.py << 'EOF'
from typing import List
from fastapi import APIRouter, Depends, HTTPException
from app.schemas.user import User, UserCreate, UserUpdate
from app.services.user_service import UserService

router = APIRouter()

@router.get("/", response_model=List[User])
def read_users(skip: int = 0, limit: int = 100):
    """Retrieve users."""
    # Implement user retrieval logic
    return []

@router.post("/", response_model=User)
def create_user(user_in: UserCreate):
    """Create new user."""
    # Implement user creation logic
    return user_in

@router.get("/{user_id}", response_model=User)
def read_user(user_id: int):
    """Get user by ID."""
    # Implement user retrieval logic
    return {"id": user_id, "email": "user@example.com"}
EOF

    # Create schemas
    cat > app/schemas/user.py << 'EOF'
from typing import Optional
from pydantic import BaseModel, EmailStr

class UserBase(BaseModel):
    email: EmailStr
    is_active: Optional[bool] = True
    is_superuser: bool = False
    full_name: Optional[str] = None

class UserCreate(UserBase):
    password: str

class UserUpdate(UserBase):
    password: Optional[str] = None

class UserInDBBase(UserBase):
    id: Optional[int] = None
    
    class Config:
        from_attributes = True

class User(UserInDBBase):
    pass

class UserInDB(UserInDBBase):
    hashed_password: str
EOF

    cat > .env.example << 'EOF'
# Database
POSTGRES_SERVER=localhost
POSTGRES_USER=postgres
POSTGRES_PASSWORD=password
POSTGRES_DB=app

# Security
SECRET_KEY=your-secret-key-here
ACCESS_TOKEN_EXPIRE_MINUTES=480

# CORS
BACKEND_CORS_ORIGINS=["http://localhost:3000", "http://localhost:8080"]
EOF

    echo -e "${GREEN}FastAPI Backend project created successfully!${NC}"
}

generate_react_frontend() {
    local project_name="${1:-react-frontend}"
    local output_path="${2:-./}"
    
    echo -e "${BLUE}Creating React Frontend project: $project_name${NC}"
    
    mkdir -p "$output_path/$project_name"
    cd "$output_path/$project_name"
    
    # Create directory structure
    mkdir -p {src/{components/{ui,layout,forms,common},hooks,services,utils,types,store,pages,assets/{images,styles}},public,tests/{unit,integration,e2e},docs}
    
    cat > package.json << 'EOF'
{
  "name": "react-frontend",
  "version": "0.1.0",
  "private": true,
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "react-router-dom": "^6.8.0",
    "axios": "^1.6.0",
    "zustand": "^4.4.0",
    "react-query": "^3.39.0",
    "react-hook-form": "^7.47.0",
    "zod": "^3.22.0",
    "@hookform/resolvers": "^3.3.0",
    "tailwindcss": "^3.3.0",
    "lucide-react": "^0.290.0"
  },
  "devDependencies": {
    "@types/react": "^18.2.0",
    "@types/react-dom": "^18.2.0",
    "@vitejs/plugin-react": "^4.0.0",
    "vite": "^4.4.0",
    "typescript": "^5.0.0",
    "eslint": "^8.45.0",
    "prettier": "^3.0.0",
    "@testing-library/react": "^13.4.0",
    "@testing-library/jest-dom": "^5.16.4",
    "vitest": "^0.34.0"
  },
  "scripts": {
    "dev": "vite",
    "build": "tsc && vite build",
    "preview": "vite preview",
    "test": "vitest",
    "test:ui": "vitest --ui",
    "lint": "eslint . --ext ts,tsx --report-unused-disable-directives --max-warnings 0",
    "format": "prettier --write ."
  }
}
EOF

    cat > src/App.tsx << 'EOF'
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom'
import { QueryClient, QueryClientProvider } from 'react-query'
import { Layout } from './components/layout/Layout'
import { Home } from './pages/Home'
import { About } from './pages/About'
import './assets/styles/globals.css'

const queryClient = new QueryClient()

function App() {
  return (
    <QueryClientProvider client={queryClient}>
      <Router>
        <Layout>
          <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/about" element={<About />} />
          </Routes>
        </Layout>
      </Router>
    </QueryClientProvider>
  )
}

export default App
EOF

    cat > src/components/layout/Layout.tsx << 'EOF'
import { ReactNode } from 'react'
import { Header } from './Header'
import { Footer } from './Footer'

interface LayoutProps {
  children: ReactNode
}

export function Layout({ children }: LayoutProps) {
  return (
    <div className="min-h-screen flex flex-col">
      <Header />
      <main className="flex-1 container mx-auto px-4 py-8">
        {children}
      </main>
      <Footer />
    </div>
  )
}
EOF

    cat > vite.config.ts << 'EOF'
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import path from 'path'

export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
    },
  },
  server: {
    port: 3000,
    proxy: {
      '/api': {
        target: 'http://localhost:8000',
        changeOrigin: true,
      },
    },
  },
})
EOF

    echo -e "${GREEN}React Frontend project created successfully!${NC}"
}

generate_electron_app() {
    local project_name="${1:-electron-app}"
    local output_path="${2:-./}"
    
    echo -e "${BLUE}Creating Electron Desktop Application: $project_name${NC}"
    
    mkdir -p "$output_path/$project_name"
    cd "$output_path/$project_name"
    
    # Create comprehensive directory structure following best practices
    mkdir -p {src/{main/{app,ipc,windows,utils},renderer/{components/{ui,layout,common},pages,hooks,services,store,styles},preload,shared,types},assets/{images,icons},build,dist,tests/{unit,integration,e2e},scripts,docs}
    
    # Create main process files
    copy_template "directory/electron" "main.js.template" "src/main/app/main.js" "$project_name"
    copy_template "directory/electron" "ipc-handlers.js.template" "src/main/ipc/ipc-handlers.js" "$project_name"
    
    # Create preload script
    copy_template "directory/electron" "preload.js.template" "src/preload/preload.js" "$project_name"
    
    # Create package.json and README
    copy_template "directory/electron" "package.json.template" "package.json" "$project_name"
    copy_template "directory/electron" "README.md.template" "README.md" "$project_name"
    
    # Create placeholder files for key directories
    touch src/main/windows/.gitkeep
    touch src/main/utils/.gitkeep
    touch src/renderer/components/ui/.gitkeep
    touch src/renderer/components/layout/.gitkeep
    touch src/renderer/components/common/.gitkeep
    touch src/renderer/pages/.gitkeep
    touch src/renderer/hooks/.gitkeep
    touch src/renderer/services/.gitkeep
    touch src/renderer/store/.gitkeep
    touch src/renderer/styles/.gitkeep
    touch src/shared/.gitkeep
    touch src/types/.gitkeep
    touch assets/images/.gitkeep
    touch assets/icons/.gitkeep
    touch build/.gitkeep
    touch tests/unit/.gitkeep
    touch tests/integration/.gitkeep
    touch tests/e2e/.gitkeep
    touch scripts/.gitkeep
    touch docs/.gitkeep
    
    # Create environment file
    cat > .env.example << 'EOF'
# Development environment variables
NODE_ENV=development
ELECTRON_IS_DEV=true

# App configuration
APP_NAME={{PROJECT_NAME}}
APP_VERSION=1.0.0

# Build configuration
BUILD_TARGET=development
EOF

    echo -e "${GREEN}Electron Desktop Application created successfully!${NC}"
    echo -e "${YELLOW}Next steps:${NC}"
    echo -e "  1. cd $project_name"
    echo -e "  2. npm install"
    echo -e "  3. Set up your renderer framework (React, Vue, etc.) in src/renderer/"
    echo -e "  4. npm run dev"
}

generate_docs_structure() {
    local project_name="${1:-docs}"
    local output_path="${2:-./}"
    
    echo -e "${BLUE}Creating Documentation Structure: $project_name${NC}"
    
    local docs_path="$output_path"
    if [ "$project_name" != "docs" ]; then
        docs_path="$output_path/$project_name"
        mkdir -p "$docs_path"
    fi
    
    # Create main documentation directories
    mkdir -p "$docs_path"/{architecture,tech-stack,api,development,deployment,contributing,user-guide,security,troubleshooting}
    
    # Create main README
    copy_template "directory/docs" "README.md.template" "$docs_path/README.md" "$project_name"
    
    # Create subdirectory READMEs
    copy_template "directory/docs/architecture" "README.md.template" "$docs_path/architecture/README.md" "$project_name"
    copy_template "directory/docs/tech-stack" "README.md.template" "$docs_path/tech-stack/README.md" "$project_name"
    copy_template "directory/docs/api" "README.md.template" "$docs_path/api/README.md" "$project_name"
    copy_template "directory/docs/development" "README.md.template" "$docs_path/development/README.md" "$project_name"
    copy_template "directory/docs/deployment" "README.md.template" "$docs_path/deployment/README.md" "$project_name"
    copy_template "directory/docs/contributing" "README.md.template" "$docs_path/contributing/README.md" "$project_name"
    copy_template "directory/docs/user-guide" "README.md.template" "$docs_path/user-guide/README.md" "$project_name"
    copy_template "directory/docs/security" "README.md.template" "$docs_path/security/README.md" "$project_name"
    copy_template "directory/docs/troubleshooting" "README.md.template" "$docs_path/troubleshooting/README.md" "$project_name"
    
    # Create placeholder files for common documentation
    touch "$docs_path/architecture"/{overview.md,database-design.md,api-design.md,security-architecture.md,deployment-architecture.md}
    touch "$docs_path/tech-stack"/{overview.md,frontend.md,backend.md,database.md,devops.md,monitoring.md}
    touch "$docs_path/api"/{reference.md,authentication.md,postman-collection.json}
    touch "$docs_path/development"/{getting-started.md,coding-standards.md,testing.md,debugging.md,workflows.md}
    touch "$docs_path/deployment"/{production.md,staging.md,docker.md,kubernetes.md,monitoring.md,backup-restore.md}
    touch "$docs_path/contributing"/{guidelines.md,code-of-conduct.md,pull-request-template.md,review-process.md}
    touch "$docs_path/user-guide"/{getting-started.md,faq.md,troubleshooting.md}
    touch "$docs_path/security"/{security-policy.md,authentication.md,authorization.md,data-protection.md,incident-response.md}
    touch "$docs_path/troubleshooting"/{common-issues.md,error-codes.md,performance.md,database-issues.md,deployment-issues.md}
    
    # Create subdirectories for organized content
    mkdir -p "$docs_path/api"/{endpoints,examples}
    mkdir -p "$docs_path/user-guide"/{tutorials,features}
    mkdir -p "$docs_path/contributing"/issue-templates
    
    # Create placeholder files in subdirectories
    touch "$docs_path/api/endpoints"/.gitkeep
    touch "$docs_path/api/examples"/.gitkeep
    touch "$docs_path/user-guide/tutorials"/.gitkeep
    touch "$docs_path/user-guide/features"/.gitkeep
    touch "$docs_path/contributing/issue-templates"/.gitkeep
    
    echo -e "${GREEN}Documentation structure created successfully!${NC}"
    echo -e "${YELLOW}Documentation directories created:${NC}"
    echo -e "  • architecture/ - System design and architecture docs"
    echo -e "  • tech-stack/ - Technology choices and documentation"
    echo -e "  • api/ - API documentation and reference"
    echo -e "  • development/ - Development guides and setup"
    echo -e "  • deployment/ - Deployment and operations guides"
    echo -e "  • contributing/ - Contributing guidelines and processes"
    echo -e "  • user-guide/ - User documentation and tutorials"
    echo -e "  • security/ - Security policies and procedures"
    echo -e "  • troubleshooting/ - Common issues and solutions"
}

generate_microservices() {
    local project_name="${1:-microservices-stack}"
    local output_path="${2:-./}"
    
    echo -e "${BLUE}Creating Microservices Stack: $project_name${NC}"
    
    mkdir -p "$output_path/$project_name"
    cd "$output_path/$project_name"
    
    # Create directory structure
    mkdir -p {services/{auth-service,user-service,api-gateway},frontend,shared/{types,utils},infrastructure/{docker,k8s,monitoring},docs,scripts}
    
    # Create docker-compose for the entire stack
    cat > docker-compose.yml << 'EOF'
version: '3.8'

services:
  # Frontend
  frontend:
    build: ./frontend
    ports:
      - "3000:3000"
    environment:
      - REACT_APP_API_URL=http://localhost:8000
    depends_on:
      - api-gateway

  # API Gateway
  api-gateway:
    build: ./services/api-gateway
    ports:
      - "8000:8000"
    environment:
      - AUTH_SERVICE_URL=http://auth-service:8001
      - USER_SERVICE_URL=http://user-service:8002
    depends_on:
      - auth-service
      - user-service

  # Auth Service
  auth-service:
    build: ./services/auth-service
    ports:
      - "8001:8001"
    environment:
      - DATABASE_URL=postgresql://auth_user:password@auth-db:5432/auth_db
      - JWT_SECRET=your-jwt-secret
    depends_on:
      - auth-db

  # User Service
  user-service:
    build: ./services/user-service
    ports:
      - "8002:8002"
    environment:
      - DATABASE_URL=postgresql://user_user:password@user-db:5432/user_db
    depends_on:
      - user-db

  # Databases
  auth-db:
    image: postgres:15-alpine
    environment:
      POSTGRES_DB: auth_db
      POSTGRES_USER: auth_user
      POSTGRES_PASSWORD: password
    volumes:
      - auth_db_data:/var/lib/postgresql/data

  user-db:
    image: postgres:15-alpine
    environment:
      POSTGRES_DB: user_db
      POSTGRES_USER: user_user
      POSTGRES_PASSWORD: password
    volumes:
      - user_db_data:/var/lib/postgresql/data

  # Redis for caching
  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"

  # Monitoring
  prometheus:
    image: prom/prometheus:latest
    ports:
      - "9090:9090"
    volumes:
      - ./infrastructure/monitoring/prometheus.yml:/etc/prometheus/prometheus.yml

volumes:
  auth_db_data:
  user_db_data:
EOF

    # Create API Gateway service
    mkdir -p services/api-gateway
    cat > services/api-gateway/Dockerfile << 'EOF'
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm ci --only=production

COPY . .

EXPOSE 8000

CMD ["npm", "start"]
EOF

    cat > services/api-gateway/package.json << 'EOF'
{
  "name": "api-gateway",
  "version": "1.0.0",
  "main": "index.js",
  "scripts": {
    "start": "node index.js",
    "dev": "nodemon index.js"
  },
  "dependencies": {
    "express": "^4.18.0",
    "http-proxy-middleware": "^2.0.0",
    "cors": "^2.8.0",
    "helmet": "^7.0.0",
    "express-rate-limit": "^6.0.0"
  }
}
EOF

    # Create monitoring configuration
    mkdir -p infrastructure/monitoring
    cat > infrastructure/monitoring/prometheus.yml << 'EOF'
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'api-gateway'
    static_configs:
      - targets: ['api-gateway:8000']
  
  - job_name: 'auth-service'
    static_configs:
      - targets: ['auth-service:8001']
  
  - job_name: 'user-service'
    static_configs:
      - targets: ['user-service:8002']
EOF

    cat > README.md << 'EOF'
# Microservices Stack

A comprehensive microservices architecture with:

## Services
- **API Gateway**: Routes requests and handles cross-cutting concerns
- **Auth Service**: Authentication and authorization
- **User Service**: User management
- **Frontend**: React application

## Infrastructure
- PostgreSQL databases (separate per service)
- Redis for caching
- Prometheus for monitoring
- Docker Compose for local development

## Getting Started

```bash
# Start all services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop all services
docker-compose down
```

## Endpoints
- Frontend: http://localhost:3000
- API Gateway: http://localhost:8000
- Auth Service: http://localhost:8001
- User Service: http://localhost:8002
- Prometheus: http://localhost:9090
EOF

    echo -e "${GREEN}Microservices Stack created successfully!${NC}"
}

# Main function
case "$1" in
    python|python-project)
        shift
        generate_python_project "$@"
        ;;
    node|nodejs|node-project)
        shift
        generate_node_project "$@"
        ;;
    nextjs-fullstack|fullstack-nextjs)
        shift
        generate_nextjs_fullstack "$@"
        ;;
    fastapi-backend|backend-fastapi)
        shift
        generate_fastapi_backend "$@"
        ;;
    react-frontend|frontend-react)
        shift
        generate_react_frontend "$@"
        ;;
    electron|electron-app)
        shift
        generate_electron_app "$@"
        ;;
    microservices|microservices-stack)
        shift
        generate_microservices "$@"
        ;;
    docs|documentation)
        shift
        generate_docs_structure "$@"
        ;;
    *)
        echo -e "${RED}Error: Unknown directory type '$1'${NC}"
        echo "Available types:"
        echo ""
        echo -e "${GREEN}Basic Projects:${NC}"
        echo "  python, python-project     - Python project structure"
        echo "  node, nodejs, node-project - Node.js project structure"
        echo ""
        echo -e "${GREEN}Frontend Projects:${NC}"
        echo "  react-frontend            - React frontend with Vite, TypeScript, Tailwind"
        echo ""
        echo -e "${GREEN}Backend Projects:${NC}"
        echo "  fastapi-backend           - FastAPI backend with PostgreSQL, SQLAlchemy"
        echo ""
        echo -e "${GREEN}Desktop Applications:${NC}"
        echo "  electron, electron-app    - Cross-platform desktop app with Electron.js"
        echo ""
        echo -e "${GREEN}Fullstack Projects:${NC}"
        echo "  nextjs-fullstack          - Next.js 14 with API routes, Prisma, TypeScript"
        echo ""
        echo -e "${GREEN}Complex Architectures:${NC}"
        echo "  microservices             - Complete microservices stack with Docker"
        echo ""
        echo -e "${GREEN}Documentation:${NC}"
        echo "  docs, documentation       - Comprehensive documentation structure"
        exit 1
        ;;
esac 