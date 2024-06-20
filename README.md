# Latest Jenkins on Debian
This is my way of getting latest Jenkins to Debian.  
One script to install Jenkins including:  
- creating systemd service
- creating OS user
- downloading Jenkins WAR file

And second update script:
- which will download new WAR file, and apply if its different
  
Shared config file for both scripts.

## Java version
Your probably want to check whats the defautl Java version on your host
> update-alternatives --config java
