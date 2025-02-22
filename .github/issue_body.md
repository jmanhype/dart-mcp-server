Hi Dart team!

I've created a Model Context Protocol (MCP) server implementation for Dart that enables AI assistants (like Claude) to interact with Dart's task management system through standardized MCP tools.

Repository: https://github.com/jmanhype/dart-mcp-server

## Features
- Task Management (create/update tasks, set priorities, assign members)
- Document Management (create docs, markdown support, reports)
- Space Management (workspaces, folders, access control)
- Dartboard Integration

The server uses dart-tools as its foundation and adds an MCP layer that enables:
- Direct task creation/updates from AI assistants
- Document generation and management
- Workspace organization through AI tools

## Technical Details
- Built with TypeScript and Python
- Uses the MCP SDK for standardized AI tool interfaces
- Integrates with Dart Python SDK
- Full support for all major Dart operations

## Available MCP Tools
- `create_task`: Create new tasks with title, description, priority
- `update_task`: Update existing tasks' status, title, description
- `get_default_status`: Get default status DUIDs
- `get_default_space`: Get default space DUID
- `get_dartboards`: List available dartboards
- `get_folders`: List folders in a space
- `create_folder`: Create new folders
- `create_doc`: Create new documents or reports
- `create_space`: Create new workspaces
- `delete_space`: Delete existing workspaces

Would you be interested in:
1. Reviewing this implementation
2. Potentially including it as an official MCP integration
3. Collaborating on enhancing its features

I'm happy to submit a PR or make any adjustments based on your feedback.

Let me know your thoughts! 