FROM node:18

# Accept build args
ARG DATABASE_URL
ARG ENCRYPTION_KEY
ARG NEXTAUTH_SECRET
ARG NEXTAUTH_URL

# Export as env vars for the build
ENV DATABASE_URL=$DATABASE_URL
ENV ENCRYPTION_KEY=$ENCRYPTION_KEY
ENV NEXTAUTH_SECRET=$NEXTAUTH_SECRET
ENV NEXTAUTH_URL=$NEXTAUTH_URL

RUN npm install -g pnpm

WORKDIR /app
COPY . .

# Install all workspace dependencies
RUN pnpm install

# 👇 Build ALL packages (including @formbricks/logger)
RUN pnpm build

# Move to the web app
WORKDIR /app/apps/web

# Still needed for Next.js
RUN touch .env

EXPOSE 3000
CMD ["pnpm", "start"]
