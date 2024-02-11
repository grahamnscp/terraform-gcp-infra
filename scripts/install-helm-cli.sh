#/bin/bash

source ./params.sh
source ./load-tf-output.sh
source ./utils.sh

# Node IP number to deploy to, default to 1 if not passed into script
NODEIPNUM=$1
NODEIPNUM=${NODEIPNUM:=1}
NODEIP=${NODE_PUBLIC_IP[$NODEIPNUM]}

# helm cli install
LogStarted "Installing helm cli (IP: $NODEIP).."
# note! this is for a centos instance as uses yum! (openssl package needed for helm client, fails if not present)
ssh -t $SSH_OPTS ${SSH_USERNAME}@${NODEIP} "sudo yum install -y openssl"
ssh -t $SSH_OPTS ${SSH_USERNAME}@${NODEIP} "curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3"
ssh -t $SSH_OPTS ${SSH_USERNAME}@${NODEIP} "bash ./get_helm.sh"

LogElapsedDuration
LogCompleted "Done."
exit 0

