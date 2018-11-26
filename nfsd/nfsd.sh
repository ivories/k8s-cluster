#! /bin/sh
#
# nfsd.sh

echo "$NFS_DIR $NFS_DOMAIN($NFS_OPTION)" > /etc/exports
/usr/sbin/exportfs -r
/sbin/rpcbind -s
/usr/sbin/rpc.nfsd -N 2 -N 3 8 |:
/usr/sbin/rpc.mountd -F
