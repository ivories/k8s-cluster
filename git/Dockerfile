# Add a git client to the base image
FROM alpine:latest

COPY init.sh /

#Add git client
RUN apk add --no-cache git && \
    apk add --no-cache openssh-client && \
    chmod +x /init.sh
   
#do not use strict host key check 
    #echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config 

VOLUME /git
WORKDIR /git

ENTRYPOINT ["/init.sh"]
#CMD ["--help"]
