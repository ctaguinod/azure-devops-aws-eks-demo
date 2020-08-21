export EKS_CLUSTER_NAME="eksdemo-eksctl"
export REPOSITORY_URI="626499166183.dkr.ecr.ap-southeast-1.amazonaws.com/eksdemo"
export TAG=$(Build.BuildId)
echo "BuildId: $TAG"

curl -sS -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/linux/amd64/aws-iam-authenticator
curl -sS -o kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.14.6/2019-08-22/bin/linux/amd64/kubectl
chmod +x ./kubectl ./aws-iam-authenticator
export PATH=$PWD/:$PATH

echo "cd _ctaguinod_azure-devops-aws-eks-demo"
cd _ctaguinod_azure-devops-aws-eks-demo

echo "sed -i 's@CONTAINER_IMAGE@'"$REPOSITORY_URI:$TAG"'@' hello-k8s.yml"
sed -i 's@CONTAINER_IMAGE@'"$REPOSITORY_URI:$TAG"'@' hello-k8s.yml
echo "cat hello-k8s.yml"
cat hello-k8s.yml

echo "aws sts get-caller-identity"
aws sts get-caller-identity

echo "aws eks list-clusters"
aws eks list-clusters

echo "aws eks update-kubeconfig --name $EKS_CLUSTER_NAME"
aws eks update-kubeconfig --name $EKS_CLUSTER_NAME

echo "kubectl get nodes"
kubectl get nodes

echo "kubectl apply -f hello-k8s.yml"
kubectl apply -f hello-k8s.yml