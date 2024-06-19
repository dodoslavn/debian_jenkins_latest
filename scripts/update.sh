#!/bin/bash

# move to folder of this script
cd $(dirname "$( realpath "$0" )")

# load configuration
source ./config.sh

if [ "$(whoami)" != "$SERVICE_USER" ] && [ "$(whoami)" != "root" ]
	then
	echo $(date '+%Y.%m.%d_%H:%M')" - ERROR - You need to be root or service user"
	exit 1
	fi

# download latest jenkins
wget $JENKINS_DL_URL -O $TMP_DL_DIR"jenkins.war"

cmp $TMP_DL_DIR"jenkins.war" $JENKINS_DIR""$JENKINS_WAR
RC=$?

if [ "$RC" -eq 0 ]
	then
	echo $(date '+%Y.%m.%d_%H:%M')" - INFO - There is nothing to update"
	echo $(date '+%Y.%m.%d_%H:%M')" - INFO - There is nothing to update" >> ../logs/update_$SERVICE_NAME.log
	exit 0
	fi
echo $(date '+%Y.%m.%d_%H:%M')" - INFO - Version updated"
echo $(date '+%Y.%m.%d_%H:%M')" - INFO - Version updated" >> ../logs/update_$SERVICE_NAME.log

# copy downloaded Jenkins WAR file to your folder
cp $TMP_DL_DIR"jenkins.war" $JENKINS_DIR""$JENKINS_WAR

systemctl restart $SERVICE_NAME
