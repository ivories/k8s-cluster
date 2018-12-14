# Add a git client to the base image
FROM alpine:latest

COPY hold.sh /

#Add git client
RUN apk add --no-cache git && \
    apk add --no-cache openssh-client && \
    chmod +x /hold.sh
   
#do not use strict host key check 
    #echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config 

VOLUME /git
WORKDIR /git

ENTRYPOINT ["/hold.sh"]
#CMD ["--help"]
