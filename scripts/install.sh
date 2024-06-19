#!/bin/bash

# load configuration
source ./config.sh

# check if you are root user
if [ "$(whoami)" != "root" ]
	then
	echo "ERROR: You need to be root for installation!"
	exit 1
	fi

# check if service is already created
if [ -a "$SERVICE_FILE_PATH""$SERVICE_NAME" ]
	then
	echo "ERROR: Service is already created!"
	exit 2
	fi

# add system user to run Jenkins service/process
if ! [ -z "$( grep $SERVICE_USER: /etc/passwd )" ]
	then
	echo "ERRPR: User $SERVICE_USER already exists!"
	exit 4
	fi
useradd -d $JENKINS_DIR $SERVICE_USER 

# create temporar directory where Jenkisn will be downloaded
mkdir -p $TMP_DL_DIR

# download latest jenkins
wget $JENKINS_DL_URL -O $TMP_DL_DIR"jenkins.war" 

# create directory where Jenkisn WAR file will be saved
mkdir -p $JENKINS_DIR
RC=$?

if [ "$RC" -ne "0" ]
	then
	echo "ERROR: Jenkins folder couldnt be created!"
	exit 3
	fi

# create folder where Jenkisn keeps its things
mkdir -p $JENKINS_DIR'data/'

# copy downloaded Jenkins WAR file to your folder
cp $TMP_DL_DIR"jenkins.war" $JENKINS_DIR""$JENKINS_WAR

# install systemd service file
bash ./jenkins-custom.service > $SERVICE_FILE_PATH""$SERVICE_NAME

# set permissions
chown -R $SERVICE_USER:$SERVICE_USER $JENKINS_DIR 
chmod -R 750 $JENKINS_DIR

# reload systemd
systemctl daemon-reload
systemctl start $SERVICE_NAME
systemctl enable $SERVICE_NAME
systemctl status $SERVICE_NAME
