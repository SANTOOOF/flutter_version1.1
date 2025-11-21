# Multi-stage Dockerfile to build Flutter Web and serve with Nginx

# ===== Build stage =====
FROM ghcr.io/cirruslabs/flutter:stable AS build
WORKDIR /app

# Pre-cache dependencies
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

# Copy sources and build for web
COPY . .
RUN flutter config --enable-web \
    && flutter pub get \
    && flutter build web --release

# ===== Runtime stage =====
FROM nginx:alpine

# Nginx config (adds single-page routing and API reverse proxy)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Static files
COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
