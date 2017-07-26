# alpine-ftp

Simple ftp server based on vsftpd.

# Usage
	$ docker run -d -p 20:20 -p 21:21 -p 4400-4470:4400-4470 -e FTP_USER=admin -e FTP_PASS=password -v /host/dools:/opt/drools -e PASV_ADDRESS=0.0.0.0  --restart=always mockftp:v1

