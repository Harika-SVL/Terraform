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
* Now `Asquare info systems` needs to have an apporach to deploy the iEcommerce application into customers `Cloud/Virtual Environments`

#### Architecture of iECommerce : 

![Alt text](shots/1.PNG)

* Infra for iECommerce
    * Two networks with connectivity b/w them (same building, different buildings, cities, countries)
    * In Each network
        * _**Two Databases**_
            * mysql
            * RAM: 8 GB
            * cpus: 2
            * Disk: 10 TB
        * _**one File Store**_
            * Size: 10 TB
        * _**3 Servers**_ :
            * OS: Ubuntu 22.04
            * RAM: 16 GB
            * Cpus: 2
            * Disk: 50 GB
* Solution:
    * _**InfraProvisioning**_ : This represents using Infrastructure as a Code and deploy to target environment

### Understanding InfraProvisioning

* Analogy

![Alt text](shots/2.PNG)
![Alt text](shots/3.PNG)

* We using InfraProvisioing tools where we express our desired state about infrastructure as code
* _**Terraform**_ : Can create infra in almost all the virtual environments
* _**ARM Templates**_ : Can create infra in Azure
* _**Cloudformation**_ : Can create infra in AWS
* Infraprovisiong tools use IaC which are generally idempotent
* Idempotance is the property which states execution one time or multiple times leads to the same result
* Reusability is extremely simple and terraform can also handle multiple environments ( Developer, QA, UAT/Staging/Production )
