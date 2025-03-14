# Generated by https://smithery.ai. See: https://smithery.ai/docs/config#dockerfile
# Use the official Node.js image as the base image
FROM node:16-alpine AS builder

# Set the working directory
WORKDIR /app

# Copy the package.json and package-lock.json to the working directory
COPY package.json package-lock.json ./

# Install Node.js dependencies
RUN npm install

# Copy the rest of the application code to the working directory
COPY . .

# Build the TypeScript code
RUN npm run build

# Use a Python image to set up the Python environment
FROM python:3.8-slim AS python-env

# Set the working directory
WORKDIR /app

# Copy the built Node.js application from the builder stage
COPY --from=builder /app/build /app/build
COPY --from=builder /app/package.json /app/package.json
COPY --from=builder /app/package-lock.json /app/package-lock.json

# Install the Dart SDK in the Python environment
RUN python -m venv .venv && \
    . .venv/bin/activate && \
    pip install dart-sdk

# Install only production dependencies
RUN npm install --production

# Copy the .env.example to .env and set environment variables
COPY .env.example .env

# Set environment variables for Dart API token and Python path
ENV DART_TOKEN=your_dart_token_here
ENV PYTHONPATH=/app/.venv/lib/python3.8/site-packages

# Expose the port on which the server will run
EXPOSE 3000

# Start the MCP server
CMD ["node", "build/index.js"]
