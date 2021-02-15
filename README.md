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
Kubectl - In order to control K8S cluster
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
In order to install run those commands:
1. terraform init - Downloads all required modules
2. terraform plan(optional) - Showing execution plan, showing everything that will create/change
3. terraform apply - applying the changes, and deploying it. 

### Deployment


## Built With
* Terraform - infrastructure as code software

## Authors
* Moshik Baruch
