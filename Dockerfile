# Use nginx alpine for a lightweight image
FROM nginx:alpine

# Copy the HTML and CSS files to nginx's default serving directory
COPY index.html /usr/share/nginx/html/index.html
COPY styles.css /usr/share/nginx/html/styles.css

# Copy custom nginx configuration (optional, for better performance)
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"] 