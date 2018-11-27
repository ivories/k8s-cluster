# k8s-cluster
about yaml for k8s cluster 


## init --> Execution in command line
cd /home 

sudo mkdir -p core 

cd core

sudo git clone https://github.com/lyclyc88/k8s-cluster.git data

### run nfsd in docker
docker run -d --name nfsd --privileged  -p 2049:2049 -v /home/core/data:/nfsshare  -e SHARED_DIRECTORY=/nfsshare  ivories/nfsd

### run nfsd in systemctl
sudo cp -rfp /home/core/data/nfsd/nfsd.service /etc/systemd/system/nfsd.service
sudo systemctl daemon-reload && sudo systemctl enable nfsd && sudo systemctl restart nfsd &

### run nfsd in k8s


