# Installation and Deployment

This document describes installation and deployment of the application on Ubuntu Server. Tested on  Ubuntu Server 14.04 LTE.

## Table of content


1.  Install Requirements
  1.  Ruby
  1.  MySQL Server
  1.  Phusion Passenger for Apache2
1.  Deploy application
  1.  Apache Host file
  1.  Passenger restart configuration
  1.  Permissions
1.  Application configuration
  1. Secrets
  2. Database connection
  3. Cron job
1.  Server Debugging
1.  Notes and Links

## 1.i Install Ruby
We recommend to install ruby with a Manager such as Ruby Version Manager (RVM). This installation may conflict with prior ruby installations.
Full documentation is available here: https://rvm.io/rvm/install

Install RVM:
We advise a multiuser installation. That way you don't have to setup and configure the ruby environment for multiple users.

Install the stable version of RVM with the command

    \curl -sSL https://get.rvm.io | sudo bash -s stable
Install Ruby Version 2.2.1

    rvm install 2.2.1
You can check the installation with

    ruby -v
Disable rdoc and ri installation for every gem by adding the following line to your ~/.gemrc or /etc/gemrc

    gem: --no-rdoc --no-ri

Install Rails Version 4.2.0

    gem install rails -v 4.2.0

## 1.ii MySQL Server
Install MySQL Server and thedatabase  development files

    sudo apt-get install mysql-server
    sudo apt get install libmysqlclient-dev

You can reset the root password with

    sudo dpkg-reconfigure mysql-server-5.5

## 1.iii Phusion Passenger for Apache2
The Apache2 Webserver is most likely pre-installed, if not you can install Apache2 with

    sudo apt-get install apache2 apache2-doc
Full installation documentation for Phusion Passenger can be found here: https://www.phusionpassenger.com/documentation/Users%20guide%20Apache.html#installation

You can install Passenger via APT Repository or Gem:

    gem install passenger
The gem only contains source files. You need to run the installer:

    passenger-install-apache2-module
Check if Apache loads Passenger

    sudo a2enmod passenger
Verify that Passenger is running

    passenger-memory-stats

## 2.i  Configure Apache
Deploy the application to /var/www/webapp or another directory. You need to create an Host file for Apache. Browse to /etc/apache2/sites-available

Create a new file ror.conf containing the lines
  
    <VirtualHost *:80>
      ServerName pse1.iam.unibe.ch
      DocumentRoot /var/www/webapp/public
      Alias /phpmyadmin /var/www/phpmyadmin
      <Directory /var/www/webapp/public>
        Allow from all
        Options -MultiViews
        PassengerAppEnv development
        # Uncomment this if you're on Apache >= 2.4:
        #Require all granted
      </Directory>
    </VirtualHost>
The variable PassengerAppEnv defines the ruby Environment. For more information see https://www.phusionpassenger.com/documentation/Users%20guide%20Apache.html#PassengerAppEnv

## 2.ii Passenger restart coniguration
Passenger needs a file called restart.txtto be able to automatically restart (e.g if you use continouse integration).
Browse to the applicatipon directory /var/www/webapp and create a tmp directory and a restart file:

    mkdir tmp
    touch tmp/restart.txt
The file doesn't need to have any content.

## 2.iii Permissions
The Spring gem needs to write to /tmp. You need to change the directory permissions if the spring gem is denied access:

    sudo chmod 1777 -R /tmp
(not 777 nor tmp/)

## 3.i Secrets File
## 3.ii Database connection
## 3.iii Cron Job
If you have configured the application you can invoke the cron job. Browse to the application directory /var/www/webapp and run in the terminal

    whenever --update-crontab MegaUltraTweet
You can check the cron jobs with

    crontab -l
and edit them directly with

    crontab -e
