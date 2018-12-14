# Add a git client to the base image
FROM alpine:latest
#Add git client
RUN apk add --no-cache git && \
    apk add --no-cache openssh-client 

#do not use strict host key check 
    #echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config 

VOLUME /git
WORKDIR /git

ENTRYPOINT ["while true ;do  sleep 10; done"]
#CMD ["--help"]
