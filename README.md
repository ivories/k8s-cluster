# k8s-cluster
about yaml for k8s cluster 
 
 
 
## init --> Execution in command line
cd /home 

sudo mkdir -p core 

cd core

sudo git clone https://github.com/lyclyc88/k8s-cluster.git data

cd ~/

ln -s /home/core/data/shell/.bash_aliases .bash_aliases 

## run nfsd 
#### in docker
docker stop nfsd && docker rm nfsd

docker run -d --name nfsd --privileged  -p 2049:2049 -v /home/core/data:/nfsshare  -e SHARED_DIRECTORY=/nfsshare  ivories/nfsd

Add --net=host or -p 2049:2049 to make the shares externally accessible via the host networking stack. This isn't necessary if using Rancher or linking containers in some other way.

Adding -e READ_ONLY=true will cause the exports file to contain ro instead of rw, allowing only read access by clients.

Adding -e SYNC=true will cause the exports file to contain sync instead of async, enabling synchronous mode. Check the exports man page for more information: https://linux.die.net/man/5/exports.

Adding -e PERMITTED="10.11.99.*" will permit only hosts with an IP address starting 10.11.99 to mount the file share.

#### with systemctl
sudo cp -rfp /home/core/data/nfsd/nfsd.service /etc/systemd/system/nfsd.service

sudo systemctl daemon-reload && sudo systemctl enable nfsd && sudo systemctl restart nfsd &

#### client mount in docker
docker run -d --name nfsc --privileged  -v /home/core/data:/nfsshare -e SHARED_DIRECTORY=/nfsshare ivories/nfsd

docker exec -it nfsc

sudo mount -v 172.18.0.2:/ /data

or

sudo mount -v -o vers=4,loud 172.18.0.2:/ /data

### in k8s
#### client mount in k8s





## auto create disk for pod to use
### execute in k8s master: kc pvc-auto-gce.yaml
## manually create disk for pod to use  --> see https://my.oschina.net/styshoo/blog/1329693
### first
##### execute in k8s master: gcloud compute disks create --size=10GB gce-disk
##### or create on GCP->disk
### second
##### execute in k8s master: kc pv-gce.yaml














