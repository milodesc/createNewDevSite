#!/bin/sh

#Check number of args
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 URL" >&2
  exit 1
fi

url=$1
newDocRoot="/var/www/$url"

#Append the URL/ip address pair to the /etc/hosts file
sudo echo "127.0.0.1	$url" >> /etc/hosts

#Check to make sure the URL is resolving locally
httpStatus=`curl -o /dev/null --silent --head --write-out '%{http_code}\n' $url`
if [ "$httpStatus" -ne 200 ]; then
  echo "Error: Either your server isn't running or there was a problem changing the /etc/hosts file" >&2
  exit 1
fi

#Copy the default config file and customize the copy
sudo cp /etc/apache2/sites-available/default /etc/apache2/sites-available/$url
sudo sed -i "/ServerAdmin webmaster@localhost/a\\\tServerName $url" /etc/apache2/sites-available/$url
sudo sed -i -e "s@/var/www/default@${newDocRoot}@g" /etc/apache2/sites-available/$url


#<Directory $newDocRoot>

#sudo sed -i '/# http:\/\/who-t.blogspot.com\/2010\/11\/how-to-ignore-configuration-errors.html/a#The next 2 lines were added by the postChrubuntuInstallation script:\nOption "FingerLow" "4"\nOption "FingerHigh" "10"' /usr/share/X11/xorg.conf.d/50-synaptics.conf

#Create and populate the document root
#sudo mkdir -p $newDocRoot
#sudo echo "Congrats! You have a new dev site." > $newDocRoot/index.html

#Activate the site
#sudo a2ensite $url
#service apache2 reload

#Install drupal?

#Open site