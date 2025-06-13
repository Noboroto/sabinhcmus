# Use Nginx as the base image
FROM nginx:alpine

# Copy the HTML file and assets to the Nginx web directory
COPY index.html /usr/share/nginx/html/
COPY logo.png /usr/share/nginx/html/
COPY favicon.png /usr/share/nginx/html/

# Create a custom Nginx configuration to prevent caching of QR images
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
