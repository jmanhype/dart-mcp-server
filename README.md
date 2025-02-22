# Dart MCP Server

A Model Context Protocol (MCP) server implementation for Dart, providing task management, document handling, and workspace organization capabilities through MCP tools.

## Features

- Task Management
  - Create and update tasks
  - Set task priorities and status
  - Assign tasks to team members
- Document Management
  - Create and organize documents
  - Support for markdown content
  - Report generation
- Space Management
  - Create and manage workspaces
  - Organize content with folders
  - Control access permissions
- Dartboard Integration
  - Default status management
  - Task organization
  - Team collaboration

## Installation

```bash
# Install dependencies
npm install

# Set up Python environment (required for Dart SDK)
python -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate
pip install dart-sdk

# Set up environment variables
cp .env.example .env
# Edit .env with your DART_TOKEN
```

## Usage

```bash
# Start the MCP server
npm start
```

## Development

```bash
# Install development dependencies
npm install --save-dev

# Run tests
npm test
```

## Environment Variables

Create a `.env` file with the following variables:

```env
DART_TOKEN=your_dart_token_here
PYTHONPATH=/path/to/dart/sdk  # Optional: if needed
```

## Available MCP Tools

- `create_task`: Create new tasks with title, description, priority, etc.
- `update_task`: Update existing tasks' status, title, description
- `get_default_status`: Get default status DUIDs
- `get_default_space`: Get default space DUID
- `get_dartboards`: List available dartboards
- `get_folders`: List folders in a space
- `create_folder`: Create new folders
- `create_doc`: Create new documents or reports
- `create_space`: Create new workspaces
- `delete_space`: Delete existing workspaces

## License

MIT License 