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

* _**Resource**_ : The infrastructure `which you want to create`
* _**Provider**_ : To `where you want to create` the infrastructure
* _**Arguments**_ : The `inputs` which we express in terraform 
* _**Attribute**_ : The `output` given by terraform 

#### Installing terraform

* For official docs

    [ Refer here : https://developer.hashicorp.com/terraform/install ]

![Alt text](shots/4.PNG)

#### Developer Environment

* Install Visual Studio Code
* Ensure Terraform Extension is installed

![Alt text](shots/5.PNG)

* For installing necessary softwares on your windows system

    [ Refer here : https://www.youtube.com/watch?v=9guzVbZPGuw&t=703s ]

#### Creating basic terraform template

* Create a new folder `hellotf`
* open visual studio code
* Create a new file `main` with extension `.tf` - _**main.tf**_
* Choose any provider 

    [ Refer Here : https://registry.terraform.io/browse/providers?tier=official ]

* For aws provider

    [ Refer here : https://registry.terraform.io/providers/hashicorp/aws/latest ]

* Creating a template with `AWS`
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
  bucket = "tf-s3-test-bucket"

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
```
terraform apply     **
terraform init      #initialization
terraform apply     #applying the infra
yes                 #approval to create infra
terraform apply     #already existing
terraform destroy   #deleting the created infra
```








* Creating a template with `Azure`
```
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.47.0"
    }
  }
}

provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

resource "azurerm_storage_account" "example" {
  name                     = "qttftestaccount"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}
```
#### Basic workflow

![Alt text](shots/6.PNG)

#### N-Tier Application

* Consider the following architecture of a typical web application (ticket booking)

![Alt text](shots/7.PNG)

* To realize this application on `AWS`, the high level overview is :

![Alt text](shots/8.PNG)

* To realize this application on `Azure`, the high level overview is :

![Alt text](shots/9.PNG)

#### WOW (Ways of Working)

* Let's realize the architecture manually, make a note of :
  * resource
  * inputs
  * outputs
* Find resources in terraform to acheive the above manual steps

### Configuring a Provider in Terraform

#### Install Terraform on a linux machine

* Create a _**linux VM**_ and _**ssh**_ into it and execute the steps based on your distribution from here 

[ Refer here : https://developer.hashicorp.com/terraform/install#Linux ]



#### AWS Provider

* Terraform aws provider uses the `AWS API's` to get the infra created
* To Create infrastructure in your AWS Account, it needs `AWS programatic credentials (_**Secret access key and access key**_)`

![Alt text](shots/10.PNG)

* To configure these keys 

  [ Refer here : https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration ]

* Create `IAM user` _**Secret access key**_ and _**Access key**_ and for manual steps

  [ Refer here : https://sst.dev/chapters/create-an-iam-user.html ]

* Create `sampletf` folder and in it `main.tf`
```
mkdir sampletf
cd sampletf/
vi main.tf
```
* Let's write provider configuration in `main.tf`
```
provider "aws" {
  region     = "us-west-2"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}
```
* Run it using commands
```
terraform init
terraform validate
```
* This is not a great way as we are having sensitive information in the text format
* Best way is to _**install aws cli**_ on the machine with terraform and terraform will _**automatically pickup credentials**_ from there
* Installing aws cli 

  [ Refer here : https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html ]

```
cd ~
sudo apt install unzip -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version
aws configure
    ## give the access key, secret key and region
```
* Create a new folder `test2`
```
mkdir test2
cd test2/
vi main.tf
```
* Now your provider can be as simple as `main.tf` and execute it with the commands
```
provider "aws" {
    region = "us-west-2"
}
```
```
terraform init
terraform validate
terraform destroy
```
### Azure Provider

* For the provider documentation

  [ Refer here : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs ]

* To install azure cli and to authenticate azure cli

  [ Refer Here : https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt#option-1-install-with-one-command ]
  
```
az login
az group list  
```
### Providers and resources

* In terraform to create any resource we need to configure provdier
* Every provider has a specific structure
```
provider "<name>" {
    <ARGUMENT-1> = <VALUE-1>
    ..
    ..
    ..
    <ARGUMENT-N> = <VALUE-N>
}
```
* the type of resource will be in the form of `<provider>_<resource_type>`

### Manual Steps of VPC Creation

* Steps : Let's create a simple vpc
* Lets search for resource which lead to 
  [ Refer Here : https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc ]

* Now look at arguments 

  [ Refer Here : https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc#argument-reference ]

* Create the template as shown in this changeset 
```
provider "aws" {
}

resource "aws_vpc" "ntier" {
    cidr_block = "192.168.0.0/16"
    tags = {
        Name = "ntier"
    }
}
```
* Now validate and apply

### Activity: Create virtual network in Azure

* Manual Steps:
  * Create resource group

![Alt text](shots/11.PNG)
![Alt text](shots/12.PNG)
![Alt text](shots/13.PNG)

  * Create a _**VNET**_ with cidr range `192.168.0.0/16`

![Alt text](shots/14.PNG)
![Alt text](shots/15.PNG)

### Writing template for the above in terraform

* Terraform takes the folder as input and reads all the `.tf` files and while validating, applying or destroying tries to treat all the `.tf` files as one file
* For the changeset `main.tf`
```
resource "azurerm_resource_group" "ntierrg" {
  location = "eastus"
  name     = "ntier-rg"
}

resource "azurerm_virtual_network" "ntiervnet" {
  name                = "ntier-vnet"
  resource_group_name = "ntier-rg"
  address_space       = ["192.168.0.0/16"]
  location            = "eastus"
}
```
* Changeset `provider.tf`
```
provider "azurerm" {
  features {}
}
```
* To execute the above
```
terraform init
terrform validate
terraform fmt
terraform apply
yes          ## resource group creation
terraform apply
yes          ## vnet creation
terraform destroy
```
* To _**create dependencies**_ we can use `depends_on` meta argument ( to avoid the multiple apply statements to create different resources)

  [ Refer Here : https://developer.hashicorp.com/terraform/language/meta-arguments/depends_on ]

* The resource name in terraform is `<resource_type>.<name>`
* For the changeset `main.tf`
```
resource "azurerm_resource_group" "ntierrg" {
  location = "eastus"
  name     = "ntier-rg"
}

resource "azurerm_virtual_network" "ntiervnet" {
  name                = "ntier-vnet"
  resource_group_name = "ntier-rg"
  address_space       = ["192.168.0.0/16"]
  location            = "eastus"
  depends_on = [
    azurerm_resource_group.ntierrg
  ]
}
```
* Changeset `provider.tf`
```
provider "azurerm" {
  features {}
}
```
* To execute the above
```
terraform init
terrform validate
terraform fmt
terraform apply    ## terraform apply -auto-approve
yes
terraform destroy
```
![Alt text](shots/16.PNG)

* Note:
  * The commands which we started following `init, fmt, validate, apply`

### Focus Points

* To Work effectively with terrform templates we need to understand Hashicorp Configuration Language
* How to parametrize the template

### Hashicorp Configuration Language (HCL) for Terraform

* _**For Specification**_ 

  [ Refer Here : https://github.com/hashicorp/hcl/blob/main/hclsyntax/spec.md ]

* _**Provider**_ 

  [ Refer Here : https://developer.hashicorp.com/terraform/language/providers ]

* The terraform block helps in configuring the provider with _**version of the provider from registry**_ 

  [ Refer Here : https://developer.hashicorp.com/terraform/language/settings ]

* To specify which version of terraform you should be using, we use `required_version`. To specify constraints :

  [ Refer Here : https://developer.hashicorp.com/terraform/language/expressions/version-constraints ]

* For changes
```
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = ">= 4.47.0"
    }
  }
}

provider "aws" {
}
resource "aws_vpc" "ntier" {
    cidr_block = "192.168.0.0/16"
    tags = {
        Name = "ntier"
    }
}
```
### Parametrizing Terraform

### Input Variables

* For input variables official docs

  [ Refer here : https://developer.hashicorp.com/terraform/language/values/variables ]

* For _**inputs terraform supports**_ the following _**types**_
  * number
  * string
  * boolean
  * list()
  * set()
  * map()
  * object({ = , … })
  * tuple([, …])
* To _**pass variables**_ while executing commands we have two options :
  * -var
  * -var-file
* using `-var` 

  [ Refer Here : https://developer.hashicorp.com/terraform/language/values/variables#variables-on-the-command-line ]

`terraform apply -var "region=ap-south-2" -var "ntier-vpc-range=10.10.0.0/16"`
* For the changes to use variables `inputs.tf`
```
variable "region" {
  type        = string
  default     = "us-west-2"
  description = "Region to create resources"
}

variable "ntier-vpc-range" {
  type        = string
  default     = "192.168.0.0/16"
  description = "VPC Cidr Range"
}
```
* `main.tf`
```
resource "aws_vpc" "ntier" {
  cidr_block = var.ntier-vpc-range
  tags = {
    Name = "ntier"
  }
}
```
* `provider.tf`
```
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.47.0"
    }
  }
}

provider "aws" {
  region = var.region
}
```
* using variable definitions 

  [ Refer Here : https://developer.hashicorp.com/terraform/language/values/variables#variable-definitions-tfvars-files ]
  * example `terraform apply -var-file values.tfvars`
* For the changes in azure terraform template
`inputs.tf`
```
variable "location" {
  type        = string
  default     = "eastus"
  description = "location to create resource"
}

variable "vnet-range" {
  type        = list(string)
  default     = ["192.168.0.0/16"]
  description = "cidr range of vnet"
}
```
* `main.tf`
```
resource "azurerm_resource_group" "ntierrg" {
  location = var.location
  name     = "ntier-rg"
}

resource "azurerm_virtual_network" "ntiervnet" {
  name                = "ntier-vnet"
  resource_group_name = "ntier-rg"
  address_space       = var.vnet-range
  location            = var.location
  depends_on = [
    azurerm_resource_group.ntierrg
  ]
}
```
* `provider.tf`
```
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.48.0"
    }
  }
}

provider "azurerm" {
  features {}
}
```
* `tf.vars`
```
location   = "eastus"
vnet-range = ["10.100.0.0/16"]
```
### AWS – ntier

* Expectation

![Alt text](shots/17.PNG)

* Manual steps

=> select VPC => Subnets => Create subnet => select VPC ID => Give name, Availability zone, CIDR block

* To access outputs i.e. attributes of a resource syntax is `<resoure_type>.<name>.<atrribute-name>`
* For the changes done `inputs.tf`
```
variable "region" {
  type        = string
  default     = "us-west-2"
  description = "Region to create resources"
}
variable "ntier-vpc-range" {
  type        = string
  default     = "192.168.0.0/16"
  description = "VPC Cidr Range"
}

variable "ntier-app1-cidr" {
  type    = string
  default = "192.168.0.0/24"
}

variable "ntier-app2-cidr" {
  type    = string
  default = "192.168.1.0/24"
}

variable "ntier-db1-cidr" {
  type    = string
  default = "192.168.2.0/24"
}

variable "ntier-db2-cidr" {
  type    = string
  default = "192.168.3.0/24"
}
```
  * `main.tf`
```
resource "aws_vpc" "ntier" {
  cidr_block = var.ntier-vpc-range
  tags = {
    Name = "ntier"
  }

}

resource "aws_subnet" "app1" {
  cidr_block        = var.ntier-app1-cidr
  availability_zone = "${var.region}a"
  vpc_id            = aws_vpc.ntier.id #implicit dependency
  tags = {
    Name = "app1"
  }
  depends_on = [
    aws_vpc.ntier
  ]

}

resource "aws_subnet" "app2" {
  cidr_block        = var.ntier-app2-cidr
  availability_zone = "${var.region}b"
  vpc_id            = aws_vpc.ntier.id #implicit dependency
  tags = {
    Name = "app2"
  }
  depends_on = [
    aws_vpc.ntier
  ]
}

resource "aws_subnet" "db1" {
  cidr_block        = var.ntier-db1-cidr
  availability_zone = "${var.region}a"
  vpc_id            = aws_vpc.ntier.id #implicit dependency
  tags = {
    Name = "db1"
  }
  depends_on = [
    aws_vpc.ntier
  ]
}

resource "aws_subnet" "db2" {
  cidr_block        = var.ntier-db2-cidr
  availability_zone = "${var.region}b"
  vpc_id            = aws_vpc.ntier.id #implicit dependency
  tags = {
    Name = "db2"
  }
  depends_on = [
    aws_vpc.ntier
  ]
}
```
  * values.tfvars
```
region          = "us-west-2"
ntier-vpc-range = "10.100.0.0/16"
ntier-app1-cidr = "10.100.0.0/24"
ntier-app2-cidr = "10.100.1.0/24"
ntier-db1-cidr  = "10.100.2.0/24"
ntier-db2-cidr  = "10.100.3.0/24"
```
* To create multiple resources 

  [ Refer Here : https://developer.hashicorp.com/terraform/language/meta-arguments/count ]

* Let's apply the count for subnet creation, for changes
  * `inputs.tf`
```
variable "region" {
  type        = string
  default     = "us-west-2"
  description = "Region to create resources"
}
variable "ntier-vpc-range" {
  type        = string
  default     = "192.168.0.0/16"
  description = "VPC Cidr Range"
}

variable "ntier-subnet-cidrs" {
  type    = list(string)
  default = ["192.168.0.0/24", "192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
}

variable "ntier-subnet-azs" {
  type    = list(string)
  default = ["a", "b", "a", "b"]
}

variable "ntier-subnet-names" {
  type    = list(string)
  default = ["app1", "app2", "db1", "db2"]
}
```
  * `main.tf`
```
resource "aws_vpc" "ntier" {
  cidr_block = var.ntier-vpc-range
  tags = {
    Name = "ntier"
  }
}

resource "aws_subnet" "subnets" {
  count             = 4
  cidr_block        = var.ntier-subnet-cidrs[count.index]
  availability_zone = "${var.region}${var.ntier-subnet-azs[count.index]}"
  vpc_id            = aws_vpc.ntier.id #implicit dependency
  depends_on = [
    aws_vpc.ntier
  ]
  tags = {
    Name = var.ntier-subnet-names[count.index]
  }
  depends_on = [
    aws_vpc.ntier
  ]
}
```
  * `values.tfvars`
```
region             = "us-west-2"
ntier-vpc-range    = "10.100.0.0/16"
ntier-subnet-cidrs = ["10.100.0.0/24", "10.100.1.0/24", "10.100.2.0/24", "10.100.3.0/24"]
```
* Let's start using terraform functions to make further improvements using terraform functions 

  [ Refer Here : https://developer.hashicorp.com/terraform/language/functions ]

* Let's replace static count of 4 with length function 

  [ Refer Here : https://developer.hashicorp.com/terraform/language/functions/length ]

* For changeset `main.tf`
```
resource "aws_vpc" "ntier" {
  cidr_block = var.ntier-vpc-range
  tags = {
    Name = "ntier"
  }
}

resource "aws_subnet" "subnets" {
  count             = length(var.ntier-subnet-cidrs)
  cidr_block        = var.ntier-subnet-cidrs[count.index]
  availability_zone = "${var.region}${var.ntier-subnet-azs[count.index]}"
  vpc_id            = aws_vpc.ntier.id #implicit dependency
  depends_on = [
    aws_vpc.ntier
  ]
  tags = {
    Name = var.ntier-subnet-names[count.index]
  }
}
```
### AWS

* Let's generate subnet cidr range

* For the changes done to use cidr subnet function and object input type `inputs.tf`
```
variable "region" {
  type        = string
  default     = "us-west-2"
  description = "Region to create resources"
}

variable "ntier_vpc_info" {
  type = object({
    vpc_cidr     = string,
    subnet_azs   = list(string),
    subnet_names = list(string)
  })
  default = {
    subnet_azs   = ["a", "b", "a", "b"]
    subnet_names = ["app1", "app2", "db1", "db2"]
    vpc_cidr     = "192.168.0.0/16"
  }
}
```
  * `main.tf`
```
resource "aws_vpc" "ntier" {
  cidr_block = var.ntier_vpc_info.vpc_cidr
  tags = {
    Name = "ntier"
  }
}

resource "aws_subnet" "subnets" {
  count             = length(var.ntier_vpc_info.subnet_names)
  cidr_block        = cidrsubnet(var.ntier_vpc_info.vpc_cidr, 8, count.index)
  availability_zone = "${var.region}${var.ntier_vpc_info.subnet_azs[count.index]}"
  vpc_id            = aws_vpc.ntier.id #implicit dependency
  depends_on = [
    aws_vpc.ntier
  ]
  tags = {
     Name = var.ntier_vpc_info.subnet_names[count.index]
  }
}
```
  * `values.tfvars`
```
region = "us-west-2"
ntier_vpc_info = {
  subnet_azs   = ["a", "b", "a", "b","a", "b"]
  subnet_names = ["app1", "app2", "db1", "db2", "web1", "web2"]
  vpc_cidr     = "192.168.0.0/16"
}
```
* Terraform plan is generated whenever we apply

### Azure

* Let's add subnets, refer below for manual steps
* For the changes done `.terraform.tfstate.lock.info`
```
{"ID":"369b9c9c-99ce-574e-b2dc-248e60926f4e","Operation":"OperationTypeApply","Info":"","Who":"DESKTOP-TM7SH71\\Dell@DESKTOP-TM7SH71","Version":"1.3.9","Created":"2023-03-23T03:39:17.249786Z","Path":"terraform.tfstate"}
```
  * `inputs.tf`
```
variable "location" {
  type        = string
  default     = "eastus"
  description = "location to create resource"
}
variable "vnet-range" {
  type        = list(string)
  default     = ["192.168.0.0/16"]
  description = "cidr range of vnet"
}

variable "subnet_names" {
  type    = list(string)
  default = ["web", "app", "db"]
}
```
  * `main.tf`
```
resource "azurerm_resource_group" "ntierrg" {
  location = var.location
  name     = "ntier-rg"
}
resource "azurerm_virtual_network" "ntiervnet" {
  name                = "ntier-vnet"
  resource_group_name = "ntier-rg"
  address_space       = var.vnet-range
  location            = var.location
  depends_on = [
    azurerm_resource_group.ntierrg
  ]
}

resource "azurerm_subnet" "subnets" {
  count                = length(var.subnet_names)
  name                 = var.subnet_names[count.index]
  resource_group_name  = azurerm_resource_group.ntierrg.name
  virtual_network_name = azurerm_virtual_network.ntiervnet.name
  address_prefixes     = [cidrsubnet(var.vnet-range[0], 8, count.index)]
  depends_on = [
    azurerm_virtual_network.ntiervnet
  ]
}
```
### Ntier on Azure

* We need to create the following network

![Alt text](shots/18.PNG)

* replaced hardcode names for resource group and vnet with variable 
* For the changes `dev.tfvars`
```
location     = "eastus"
vnet_range   = ["10.0.0.0/16"]
subnet_names = ["app", "db"]
```
  * `inputs.tf`
```
variable "location" {
  type        = string
  default     = "eastus"
  description = "location to create resource"
}

variable "vnet_range" {
  type        = list(string)
  default     = ["192.168.0.0/16"]
  description = "cidr range of vnet"
}
variable "subnet_names" {
  type    = list(string)
  default = ["web", "app", "db"]
}

variable "names" {
  type = object({
    resource_group = string
    vnet           = string
  })
  default = {
    resource_group = "ntier-rg"
    vnet           = "ntier-vnet"
  }
}
```
  * `main.tf`
```
resource "azurerm_resource_group" "ntierrg" {
  location = var.location
    name     = var.names.resource_group
  tags = {
    Env       = "Dev"
    CreatedBy = "Terraform"
  }
}


resource "azurerm_virtual_network" "ntiervnet" {
    name                = var.names.vnet
  resource_group_name = azurerm_resource_group.ntierrg.name
  address_space       = var.vnet_range
  location            = var.location
  depends_on = [
    azurerm_resource_group.ntierrg
  ]
    tags = {
    Env       = "Dev"
    CreatedBy = "Terraform"
  }
}

resource "azurerm_subnet" "subnets" {
  count                = length(var.subnet_names)
  name                 = var.subnet_names[count.index]
  resource_group_name  = azurerm_resource_group.ntierrg.name
  virtual_network_name = azurerm_virtual_network.ntiervnet.name
    address_prefixes     = [cidrsubnet(var.vnet_range[0], 8, count.index)]
  depends_on = [
    azurerm_virtual_network.ntiervnet
  ]
}
```


### Let's try to Create Azure SQL Database

* Manual steps: 

  [ Refer Here : https://learn.microsoft.com/en-us/azure/azure-sql/database/single-database-create-quickstart?view=azuresql&tabs=azure-portal ]

* We need to Create SQL Server and then database
* For the changes done to create sql server
  * `database.tf`
```
resource "azurerm_mssql_server" "sql_server" {
  name                         = var.names.sql_server
  resource_group_name          = azurerm_resource_group.ntierrg.name
  location                     = azurerm_resource_group.ntierrg.location
  version                      = "12.0"
  administrator_login          = "devops"
  administrator_login_password = "ThisPasswordisnotgreat@1"
  tags = {
    Env       = "Dev"
    CreatedBy = "Terraform"
  }
}
```
  * `inputs.tf`
```
variable "location" {
  type        = string
  default     = "eastus"
  description = "location to create resource"
}
variable "vnet_range" {
  type        = list(string)
  default     = ["192.168.0.0/16"]
  description = "cidr range of vnet"
}
variable "subnet_names" {
  type    = list(string)
  default = ["web", "app", "db"]
}
variable "names" {
  type = object({
    resource_group = string
    vnet           = string
    sql_server     = string
  })
  default = {
    resource_group = "ntier-rg"
    vnet           = "ntier-vnet"
    sql_server     = "qtntierdb-dev"
  }
}
```
* Execution and Database creation are pending
