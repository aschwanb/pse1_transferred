# Installation and Deployment

This document describes installation and deployment of the application on Ubuntu Server. Tested on  Ubuntu 14.04 LTE.

## Table of content


1.  Install Requirements
  1.  Ruby
  1.  MySQL Server
  1.  Passenger for Apache2
1.  Deploy application
  1.  Apache Host file
  1.  Passenger restart configuration
  1.  Secrets
  1.  Permissions
1.  Application configuration
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
