# Use nginx alpine for a lightweight image
FROM nginx:alpine

# Copy all HTML files to nginx's default serving directory
COPY *.html /usr/share/nginx/html/
COPY styles.css /usr/share/nginx/html/styles.css

# Copy SEO files (robots.txt and sitemap.xml)
COPY robots.txt /usr/share/nginx/html/robots.txt
COPY sitemap.xml /usr/share/nginx/html/sitemap.xml

# Copy custom nginx configuration (optional, for better performance)
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"] 