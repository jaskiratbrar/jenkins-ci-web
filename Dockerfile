# Use Nginx as the base image
FROM nginx:latest

# Copy the web pages into the container
COPY page1.html /usr/share/nginx/html/
COPY page2.html /usr/share/nginx/html/
COPY page3.html /usr/share/nginx/html/

# Expose port 80 for HTTP
EXPOSE 80
