# Simple Node.js Express API

A simple REST API built with Express.js and containerized with Docker.

## Project Structure

```
.
├── app.js              # Main Express application
├── package.json        # Node.js dependencies
├── Dockerfile          # Docker configuration
├── .dockerignore        # Files to ignore in Docker
├── .gitignore          # Git ignore patterns
└── README.md           # This file
```

## Local Development

### Prerequisites

- Node.js (v14 or higher)
- npm

### Installation

1. Install dependencies:

```bash
npm install
```

2. Start the development server:

```bash
npm start
```

The server will run on `http://localhost:3000`

### API Endpoints

- `GET /` - Welcome message
- `GET /api/hello` - Hello endpoint
- `GET /api/users/:id` - Get user by ID
- `POST /api/users` - Create a new user
- `GET /health` - Health check endpoint

## Docker Setup

### Build Docker Image

```bash
docker build -t simple-nodejs-api .
```

### Run Docker Container

```bash
docker run -p 3000:3000 simple-nodejs-api
```

### Using Docker Compose (Optional)

If you want to use Docker Compose, create a `docker-compose.yml`:

```yaml
version: "3.8"
services:
  api:
    build: .
    ports:
      - "3000:3000"
    environment:
      - PORT=3000
```

Then run:

```bash
docker-compose up
```

## Environment Variables

- `PORT` - Server port (default: 3000)

## Testing Endpoints

### Using curl

```bash
# Welcome
curl http://localhost:3000/

# Hello
curl http://localhost:3000/api/hello

# Get user
curl http://localhost:3000/api/users/123

# Create user
curl -X POST http://localhost:3000/api/users \
  -H "Content-Type: application/json" \
  -d '{"name":"John","email":"john@example.com"}'

# Health check
curl http://localhost:3000/health
```

## License

MIT
