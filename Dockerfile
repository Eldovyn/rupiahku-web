# Build stage
FROM oven/bun:1 as build-stage
WORKDIR /app

# Declare build arguments - Vite embed VITE_* saat BUILD (bukan runtime)
# Nilai ini akan ke-bake ke dalam dist/*.js
ARG VITE_API_BASE_URL
ARG VITE_STELLAR_CONTRACT_ADDRESS
ARG VITE_SEPOLIA_CONTRACT_ADDRESS

# Set environment variables for the build
ENV VITE_API_BASE_URL=$VITE_API_BASE_URL
ENV VITE_STELLAR_CONTRACT_ADDRESS=$VITE_STELLAR_CONTRACT_ADDRESS
ENV VITE_SEPOLIA_CONTRACT_ADDRESS=$VITE_SEPOLIA_CONTRACT_ADDRESS

# Copy package files and install dependencies
COPY package.json bun.lock* ./
RUN bun install

# Copy all source files and build
COPY . .
RUN bun run build

# Production stage
FROM nginx:alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose port 80
EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
