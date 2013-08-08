#!/bin/sh

#Check number of args
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 URL" >&2
  exit 1
fi

#Append the URL/ip address pair to the /etc/hosts file
sudo echo "127.0.0.1	$1" >> /etc/hosts

#Check to make sure the URL is resolving locally
httpStatus=`curl -o /dev/null --silent --head --write-out '%{http_code}\n' $1`
if [ "$httpStatus" -ne 200 ]; then
  echo "Error: Either your server isn't running or there was a problem changing the /etc/hosts file" >&2
  exit 1
fi

#Copy the config file and edit the copy
#sudo cp /etc/apache2/sites-available/default /etc/apache2/sites-available/$1
#ServerName $1
#DocumentRoot /var/www/$1
#<Directory /var/www/$1>

#Create and populate the document root
#sudo mkdir -p /var/www/$1
#sudo echo "Congrats! You have a new dev site." > /var/www/$1/index.html

#Activate the site
#sudo a2ensite $1
#service apache2 reload