# Installation and Deployment

This document describes installation and deployment of the application on Ubuntu Server. Tested on  Ubuntu Server 14.04 LTE.

## Table of content


1.  Install requirements
  1.  Ruby
  1.  MySQL Server
  1.  Phusion Passenger for Apache2
1.  Deploy application
  1.  Apache Host file
  1.  Passenger restart configuration
  1.  Permissions
  2.  Install missing gems
1.  Application configuration
  1. Secrets
  2. Database connection & rake
  3. Cron job
  4. Application settings and variables
1.  Links

## Install requirements

### 1.i Install Ruby
We recommend to install ruby with a Manager such as Ruby Version Manager (RVM). This installation may conflict with prior ruby installations.
Full documentation is available [here](https://rvm.io/rvm/install).

Install RVM:
We advise a multiuser installation. That way you don't have to setup and configure the ruby environment for multiple users.

Install the stable version of RVM with the command

    \curl -sSL https://get.rvm.io | sudo bash -s stable
Install Ruby Version 2.2.1

    rvm install 2.2.1
You can check the installation with

    ruby -v
Disable rdoc and ri installation for every gem by adding the following line to your ``~/.gemrc`` or ``/etc/gemrc``

    gem: --no-rdoc --no-ri

Install Rails Version 4.2.0

    gem install rails -v 4.2.0

### 1.ii MySQL Server
Install MySQL Server and thedatabase  development files

    sudo apt-get install mysql-server
    sudo apt get install libmysqlclient-dev

You can reset the root password with

    sudo dpkg-reconfigure mysql-server-5.5

### 1.iii Phusion Passenger for Apache2
The Apache2 Webserver is most likely pre-installed, if not you can install Apache2 with

    sudo apt-get install apache2 apache2-doc
Full installation documentation for Phusion Passenger can be found [here](https://www.phusionpassenger.com/documentation/Users%20guide%20Apache.html#installation).

You can install Passenger via APT Repository or Gem:

    gem install passenger
The gem only contains source files. You need to run the installer:

    passenger-install-apache2-module
Check if Apache loads Passenger

    sudo a2enmod passenger
Verify that Passenger is running

    passenger-memory-stats

## Deploy application 

### 2.i  Configure Apache
Deploy the application to ``/var/www/webapp`` or another directory. You need to create an Host file for Apache. Browse to ``/etc/apache2/sites-available``

Create a new file ``ror.conf`` containing the lines
  
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
The variable ``PassengerAppEnv`` defines the ruby Environment. For more information see [here](https://www.phusionpassenger.com/documentation/Users%20guide%20Apache.html#PassengerAppEnv).

### 2.ii Passenger restart coniguration
Passenger needs a file called ``restart.txt`` to be able to automatically restart (e.g if you use continouse integration).
Browse to the applicatipon directory ``/var/www/webapp`` and create a tmp directory and a restart file:

    mkdir tmp
    touch tmp/restart.txt
The file doesn't need to have any content.

### 2.iii Permissions
The Spring gem needs to write to ``/tmp``. You need to change the directory permissions if the spring gem is denied access:

    sudo chmod 1777 -R /tmp
(not 777 nor tmp/)

### 2.iv Install missing gems
Browse to the application root ``webapp/``. In the terminal type

    bundle install

## 3 Application configuration

### 3.i Secrets File
A secrets file named ``secrets.yml`` must be present in ``webapp/config`` and contain the Twitter keys in addition to the secret key base:

    twitter_client_consumer_key: ****
    twitter_client_consumer_secret: ****
    twitter_client_access_token: ****
    twitter_client_access_token_secret:****

### 3.ii Database connection & rake
The database connection can be configured in the file ``database.yml`` located in ``webapp/config``. Our default configuration is:

    adapter: mysql2
    pool: 5
    timeout: 5000
    username: root
    password: root
    encoding: utf8mb4
    collation: utf8mb4_unicode_ci
If you have trouble connecting to the DB, you may specifie the socket path:

    socket: /var/run/mysqld/mysqld.sock
The socket path may vary.
In the application root path ``ẁebapp/`` you can invoke rake to create your DB tables with

    rake db:create
If you need to reset the DB type

    rake db:reset

### 3.iii Cron Job
If you have configured the application you can invoke the cron job. Browse to the application directory ``/var/www/webapp`` and run in the terminal

    whenever --update-crontab MegaUltraTweet
You can check the cron jobs with

    crontab -l
and edit them with

    crontab -e
or directly in the file ``webapp/config/shedule.rb`` .The cron log file is located in ``webapp/log/``



### 3.iv Application settings and variables
The application settings can be changed by setting the global variables in webapp/config/application.rb.

    # Global Variables
    # These values will be initiated as the first hashtags
    # They are always part of the first Startingpoint object
    DEFAULT_STARTING_VALUES = %w[ Technology Smartphone ]
    # Only tweets since this date are taken into account when searching twitter
    TWEETS_SINCE_STRING = 2.days.ago.strftime("%Y-%m-%d")
    # Short rollover is performed every n minutes
    INTERVAL_SHORT_TIME = 15.minutes
    # Long rollover is performed every n days
    INTERVAL_LONG_TIME = 2.days
    # Popularity class returns times of usage of an object for this many short rollover entries
    # Time interval should be consistent with INTERVAL_SHORT_TIME
    POPULARITY_SHORT_INTERVAL = 1
    # Popularity class returns times of usage of an object for this many short rollover entries
    # Time interval should be consistent with INTERVAL_LONG_TIME
    POPULARITY_LONG_INTERVAL = 192
    # This many hashtags are included in the top/bottom statistic
    # used by the Trending object
    TRENDING_HASHTAGS_NUMBER = 20
    # This many hashtags are added to the Startingpoint object
    HASHTAG_TO_START_NUMBER = 30
    # Maximum number of hashtags in Startingpoint object
    HASHTAG_TO_START_MAX = 80
    # Recursive steps taken during search
    QUERY_DEPTH = 5
    # Number of hashtags to start a new query during search
    QUERY_DETAIL = 10
    # Get this many tweets from twitter for each search
    GET_THIS_MANY = 400
    # All tweets older than this are removed during rollover
    DELETE_OLDER_TWEETS = 3.days.ago
    # Search during rollover will stop after this many searches
    # Add some buffer for user input. Max searches provided by twitter is at 450
    PROVIDED_SEARCHES = 400
    # This is the limit as how many tweets in the DB are to be considered. Set to nil to disable.
    DB_SEARCH_LIMIT = 3000
    # Save and analyse tweet only if rank is higher than this value
    TWEET_RELEVANCE_MINIMUM = 1  

## Links
- [Install RVM](https://rvm.io/rvm/install)
- [Phusion Passenger guide](https://www.phusionpassenger.com/documentation/Users%20guide%20Apache.html)
- [Deploy RoR App on Passenger](https://www.phusionpassenger.com/documentation/Users%20guide%20Apache.html#_deploying_a_rack_based_ruby_application)
- [Setup Apache virtual hosts](https://www.digitalocean.com/community/tutorials/how-to-set-up-apache-virtual-hosts-on-ubuntu-14-04-lts)
