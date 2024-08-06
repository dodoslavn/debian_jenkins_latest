# Latest Jenkins on Debian
This is my way of getting latest Jenkins to Debian.  
One script to install Jenkins including:  
- creating systemd service
- creating OS user
- downloading Jenkins WAR file

And second update script:
- which will download new WAR file, and apply if its different
  
Shared config file for both scripts.

## How to use it
1. clone the repo
2. make a new copy of the config file e.g. :
   1. enter script directory:
      > $ cd scripts ;
   2. copy config file:
      > $ cp config.sh.example config.sh ;
   3. modify if needed:
      > $ vi config.sh ;
3. run installation script with root privileges:
   > \# ./install.sh ;
4. add "update.sh" script to crontab with root privileges to every day so you get the updates


## Java version
Your probably want to check whats the defautl Java version on your host
> update-alternatives --config java
