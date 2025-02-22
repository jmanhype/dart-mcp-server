This PR adds a Model Context Protocol (MCP) server implementation that enables AI assistants to interact with Dart through standardized tools.

## Features
- Task Management (create/update tasks, set priorities, assign members)
- Document Management (create docs, markdown support, reports)
- Space Management (workspaces, folders, access control)
- Dartboard Integration

## Implementation Details
- Added MCP server implementation in `dart/mcp/`
- Updated main README with MCP server documentation
- Added TypeScript and Node.js configuration
- Full integration with existing Dart Python SDK

## Testing
The implementation has been tested with:
- Task creation and updates
- Document management
- Space and folder operations
- Status and dartboard queries

Related to #8 