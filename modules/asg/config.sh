#!/bin/bash

#this config file if for AMI with Amazon Linux 2, which is used for ASG module

URL="https://www.tooplate.com/zip-templates/2150_living_parallax.zip"
ART_NAME='2150_living_parallax'
TEMPDIR="tmp/webfiles"

# Set Variables for Amazon Linux
PACKAGE="httpd wget unzip"
SVC="httpd"

#install yum command

echo "Running Setup on Amazon Linux"
#installing dependencies

echo "######################"
echo "installing packages"
echo "######################"
sudo yum update -y > /dev/null
sudo yum install $PACKAGE -y > /dev/null
echo

echo "######################"
echo "start and enable httpd service"
echo "######################"
sudo systemctl start $SVC
sudo systemctl enable $SVC

echo "######################"
echo"start artifact download and setup"
echo "######################"
sudo mkdir -p $TEMPDIR
cd $TEMPDIR
sudo wget $URL -O artifact.zip > /dev/null
sudo unzip artifact.zip > /dev/null
sudo mv $ART_NAME/* /var/www/html/
cd ..
sudo rm -rf $TEMPDIR

#restarting httpd service
echo "######################"
echo "restarting httpd service"
echo "######################"
sudo systemctl restart $SVC