# Nginx image in the Docker Hub
FROM nginx:latest

# Nginx configuration
COPY nginx/nginx.conf /etc/nginx/nginx.conf

# Exposing the port 8002
EXPOSE 8002

# Health Check 
HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD curl -f http://localhost:8002/ || exit 1

# default command to run Nginx
CMD ["nginx", "-g", "daemon off;"]