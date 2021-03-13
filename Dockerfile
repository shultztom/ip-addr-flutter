# Get nginx to serve
FROM nginxinc/nginx-unprivileged:stable

COPY build/web /usr/share/nginx/html

# Open port
EXPOSE 8080

#Start
CMD ["nginx", "-g", "daemon off;"]