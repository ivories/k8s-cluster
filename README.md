# k8s-cluster
about yaml for k8s cluster 


## init --> Execution in command line
cd /home 

sudo mkdir -p core 

cd core

sudo git clone https://github.com/lyclyc88/k8s-cluster.git data

### run nfsd 
#### run nfsd in docker
docker stop nfsd && docker rm nfsd

docker run -d --name nfsd --privileged  -p 2049:2049 -v /home/core/data:/nfsshare  -e SHARED_DIRECTORY=/nfsshare  ivories/nfsd

Add --net=host or -p 2049:2049 to make the shares externally accessible via the host networking stack. This isn't necessary if using Rancher or linking containers in some other way.

Adding -e READ_ONLY=true will cause the exports file to contain ro instead of rw, allowing only read access by clients.

Adding -e SYNC=true will cause the exports file to contain sync instead of async, enabling synchronous mode. Check the exports man page for more information: https://linux.die.net/man/5/exports.

Adding -e PERMITTED="10.11.99.*" will permit only hosts with an IP address starting 10.11.99 to mount the file share.

#### run nfsd in systemctl
sudo cp -rfp /home/core/data/nfsd/nfsd.service /etc/systemd/system/nfsd.service
sudo systemctl daemon-reload && sudo systemctl enable nfsd && sudo systemctl restart nfsd &

#### run nfsd in k8s


#### client mount 
sudo mount -v 10.11.12.101:/ /some/where/here  
or 
sudo mount -v -o vers=4,loud 10.11.12.101:/ /some/where/here










