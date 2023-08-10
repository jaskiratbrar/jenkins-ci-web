# Use Nginx as the base image
FROM nginx:latest

# Copy the web pages into the container
COPY page1.html /var/www/html/
COPY page2.html /var/www/html/
COPY page3.html /var/www/html/

# Expose port 80 for HTTP
EXPOSE 80
