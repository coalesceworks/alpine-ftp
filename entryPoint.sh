#!/bin/bash

#Set Passive port range
echo "pasv_address=${PASV_ADDRESS}" >> /etc/vsftpd/vsftpd.conf
echo "pasv_max_port=${PASV_MAX_PORT}" >> /etc/vsftpd/vsftpd.conf
echo "pasv_min_port=${PASV_MIN_PORT}" >> /etc/vsftpd/vsftpd.conf

# Add user and associate password
adduser $FTP_USER
echo $FTP_USER:$FTP_PASS | chpasswd
echo "$FTP_USER" >> /etc/vsftpd.userlist

# Create directories with port name
cd /home/$FTP_USER
grep "FTP," $DROOLS_HOME/csv/destinations.csv | cut -d, -f1 | xargs -r mkdir
chmod 777 -R /home/$FTP_USER

# Run vsftpd:
&>/dev/null /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
