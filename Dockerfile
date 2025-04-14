FROM node:18

# Accept build args
ARG DATABASE_URL
ARG ENCRYPTION_KEY
ARG NEXTAUTH_SECRET
ARG NEXTAUTH_URL

# Export as env vars
ENV DATABASE_URL=$DATABASE_URL
ENV ENCRYPTION_KEY=$ENCRYPTION_KEY
ENV NEXTAUTH_SECRET=$NEXTAUTH_SECRET
ENV NEXTAUTH_URL=$NEXTAUTH_URL

RUN npm install -g pnpm

WORKDIR /app
COPY . .

# Install deps
RUN pnpm install

# 👇 Fix the missing .env file error during build
RUN touch /app/apps/web/.env

# Build all workspace packages (including logger + web)
RUN pnpm build

EXPOSE 3000
CMD ["pnpm", "start"]
