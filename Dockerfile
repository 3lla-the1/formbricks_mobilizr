FROM node:18

RUN npm install -g pnpm

WORKDIR /app
COPY . .

# Install deps
RUN pnpm install

# 👇 Create a dummy .env to satisfy Next.js during build
RUN touch /app/apps/web/.env

# Build all workspace packages
RUN pnpm build

EXPOSE 3000

# 👇 These ENV vars are automatically injected by Render at runtime
CMD ["pnpm", "start"]
