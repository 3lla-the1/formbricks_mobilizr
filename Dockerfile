# Dockerfile
FROM node:18

# Install pnpm
RUN npm install -g pnpm

WORKDIR /app

COPY . .

# Install all dependencies
RUN pnpm install

# Build only the web app
WORKDIR /app/apps/web
RUN pnpm build

# Expose web server port
EXPOSE 3000

# Start the app
CMD ["pnpm", "start"]
