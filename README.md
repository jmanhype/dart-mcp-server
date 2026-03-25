# dart-mcp-server

[![smithery badge](https://smithery.ai/badge/@jmanhype/dart-mcp-server)](https://smithery.ai/server/@jmanhype/dart-mcp-server)

MCP server that bridges the [Dart](https://itsdart.com) project management platform to AI assistants. The server is TypeScript but delegates all Dart API calls to a Python subprocess using the `dart-sdk` package.

## What It Does

Exposes Dart's task management, document, space, and dartboard operations as MCP tools. Each tool call spawns a Python process that imports `dart-sdk`, executes the operation, and returns JSON results over stdout. Communicates with MCP clients over stdio.

## Status

| Area | State |
|------|-------|
| MCP transport | stdio |
| Language | TypeScript (server) + Python (Dart SDK calls) |
| MCP SDK | `@modelcontextprotocol/sdk` ^1.5.0 |
| Dart SDK | `dart-sdk` (pip, called via subprocess) |
| Node.js | >= 16.0.0 |
| Python | >= 3.8.0 |
| License | MIT |

## MCP Tools

| Tool | What It Does |
|------|-------------|
| `create_task` | Create a task with title, description, priority, status, assignees, tags |
| `update_task` | Update an existing task's status, title, or description by DUID |
| `get_default_status` | Return default status DUIDs for a dartboard |
| `get_default_space` | Return the default space DUID |
| `get_dartboards` | List available dartboards |
| `get_folders` | List folders in a space |
| `create_folder` | Create a new folder |
| `create_doc` | Create a document or report |
| `create_space` | Create a new workspace |
| `delete_space` | Delete a workspace by DUID |

## Setup

### Via Smithery

```bash
npx -y @smithery/cli install @jmanhype/dart-mcp-server --client claude
```

### Manual

```bash
git clone https://github.com/jmanhype/dart-mcp-server.git
cd dart-mcp-server
npm install          # also runs postinstall: creates .venv and pip installs dart-sdk
npm run build
npm start
```

### Environment Variables

| Variable | Required | Description |
|----------|----------|-------------|
| `DART_TOKEN` | Yes | Dart API token (get from your Dart profile) |
| `PYTHONPATH` | No | Path to Dart SDK if not in default location |
| `PYTHON_PATH` | No | Path to Python executable (defaults to system Python) |

### Verifying the Python Environment

```bash
python -c "import dart; print(dart.__version__)"
```

If this fails, the MCP server will not be able to execute any tools.

## Architecture

```
src/
  index.ts  — MCP server, tool handlers, Python subprocess management
  test.ts   — Basic test runner
```

Each tool handler builds a Python script as a string, spawns `python3 -c "<script>"`, and parses the JSON output. The Python process has a 120-second timeout.

## Limitations

- Every tool call spawns a new Python process (no persistent connection to Dart API)
- The `.env` path is hardcoded to `/Users/speed/dart-tools/.env` in the source
- No input validation beyond what the Dart SDK provides
- No pagination support for list operations
- Error messages from the Python subprocess are passed through as-is
- The `postinstall` script creates a virtualenv, which may fail in some CI environments

## Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `@modelcontextprotocol/sdk` | ^1.5.0 | MCP server protocol |
| `dotenv` | ^16.4.7 | Environment variable loading |
| `typescript` | ^5.3.3 | Build toolchain |
| `dart-sdk` | (pip) | Python client for Dart API |

## License

MIT
