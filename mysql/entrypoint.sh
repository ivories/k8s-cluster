#!/bin/sh

if [ -d /mysql/data/mysql ]; then
  echo "[i] MySQL directory already present, skipping creation"
else
  echo "[i] MySQL data directory not found, creating initial DBs"
  echo 'Initializing database'
  mysql_install_db --user=root > /dev/null
  echo 'Database initialized'
  #sed -i "s/\/run\/mysqld\/mysqld\.sock/$(echo $DATADIR | sed -e 's/\\/\\\\/g' -e 's/\//\\\//g' -e 's/&/\\\&/g')mysqld\.sock/" /etc/mysql/my.cnf
  sed -i "s/\/run\/mysqld\/mysqld\.sock/\/mysql\/mysqld\.sock/" /etc/mysql/my.cnf
  
  if [ "$MYSQL_ROOT_PASSWORD" = "" ]; then
    MYSQL_ROOT_PASSWORD=111111
    echo "[i] MySQL root Password: $MYSQL_ROOT_PASSWORD"
  fi

  tfile=`mktemp`
  if [ ! -f "$tfile" ]; then
      return 1
  fi

  cat << EOF > $tfile
DELETE FROM mysql.user ;
CREATE USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' ;
GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION ;
DROP DATABASE IF EXISTS test ;
EOF
  if [ "$MYSQL_DATABASE" ]; then
    echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` ;" >> "$tfile"
  fi
    
  if [ "$MYSQL_USER" -a "$MYSQL_PASSWORD" ]; then
    echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' ;" >> "$tfile"
    if [ "$MYSQL_DATABASE" ]; then
      echo "GRANT ALL ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%' ;" >> "$tfile"
    fi
  fi
    
  echo 'FLUSH PRIVILEGES ;' >> "$tfile"

  /usr/bin/mysqld --user=root --bootstrap --verbose=0 < $tfile
  rm -f $tfile
fi


exec /usr/bin/mysqld --user=root --console


##!/bin/sh
#set -e
#
#if [ "${1:0:1}" = '-' ]; then
#  set -- mysqld "$@"
#fi
#
#if [ "$1" = 'mysqld' ]; then
#  DATADIR="$("$@" --verbose --help 2>/dev/null | awk '$1 == "datadir" { print $2; exit }')"
#
#  if [ ! -d "$DATADIR/mysql" ]; then
#    if [ -z "$MYSQL_ROOT_PASSWORD" -a -z "$MYSQL_ALLOW_EMPTY_PASSWORD" ]; then
#      echo >&2 'error: database is uninitialized and MYSQL_ROOT_PASSWORD not set'
#      echo >&2 '  Did you forget to add -e MYSQL_ROOT_PASSWORD=... ?'
#      exit 1
#    fi
#
#    echo 'Initializing database'
#    mysql_install_db --ldata="$DATADIR" --user=mysql
#    echo 'Database initialized'
#    sed -i "s/\/run\/mysqld\/mysqld\.sock/$(echo $DATADIR | sed -e 's/\\/\\\\/g' -e 's/\//\\\//g' -e 's/&/\\\&/g')mysqld\.sock/" /etc/mysql/my.cnf
#
#    tempSqlFile='/tmp/mysql-first-time.sql'
#    cat > "$tempSqlFile" << EOSQL
#      DELETE FROM mysql.user ;
#      CREATE USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}' ;
#      GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION ;
#      DROP DATABASE IF EXISTS test ;
#EOSQL
#    
#    if [ "$MYSQL_DATABASE" ]; then
#      echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` ;" >> "$tempSqlFile"
#    fi
#    
#    if [ "$MYSQL_USER" -a "$MYSQL_PASSWORD" ]; then
#      echo "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' ;" >> "$tempSqlFile"
#      if [ "$MYSQL_DATABASE" ]; then
#        echo "GRANT ALL ON \`$MYSQL_DATABASE\`.* TO '$MYSQL_USER'@'%' ;" >> "$tempSqlFile"
#      fi
#    fi
#    
#    echo 'FLUSH PRIVILEGES ;' >> "$tempSqlFile"
#    
#    set -- "$@" --init-file="$tempSqlFile"
#  fi
#  
#  chown -R mysql:mysql "$DATADIR"
#fi
#
#exec "$@"
#
