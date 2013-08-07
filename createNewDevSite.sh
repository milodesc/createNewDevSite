#!/bin/sh

#Prompt for URL

#Add the URL to the /etc/hosts file

#Check to make sure the URL is resolving locally
#wget

#Copy the config file
sudo cp /etc/apache2/sites-available/default /etc/apache2/sites-available/newSite2.com

#Create and populate the document root
sudo mkdir -p /var/www/newSite2.com
sudo echo "Congrats! You have a new dev site." > /var/www/newSite2.com/index.html

#Activate the site
sudo a2ensite newSite2.com
service apache2 reload