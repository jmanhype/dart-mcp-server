# Dart MCP Server

[![smithery badge](https://smithery.ai/badge/@jmanhype/dart-mcp-server)](https://smithery.ai/server/@jmanhype/dart-mcp-server)

A Model Context Protocol (MCP) server implementation for Dart, providing task management, document handling, and workspace organization capabilities through MCP tools.

<a href="https://glama.ai/mcp/servers/2pdqgspm4q">
  <img width="380" height="200" src="https://glama.ai/mcp/servers/2pdqgspm4q/badge" alt="Dart Server MCP server" />
</a>

## Prerequisites

- Node.js 16.x or higher
- Python 3.8 or higher
- Dart Python SDK installed (`pip install dart-sdk`)
- A valid Dart API token

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

### Installing via Smithery

To install Dart MCP Server for Claude Desktop automatically via [Smithery](https://smithery.ai/server/@jmanhype/dart-mcp-server):

```bash
npx -y @smithery/cli install @jmanhype/dart-mcp-server --client claude
```

### Manual Installation
1. Clone the repository:
```bash
git clone https://github.com/jmanhype/dart-mcp-server.git
cd dart-mcp-server
```

2. Install Node.js dependencies:
```bash
npm install
```

3. Set up Python environment and install Dart SDK:
```bash
# Create and activate virtual environment
python -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate

# Install Dart SDK
pip install dart-sdk
```

4. Set up environment variables:
```bash
# Copy example environment file
cp .env.example .env

# Edit .env with your configuration
# Required: DART_TOKEN
# Optional: PYTHONPATH (path to dart sdk)
```

## Usage

1. Build the TypeScript code:
```bash
npm run build
```

2. Start the MCP server:
```bash
npm start
```

## Development

```bash
# Watch for TypeScript changes
npm run dev

# Run tests
npm test
```

## Environment Variables

Create a `.env` file with the following variables:

```env
# Required: Your Dart API token
DART_TOKEN=your_dart_token_here

# Optional: Path to your Dart SDK installation
PYTHONPATH=/path/to/dart/sdk

# Optional: Python executable path (defaults to system Python)
PYTHON_PATH=/path/to/python
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

## Troubleshooting

If you encounter issues:

1. Verify Python environment:
   ```bash
   python --version
   pip list | grep dart
   ```

2. Check Dart SDK installation:
   ```python
   python -c "import dart; print(dart.__version__)"
   ```

3. Verify environment variables:
   ```bash
   echo $DART_TOKEN
   echo $PYTHONPATH
   ```

## License

MIT License 

# Dart Tools

PyPI Supported Python Versions License 

Dart is Project Management powered by AI.

`dart-tools` is the Dart CLI and Python Library. It enables direct integration with Dart through a terminal CLI or through Python.

* Installation
* Using the CLI
* Using the Python Library
* Using the Python Library in AWS Lambda Functions
* Using the MCP Server
* Advanced Usage
* Help and Resources
* Contributing
* License

## Installation

In the terminal, install by running

```bash
pip install dart-tools
```

## Using the CLI

Start off by setting up authentication with

```bash
dart login
```

Then, you can create a new task with a command along the lines of

```bash
dart createtask "Update the landing page" -p0 --tag marketing
```

which will make a new task called 'Update the landing page' with priority 'Critical' (i.e. P0) and with the 'marketing' tag.

You can explore all of these options and many more with `dart --help` or the more specific help for subcommands, in this case `dart createtask --help`.

Another common workflow is to updating a preexisting task. To do this, run something like

```bash
dart updatetask [DUID] -s Done
```

This command will mark the referenced task 'Done'. Here `[DUID]` is meant to be replaced (including the brackets) with the 'Dart ID' of an existing task. You can get a DUID from any existing task in a number of ways, such as by copying it from the end of a task's URL or by clicking the '...' button in a task page in Dart and then choosing 'Copy ID'.

## Using the Python Library

First, set up authentication. Run `dart login` in the terminal for an interactive process, or visit your Dart profile and then run `dart.login(token)` or save the token into the `DART_TOKEN` environment variable.

Then, you can run something like

```python
import os
from dart import create_task, is_logged_in, update_task

# Check that auth is set up and stop if not, can remove this once everything is set up
is_logged_in(should_raise=True)

# Create a new task called 'Update the landing page' with priority 'Critical' (i.e. p0) and with the 'marketing' tag
new_task = create_task(
    "Update the landing page", priority_int=0, tag_titles=["marketing"]
)

# Update the task to be 'Done'
update_task(new_task.duid, status_title="Done")
```

## Using the MCP Server

The Model Context Protocol (MCP) server implementation enables AI assistants (like Claude) to interact with Dart through standardized tools. This allows for seamless integration of AI capabilities with Dart's task management system.

### Installation

```bash
# Clone the repository
git clone https://github.com/its-dart/dart-tools.git
cd dart-tools/dart/mcp

# Install dependencies
npm install

# Set up Python environment
python -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate
pip install dart-tools

# Configure environment
cp .env.example .env
# Edit .env with your DART_TOKEN
```

### Available MCP Tools

The server provides these MCP tools:
- Task Management (create/update tasks)
- Document Management (create/organize docs)
- Space Management (workspaces/folders)
- Dartboard Integration

For detailed documentation, see [MCP Server README](dart/mcp/README.md).

## Advanced Usage

Almost anything that can be done in Dart can be done with the Python library, but there are not convenient wrapper functions for everything. For most advanced usage, the best thing to do is to get in touch with us and we can help.

However, if you want to explore on your own, the client is well-typed, so you can simply explore the code to see what is possible. All updates will go through the the `dart.transact` function.

As an example, you could run something akin to `update_task` with

```python
from dart import (
    Dart,
    Operation,
    OperationKind,
    OperationModelKind,
    TaskUpdate,
    TransactionKind,
)

# Initialize the inner client
dart = Dart()

# Prepare the update operation
task_update = TaskUpdate(
    duid="[DUID]",
    size=5,
)
task_update_op = Operation(
    model=OperationModelKind.TASK,
    kind=OperationKind.UPDATE,
    data=task_update,
)

# Call the operation transactionally to perform the update
response = dart.transact([task_update_op], TransactionKind.TASK_UPDATE)
```

## Help and Resources

* Homepage
* Web App
* Help Center
* Bugs and Features
* Library Source
* Chat on Discord
* Email us at support@itsdart.com

## Contributing

Contributions are welcome! Please open an issue or submit a pull request.

## License

This project is licensed under the MIT License. 