# EKS-Terraform
EKS-Terraform deploys new eks cluster and all its dependencies.

## Getting Started
Those instructions will deploy the cluster on AWS, see deploy section on how to deploy the project.

### Prerequisites
AWS Cli - In order to deploy your enviroment, you must configure you AWS CLI with your properties.
```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```
AWS IAM Authenticator - Amazon EKS uses IAM to provide authentication to your Kubernetes cluster using that tool.
```
curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.18.9/2020-11-02/bin/linux/amd64/aws-iam-authenticator
chmod +x ./aws-iam-authenticator
mkdir -p $HOME/bin && cp ./aws-iam-authenticator $HOME/bin/aws-iam-authenticator && export PATH=$PATH:$HOME/bin
echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc
```
Kubectl - In order to control K8S cluster.
```
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
yum install -y kubectl
```

### Installing
First step is to configure our aws cli, which is done by running:
```
aws configure
```
Then we can start and deploy our EKS on AWS, by doing those steps:
1. terraform init - Downloads all required modules.
2. terraform plan(optional) - Showing execution plan, showing everything that will create/change.
3. terraform apply - applying the changes, and deploying it. 

### Deployment
Deploys those components:
* Configure new VPC and 6 subnets(3 Public and 3 Private).
* Configure new SG for workers.
* Deploy new EKS-Cluster.
* Creates new node-group and add it to the cluster.
* Configure kubernetes provider and deploy registry deployment and NodePort service.

In order to start working with the cluster, you must run that command:
```
aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)
```
It creates a new kubeconfig in ~/.kube/config which allows us to contact with the cluster.

## Built With
* Terraform - infrastructure as code software

## Authors
* Moshik Baruch
