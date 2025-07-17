# Use the official PHP 8 Apache base image
FROM php:8.2-apache

# Enable Apache modules
RUN a2enmod rewrite headers

# Copy your PHP application into the Apache document root
COPY src/ /var/www/html/

# Add Apache CORS configuration
RUN { \
    echo '<IfModule mod_headers.c>'; \
    echo '    Header set Access-Control-Allow-Origin "*"'; \
    echo '    Header set Access-Control-Allow-Methods "GET, POST, PUT, DELETE, OPTIONS"'; \
    echo '    Header set Access-Control-Allow-Headers "Content-Type, Authorization"'; \
    echo '</IfModule>'; \
} > /etc/apache2/conf-available/cors.conf

# Enable the CORS config
RUN a2enconf cors

# Expose port 80
EXPOSE 80

CMD ["apache2-foreground"]
