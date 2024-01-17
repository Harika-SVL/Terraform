#### Problem Statement

* _**`Our ficticious Organization`**_ :
    * _**name**_ : Asquare info systems
    * _**Product**_ : iEcommerce
    * _**Purpose**_ : Any Organization can buy this project and host ecommerce applications
* This product is designed to work on any virtualized platform such as :
    * VMWare
    * OpenStack
    * AWS
    * Azure
    * GCP
* Now `Asquare info systems` needs to have an apporach to deploy the iEcommerce application into customers _**`Cloud/Virtual Environments`**_

#### Architecture of iECommerce : 

![Alt text](shots/1.PNG)

* _**`Infra for iECommerce`**_
    * Two networks with connectivity between them ( same building, different buildings, cities, countries )
    * In Each network :
        * _**Two Databases**_ :
            * MySql
            * RAM : 8 GB
            * Cpus : 2
            * Disk : 10 TB
        * _**one File Store**_ :
            * Size : 10 TB
        * _**3 Servers**_ :
            * OS : Ubuntu 22.04
            * RAM : 16 GB
            * Cpus : 2
            * Disk : 50 GB
* _**`Solution`**_ :
    * _**InfraProvisioning**_ : This represents using Infrastructure as a Code and deploy to target environment

### Understanding InfraProvisioning

* Analogy

![Alt text](shots/2.PNG)
![Alt text](shots/3.PNG)

* We use InfraProvisioing tools where we express our desired state about `Infrastructure as code`
* _**Terraform**_ : Can create infra in almost all the virtual environments
* _**ARM Templates**_ : Can create infra in Azure
* _**CloudFormation**_ : Can create infra in AWS
* Infraprovisiong tools use `IaC` which are generally idempotent
* _**Idempotance**_ is the property which states execution one time or multiple times leads to the same result
* `Reusability` is extremely simple and terraform can also handle multiple environments ( Developer, QA, UAT/Staging/Production )

### Terraform

* Terraform is an opensource tool developed by HashiCorp which can `create infra in almost any virtual platform`
* Terraform uses a language which is called as `Hashicorp Configuration Language (HCL)` to express desired State

#### Terms

* _**Resource**_ : This is the infrastructure which you want to create
* _**Provider**_ : This refers to where you want to create infrastructure
* The `inputs` which we express in terraform are called as `arguments`
* The `output` given by terraform is referred as ` attribute`

#### Installing terraform

* For official docs

    [ Refer here : https://developer.hashicorp.com/terraform/install ]

* For the changes
```
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.58.0"
    }
  }
}

provider "aws" {
  # Configuration options
}

resource "aws_s3_bucket" "b" {
  bucket = "qt-tf-test-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.b.id
  acl    = "private"
}
```
* We have executed the commands in following order






#### Developer Environment

* Install Visual Studio Code
* Ensure Terraform Extension is installed



* For installing necessary softwares on your windows system

    [ Refer here : https://www.youtube.com/watch?v=9guzVbZPGuw&t=703s ]

#### Let's try to create a basic terraform template

* Create a new folder `hellotf`
* open visual studio code
* Create a new file `main.tf` with extension `.tf`
* Choose any provider 

    [ Refer Here : https://registry.terraform.io/browse/providers?tier=official ]

* For aws provider

    [ Refer here : https://registry.terraform.io/providers/hashicorp/aws/latest ]

* Let'

s do the same with azure Refer Here for the changes