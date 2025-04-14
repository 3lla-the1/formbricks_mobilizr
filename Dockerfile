FROM node:18

# Accept build args
ARG DATABASE_URL
ARG ENCRYPTION_KEY
ARG NEXTAUTH_SECRET
ARG NEXTAUTH_URL

# Export them as environment variables
ENV DATABASE_URL=$DATABASE_URL
ENV ENCRYPTION_KEY=$ENCRYPTION_KEY
ENV NEXTAUTH_SECRET=$NEXTAUTH_SECRET
ENV NEXTAUTH_URL=$NEXTAUTH_URL

RUN npm install -g pnpm

WORKDIR /app
COPY . .

RUN pnpm install

# 👇 Create dummy .env so Next.js doesn't freak out
RUN touch /app/apps/web/.env

# 👇 Build with all env vars available
RUN pnpm build

EXPOSE 3000
CMD ["pnpm", "start"]
