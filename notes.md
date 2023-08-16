### Story of LT

* Basic architecture

    ![Alt text](shots/1.PNG)

* LT has 3 customers who are ready to buy
    * TCS wants to run application on AWS
    * Infosys on Azure
    * JP Morgan on vmware
* How to automate these different deployments
    * Creating manually
    * For automation:
        * AWS has Cloud formation
        * Azure has ARM Templates
* Terraform can automate infra creation in almost all the virtual environments and Terraform is an open source software and provides enterprise.
* Terraform also allows us to deal with multiple environments

### Architecture of Terraform

* Terraform is developed in Go language and installation of terraform is one executable
* Providers are not part of terraform installations as we try to create infra, as part of initializations providers are downloaded
* Providers have resources and datasources as part of it

    ![Alt text](shots/2.PNG)

### Concepts of Terraform

* Provider: This determines the target area to create infra structure
    * For the list of providers

    [Refer here : https://registry.terraform.io/browse/providers]
* Terraform providers are of three categories
    * official
    * partner
    * community
* For providers documenation by hashicorp

    [Refer here : https://developer.hashicorp.com/terraform/language/providers]

[ Note: For you reference we have used the following template ]
```
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "2.33.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

provider "azurerm" {
    features {

    }
}

provider "aws" {
    region = "us-west-2"
}

resource "aws_instance" "fromtf" {
    ami = "ami-03f65b8614a860c29"
    tags = {
      Name ="from terraform"
    }
    key_name = "my_id_rsa"
    vpc_security_group_ids = ["sg-05adaf452b268c335"]
    instance_type = "t2.micro"

}


resource "azurerm_resource_group" "test" {
    name = "test"
    location = "eastus"

}
```
* Arguments and Attributes:
    * Argument refers to inputs in terraform
    * Attributes refers to outputs in terraform

### Infrastructure as a Code (IaC)

* This allows us to declare the infrastructure i.e. we would represent our needs in some format and the tool does the rest of creation/deletion/updating the resources.
* We deal with declarative language and desired state.

### Infra Provisioning

* This is about a tool which lets you express your infrastructure as a code and manages multiple environments and reusability

### Terraform

* This is infra provisioning tool and supports infrastructure as code, terraform uses Hashicorp configuration language HCL

### Ways of Working with Terraform (First version)

* Create the infrastructure manually atleast once as this helps
    * in figuring out inputs to be passed.
    * order of creation
    * every resource to be part of architecture
* Figure out the right provider and resources

### Syntaxes in Terraform

* Provider: For official docs

    [Refer here : https://developer.hashicorp.com/terraform/language/providers/configuration]
    * Syntax
    ```
    provider '<name-of-provider>' {
    arg-name-1 = arg-value-1
    ..
    arg-name-n = arg-value-n
    }
    ```
    * Example
    ```
    provider "aws" {
    region = "us-west-2"
    }
    ```
    * Generally we need to configure credentials for providers as well.
* resource: This represents the infrastructural element to be created 

    [Refer here : https://developer.hashicorp.com/terraform/language/resources/syntax]
    * Syntax
    ```
    resource "<resource_type>" "name" {
    arg-name-1 = arg-value-1
    ..
    arg-name-n = arg-value-n
    }
    ```
* Example
    ```
    “`
    resource "aws_instance" "fromtf" {
    ami = "ami-03f65b8614a860c29"
    tags = {
    Name ="from terraform"
    }
    key_name = "my_id_rsa"
    vpc_security_group_ids = ["sg-05adaf452b268c335"]
    instance_type = "t2.micro"</li>
    </ul>
    }
    “`
    ```
* Installing terraform 

    [Refer here : https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli]
* Commands
```
choco install vscode terraform -y
```
[ NOTE : 

* Windows: For installing necessary softwares

    [Refer here : https://www.youtube.com/watch?v=9guzVbZPGuw&list=PLuVH8Jaq3mLud3sVDvJ-gJ__0zd15wGDd&index=17]

    * git
    * windows terminal for windows 10 
    
    [Refer here : https://www.youtube.com/watch?v=qLVn2EvPsYc&list=PLuVH8Jaq3mLud3sVDvJ-gJ__0zd15wGDd&index=12]
* Mac:

    * Homebrew 
    
    [Refer here : https://brew.sh/]
    * git brew install git
    * visual studio code brew install --cask visual-studio-code
    * terraform brew install terraform
    * azure cli brew install azure-cli
]

### Activity-2: Create a s3 bucket

* Navigate to s3



* Resource:
    * s3 bucket
* Inputs:
    * region
    * bucket name

### Infra Provisioning using Terraform

* Create an empty folder
* To Provider doc's
    
    [Refer here : https://registry.terraform.io/providers/hashicorp/aws/latest/docs]
* For basic user creation steps

    [Refer here : https://directdevops.blog/2023/07/27/aws-classroomnotes-27-jul-2023/] 
    
    [Refer here : https://sst.dev/chapters/create-an-iam-user.html]
* Let's find the resource



* For s3 resource

    [Refer here : https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket]
* Now look at argument reference of resource

    [Refer here : https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#argument-reference]
* Handling credenitals in AWS
    * install AWS CLI
    * `aws configure`
* For sample activity

    [Refer here : https://github.com/asquarezone/TerraformZone/commit/a3c6f608f6e22b0c461f958b440856946f825052]

### Activity 3: Create a storge account in Azure

* For the official docs on how to create storage account

    [Refer here : https://learn.microsoft.com/en-us/azure/storage/common/storage-account-create?tabs=azure-portal]
* Resources:
    * Resource Group
        * Inputs:
            * name
            * location
    * Storage account
        * Inputs:
            * resource group name
            * location
            * name of storage account
* For Terraform Provider

    [Refer here : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs]
* To install AZURE CLI `az login`

    [Refer here : https://learn.microsoft.com/en-us/cli/azure/install-azure-cli]
* For resource group doc's

    [Refer here : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group]
 * For resource group doc's

    [Refer here : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account]




* For the changes

    [Refer here : https://github.com/asquarezone/TerraformZone/commit/3c82fe735bee3e9d83579ba377d3f447f0605329]

### Terraform contd...

* Order of Creation: Order of creation can be acheived in two ways
    * explicit dependency using `depends_on`
    
    [Refer here : https://developer.hashicorp.com/terraform/language/meta-arguments/depends_on]

    * For the usage

     [Refer here : https://github.com/asquarezone/TerraformZone/commit/6062bd0454bf293cb68d65e8d624983c419728fa]
    * Implicit dependency: Terraform figures out by looking at your configuration/template
        * When the output (attribute) of one resource is used as input (argument) to other
        * For the changes

    [Refer here : https://github.com/asquarezone/TerraformZone/commit/d08e36cd8bd1c68069d85e364f4ca623ce658c55]
* To use one resource in other resource argument `<resource_type>.<name>`
```
depends_on = [ azurerm_resource_group.myresg ]
```
### Best Practice to write terraform template (Based on what we have covered so far)

* Terraform reads all the `.tf` files in the folder and then combines as one file and executes the terraform => While writing terraform templates there is no need write everything in one file
    * From now one lets have one tf for provdier and then one tf file for logical group of resources.
    * All the variables will be in one file `inputs.tf` and all the outputs will be in the file `outputs.tf`



* Use `terraform fmt` to align the terraform template into common canonical format, for the changes done

    [Refer here : https://github.com/asquarezone/TerraformZone/commit/5d20b10dfe611bb6a2588f74723e48b4b002a01a]




### Manual Steps for next activity

* Azure



* AWS



### ntier network in Azure

* Manual steps:
    * Create a resource group
    * Create a vnet Refer Here for screenshots
    * network: 10.10.0.0/16
        * subnets:
            * web: 10.10.0.0/24
            * app: 10.10.1.0/24
            * db: 10.10.2.0/24




### Terraform implementation:

* For basic strucuture and terraform constraints added

    [Refer here : https://github.com/asquarezone/TerraformZone/commit/54c319951a6b6f6f38dd325bc03b55f215c2f443]
* For resource definitions done

    [Refer here : https://github.com/asquarezone/TerraformZone/commit/fe82b917ad18960ba8a87f5a2311b4fb7464a18f]
* For the variables added

    [Refer here : https://github.com/asquarezone/TerraformZone/commit/8fcc9aa67188b73e4240a5149ab03531daff36ba]
* To pass input variables we have two options
* option 1: from cli directly using `-var terraform apply -var 'resource_group_name=ntier-dev' -var 'location=eastus'`
* option 2: create a file with variable values 

    [Refer here : https://developer.hashicorp.com/terraform/language/values/variables#variable-definitions-tfvars-files]
*  For the changes to accomodate ntier with tfvars

    [Refer here : https://github.com/asquarezone/TerraformZone/commit/067f83585974f81f0d41332542d94ba6f5ddcf40]

### Terraform concepts

* Terraform block: 

    [Refer here : https://developer.hashicorp.com/terraform/language/settings]
    * Terraform block can help in setting provider requirements 
    
    [Refer here : https://developer.hashicorp.com/terraform/language/settings#specifying-provider-requirements] 
    * As well as terraform requirements 
    
    [Refer here : https://developer.hashicorp.com/terraform/language/settings#specifying-a-required-terraform-version]
    * There are other areas as well, which we will be discussing in later parts fo course
* Version constraints: 

[Refer here : https://developer.hashicorp.com/terraform/language/expressions/version-constraints]
* Data types: 

[Refer here : https://developer.hashicorp.com/terraform/language/expressions/types]
* Terraform input variables 

[Refer here : https://developer.hashicorp.com/terraform/language/values/variables]

### ntier network in AWS

* Manual steps:
    * Create a vpc
        * network: 10.10.0.0/16 => 10.10.x.x ( 10.10.0.0 to 10.10.255.255)







* For the changes

    [Refer here : https://github.com/asquarezone/TerraformZone/commit/c0a890c9a1216a15885790be91e61791914dc9ce]



* After terraform apply we are observing three new files
    * .teraform.lock.hcl
    * terraform.tfstate
    * terraform.tfstate.backup
* Let's add one subnet
    * cidr: 10.10.0.0/24 => 10.10.0.x => 10.10.0.0 to 10.10.0.255
    * name: web 1





* For the changes

    [Refer here : https://github.com/asquarezone/TerraformZone/commit/a91ca3ce662cef4819eddd1f654f6f424a8376b4]



* Exercise: Try adding 5 more subnets
```
web2: 10.10.1.0/24
db1: 10.10.2.0/24
db2: 10.10.3.0/24
app1: 10.10.4.0/24
app2: 10.10.5.0/24
```
### Concepts

* For terraform locals

    [Refer here : https://developer.hashicorp.com/terraform/language/values/locals]
* Terraform works:
    * Terraform when applied tries to figure out a plan to make the desired state an actual state (`terraform plan`)
    * Terraform creates a file called as terraform.tfstate when it first creates some resource
    * Terraform stores the information about the created resources in a json format called as `tfstate`
    * Terraform refresh updates the tfstate according to actual state




### ntier-aws: adding 5 more subnets

* CIDR Ranges
```
web2: 10.10.1.0/24
db1: 10.10.2.0/24
db2: 10.10.3.0/24
app1: 10.10.4.0/24
app2: 10.10.5.0/24
```
* For the changes which include usage of count

[Refer here : https://github.com/asquarezone/TerraformZone/commit/dc0107cb9ba9d7a8814a27f5a76c378af3a85a0a]



* For the changes which include usage of length

[Refer here : https://github.com/asquarezone/TerraformZone/commit/43daa844b4cdc1b90b7243fb03be02bb3da6acb4]
* For the usage of format function

[Refer here : https://github.com/asquarezone/TerraformZone/commit/95eb892246ae7b51b4f0903cd82f54cf6dee92d5]

### ntier-azure: adding 3 subnets

* CIDR Ranges
```
web: 10.10.0.0/24
app: 10.10.1.0/24
db: 10.10.2.0/24
```
* Changes done to accomodate multi resource creation

[Refer here : https://github.com/asquarezone/TerraformZone/commit/3cb7feb103c2460307889f5004da84f619eb94b6]




### Concepts

* Count: 

    [Refer here : https://developer.hashicorp.com/terraform/language/meta-arguments/count]
    
    * This argument can be used in resource block to create multiple resources
* Console: 

    [Refer here : https://developer.hashicorp.com/terraform/cli/commands/console]
* Functions 

    [Refer here : https://developer.hashicorp.com/terraform/language/functions]
    * length function determines the length of collection 
    
    [Refer here : https://developer.hashicorp.com/terraform/language/functions/length]
    * format function 
    
    [Refer here : https://developer.hashicorp.com/terraform/language/functions/format]

