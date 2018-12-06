
sudo  git config --global user.email "lyclyc88@126.com"
sudo  git config --global user.name "Eric.Liu"

export PATH=$PATH:/home/core/data/shell

###GlusterFS Heketi###
export HEKETI_CLI_SERVER=$(kubectl get svc/heketi --template 'http://{{.spec.clusterIP}}:{{(index .spec.ports 0).port}}')

###Vi###
alias svi='sudo vi'

###Git###
alias gpl='sudo git pull'
alias gps='sudo git push'
alias sgpl='sudo git pull'
alias sgps='sudo git push'
alias gcm='sudo git commit -m'
alias sgcm='sudo git commit -m'
alias ga='sudo git add'
alias sga='sudo git add'
alias gadd='sudo git add'
alias sgadd='sudo git add'
alias gs='git status'

###Kubectl
alias kddep='kubectl delete deployment'
alias kdpod='kubectl delete pod'
alias kdsvc='kubectl delete svc'
