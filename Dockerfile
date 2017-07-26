FROM alpine

LABEL com.ait.docker.ftp.version="1.0"
LABEL vendor="Aspire Information Technologies Limited"
LABEL com.ait.docker.ftp.release-date=${BUILDDATE}
LABEL com.ait.docker.ftp.is-production="false"
LABEL com.ait.docker.ftp.vcs-url="https://github.com/AspireInformationTechnologiesLimited/alpine-ftp"
LABEL com.ait.docker.ftp.cmd="docker run -d -p 20:20 -p 21:21 -p 4400-4470:4400-4470 -e FTP_USER=admin -e FTP_PASS=password -v /host/dools:/opt/drools -e PASV_ADDRESS=0.0.0.0  --restart=always mockftp:v1"

RUN apk upgrade
RUN apk update

ENV FTP_USER admin
ENV FTP_PASS password
ENV PASV_ADDRESS 0.0.0.0
ENV PASV_MIN_PORT 4400
ENV PASV_MAX_PORT 4470
ENV LOG_STDOUT true
ENV DROOLS_HOME=/opt/drools

RUN set -xe \
    && apk --update-cache --no-progress --upgrade add -U  db-utils\
                grep \  
                  vsftpd \
&& rm -rf /var/cache/apk/*


COPY vsftpd.conf /etc/vsftpd/
COPY entryPoint.sh /

VOLUME ${DROOLS_HOME}
RUN chmod 777 /entryPoint.sh

EXPOSE 20 21
CMD sh /entryPoint.sh
