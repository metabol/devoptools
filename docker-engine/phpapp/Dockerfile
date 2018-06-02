#PHP 5.6 Image
FROM php:5.6


#CHANGE TO appdir
WORKDIR /app


#Add source code 
ADD . /app


#Expose PORT 80
EXPOSE 80

#CMD START PHP SERVER
CMD ["php", "-S", "0.0.0.0:80", "-t", "/app"]

