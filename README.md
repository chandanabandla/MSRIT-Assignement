# MSRIT-Assignment code execution procedure

1. Create two EC2 Instances in AWS Cloud using

> Install terraform
> Create a folder and open the terminal
> Run the following commands
  
    [Terraform init .]
  * Added code in a file and saved the file with .tf extension and run the following command
    
        [terraform validate .]
    
        [terraform apply .]
    
> Creates 3 t2.micro instances
  Where,
  * one is the MSR-test-Instance-1.
  * Second is the MSR-test-Instance-2.
  * Third instance is used as a Ansible Control Machine to handle the deployments.

2. Once these two servers are provisioned, ensure the below following software packages are installed using configuration management tool in both the provisioned instances.

> Used ansible to do the installations.
> Configuring Ansible control server
  * Login to Ansible Control Server
  * Install Ansible
  * Ansible is installed in /etc/ansible
  * Install python
  * Enable password based authentication in AWS machine
    
        [Sudo -i]
    
        [Vi /etc/ssh/sshd_config]
    
    Here change "password based authentication" from "No" to "Yes"
      
        [service sshd restart]
      
        [service sshd status](status should be active)
  * Create user
    
        [adduser ansible]
    
    o Give execute permissions for installations
    
        [visudo]
    
    o Add [ansible ALL:(ALL:ALL) NOPASSWD:ALL]
> Configuring the other 2 Nodes as follows:
  * Login to MSR-test-Instance-1 and MSR-test-Instance-2
    
        [Ssh ansible@PrivateIPAdress]
  
  * Create user as mentioned above with the same user name as ansible.
  * Install python on both the nodes. 
> Enable key-based authentication between machines. So that we dont need to give password every time we login.
  * Login to ACS machine
  * Generate Key
    
        [ssh-keygen]
  * Copy public key into other nodes and also within the ACS machine after logging into as a ansible user
    
        [ssh-copy-id ansible@DNS]
> Working with inventory
  * Create a file and name it as hosts
    
        [vi hosts]
  * Add DNS address of the nodes in it. Give the group name as [Ubuntu]
For Example:

[Ubuntu]

localhost

Node1 DNS

Node2 DNS

> To check whether the machines are established connections
  
     [ansible -m ping all]
> Now execute the play-book which is written using
  
    [Ansible-Playbook -i hosts DeployingSoftware.yml]

3. Create a Docker Container in MSR-test-Instance-1 using Docker Compose file and ensure apache webserver is installed. Try to use configuration management tools to automate the entire installation of apache and deploy a sample html file from a GitHub repository.

> Docker and docker-compose is already installed using ansible on both the nodes.
> Create a folder "MSRTest Instance-1 Docker container" and write the docker, docker-compose and sample.html files inside the folder.    Run the following command from the project root folder.
  
    [Docker-compose up]

4. Create a Docker Container in MSR-test-Instance-2 using Docker Compose file and ensure CouchDB Database is installed. Try to use any configuration management tool to automate the entire installation processes. We should be able to access the Futon - web GUI of CouchDB, from the external system.

> Docker and docker-compose is already installed using ansible on both the nodes.

> Create a docker network
  
    [docker network create couchdb-test]

> Create a docker volume
  
    [docker volume create --name=couchdb-test]

> Create a folder "MSRTest Instance-1 Docker container" and write the docker-compose file inside the folder. Run the following command from the project root folder.
  
    [Docker-compose up]

> To access the web GUI of couchdb, open a browser and type the following
   
            http://13.126.233.159:5984/_utils/
