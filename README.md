# SE Demo Host Terraform
Sample terraform to provision GCP demo infra stacks

![tf gcp image](images/tf_gcp.png)

The terraform provider is for GCP specifically as the resource names are different for each public cloud provider, see full docs 
[here](https://cloud.google.com/docs/terraform)

## Getting Started
Copy the example tfvars file:
```
cp terraform.tfvars.example terraform.tfvars
```

Modify the terraform.tfvars file values as appropriate  
ex:
```
# tfvars
#

# Unique prefix for resources
prefix= "my"

# Resource tag labels
purpose="demos"
owner="me"
slack_owner="myslack"
expires_on="2023-02-11"

# Number of instances to provision
instance_count=2
instance_type="e2-standard-8"
os_image="ubuntu-os-cloud/ubuntu-2204-lts"

# Allow fw access from
myCIDR=XX.XX.XX.XXX/32"
myTravelCIDR="XX.XX.XX.XXX/32"

# SSH user
my_ssh_user="myusername"
my_ssh_pub_key_file="~/.ssh/myusername.pub"

# GCP provider
region="us-east1"
zone="us-east1-b"
project="my-gcp-project-here"
```

The my_ssh_user will be inserted into the instance with the authorized key from my_ssh_pub_key_file

## Setup Terrform
Terraform needs initialising in the local directory so the OS plugin can be installed ready to use, this creates a .terrform subdirectory  
You only need to run this once:
```
terraform init
```

note: the terraform init will validate your files, so any issues will need to be fixed before it is successful!

## Deploy the demo infra to GCP!
You can test a deployment using:
```
terraform plan
```
to show you what the deployment will look like  

note: some items will not be fully validated until the actual deployment is made  

When all looking good, perform the terraform apply, you will also get an output of what will be applied and asked to confirm as it may be a change to existing deployed infra.
```
terraform apply
```

You can review the resources information defined in output.tf using:
```
terraform output
```

## Accessing the host
You can ssh to your instances using ssh certificate authentication with your my_ssh_user value  
On a Mac you will need to load your private key into an ssh agent:  
ex:
```
eval `ssh-agent -s`
ssh-add ~/.ssh/myusername
ssh-add -l
```

Then access:
```
ssh myusername@xxx.xxx.xxx.xxx
```


## Cleaning up the stack!
The idea is to provision immutable demo infrastructure, spin it up when needed and tear it down afterwards.  
There is a cloud resource reaper in the se demo hosts project that will reap the instances *on* the *expires-on* resource label tag, 
however this only reaps the host instances so to clean up the whole stack use terraform destroy:
```
terraform destroy
```

