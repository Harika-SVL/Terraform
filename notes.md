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