FROM node:18

RUN npm install -g pnpm

WORKDIR /app
COPY . .

# Install deps
RUN pnpm install

# 👇 Prevent Next.js from failing during build
RUN touch /app/apps/web/.env

# Build everything
RUN pnpm build

EXPOSE 3000

# At runtime, Render will inject the env vars automatically
CMD ["pnpm", "start"]
