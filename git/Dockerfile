# Add a git client to the base image
FROM alpine:latest
COPY hold.sh /git 
#Add git client
RUN apk add --no-cache git && \
    apk add --no-cache openssh-client && \
    chmod +x /git/hold.sh
   
#do not use strict host key check 
    #echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config 

VOLUME /git
WORKDIR /git

ENTRYPOINT ["/git/hold.sh"]
#CMD ["--help"]
