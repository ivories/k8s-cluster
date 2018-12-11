FROM alpine:latest

RUN apk add --update mariadb mysql-client && rm -f /var/cache/apk/* 

COPY entrypoint.sh /
COPY my.cnf /etc/mysql/my.cnf

EXPOSE 3306
CMD ["/entrypoint.sh"]


#FROM alpine:3.8
#COPY ./entrypoint.sh /
#
#RUN chmod +x /entrypoint.sh \
#    && apk --update add mariadb mysql-client bash \
#    && addgroup mysql mysql \
#    && rm -rf /var/lib/mysql \
#    && mkdir -p /var/lib/mysql \
#    && chown -R mysql:mysql /var/lib/mysql \
#    && chown -R mysql:mysql /etc/mysql/ \
#    && rm -rf /var/cache/apk/* \
#    && echo "export TERM=xterm" >> /root/.bashrc
#    
##RUN chown -R mysql:mysql /var/lib/mysql \
##    && chown -R mysql:mysql /etc/mysql/
#    
#VOLUME /var/lib/mysql /var/log/mysql /etc/mysql/ /tmp
#
#EXPOSE 3306
#USER mysql
#
#ENTRYPOINT [ "/entrypoint.sh" ]
#CMD [ "mysqld", "--user=mysql" ]
