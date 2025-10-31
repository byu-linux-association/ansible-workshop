# Ansible Workshop

## Setting up the local files

### Installing Git
You will need Git to clone the repo. You could also download the source code from GitHub, but Git is an extremely useful tool. 
If you are a CS major then you will need to learn it at some point.

### For Linux
If you are on Linux, hopefully you know your package manager and how to install programs.

### For Windows
You can download it from [this link.](https://git-scm.com/downloads)

### For MacOS
You might already have it if you have ever installed XCode.
If not you can download it from [this link.](https://git-scm.com/downloads)

### Cloning the Repository
Make sure you can put it somewhere where you can find it.

Open a terminal/powershell and run the following command:
```bash
git clone https://github.com/byu-linux-association/ansible-workshop
```
Then enter into the repository by doing
```bash
cd ansible-workshop
```

### Setting Up Ubuntu Docker Container

#### Install Docker Desktop
Go to [this webpage](https://docs.docker.com/desktop/) and scroll to the bottom.
Pick your operating system and click on the correct link.

This should install Docker Desktop and Docker for you.
Once set up, continue with the guide.


#### Running the Container
In the terminal you used to clone the repository earlier, run these commands.

If the commands don't work, then close the terminal window and navigate back to the cloned repository and try it again.

```bash
docker build -t ansible_ubuntu .
docker run -dit p 3000:22 -p 3001:80 --name ansible_workshop ansible_ubuntu:latest
```

This command will build our container and then run it.

#### Connecting to the Container

To connect to the container. The password set is `password`
```bash
ssh -p 3000 root@127.0.0.1
```
Once you have verified that you can ssh into the docker container. The next step is to set up ssh keys.

### SSH keys
If you already have ssh keys set up you can skip the generating keys part.

#### Generating SSH Keys
Run the following command and just hit enter a few times until it displays the art.
```bash
ssh-keygen -t ed25519
```

#### Copying SSH Keys
Run one of the commands depending on your operating system.
###### Linux and MacOS
```bash
ssh-copy-id -p 3000 root@127.0.0.1
```
###### Windows
```bash
scp ~\.ssh\id_ed25519.pub root@127.0.0.1:/.ssh/authorized_keys
```

## Setting up Development Environment
We are going to be using VS Code for the completion of the tasks.

Install VS Code [by going here](https://code.visualstudio.com/download).

Once installed open the Command Palette by hitting `F1`, `Ctrl+Shift+P`, or `Command+Shift+P` if you are on MacOS.

Then type Remote-SSH: Connect to Host

Add a new host and type in the ssh command from above.
```bash
ssh -p 3000 root@127.0.0.1
```
Then it will ask you which config to modify. 
Select the config for your user (the one under your home folder).

Then hit connect in the bottom right corner.

VS Code will now be connected to the container.

## Installing Ansible

### Installation
Open a shell in VS Code by going to the topmenu and going `Terminal->New Terminal`.

Then type in the following commands to install Ansible.

```bash
apt update
apt install ansible
# apt install software-properties-common
# add-apt-repository --yes --update ppa:ansible/ansible
```

if the above commands don't work, try the follow commands, then the above commands again.
```bash
apt install software-properties-common
add-apt-repository --yes --update ppa:ansible/ansible
```

Ansible should now be installed.

### Configuration
We will need to make/edit the Ansible hosts file.

First we need to create the directory for the file.
```bash
mkdir -p /etc/ansible/
```

Then we need to create the file so we can edit it in VS Code.
```bash
touch /etc/ansible/hosts
```

Now open the file in VS Code with the path `/etc/ansible/hosts`

This file is where you can put all the machines you wish to configure with your ansible scripts. 
The real magic of Ansible is that you can deploy hundreds of machines at once.
At my intership at Lawrence Livermore National Lab, they use Ansible to setup every HPC cluster at the lab and to keep everything up to date.

For our simple example, we will use the following configuration file:
```
[machines]
Ubuntu ansible_host=127.0.0.1
```

Save the file and Ansible should now be nearly ready to go.

### Local SSH Keys
Ansible works over ssh and as such, we need to set up ssh keys for root in the container.

Simply run the following commands to get everything ready.

```bash
ssh-keygen -t ed25519
ssh-copy-id root@127.0.0.1
```

We are just generating the keys like we did last time as well as copying the key to ourselves.

## Running Ansible

We now need to clone the repository into the container.
You can do this with the following command.
```bash
git clone https://github.com/byu-linux-association/ansible-workshop
```

Now open the repository in VS Code and you can see the various files.

We will first set up the root user's `.bashrc`.

If everything went smoothly so far, we should be able to run the following command:
```bash
ansible-playbook setup_bashrc.yaml
```

After that runs, type the following command to see your changes.
```bash
. ~/.bashrc
```

## Tasks
### Task 1 Setting up ZSH
This task is simple. 

Based on the `setup_bashrc.yaml`, write an Ansible playbook that installs zsh and places the provided `.zshrc` file in root's home directory.

### Task 2 User Creation
Using `dummy-user.yaml` as a guide, create a your own user on the machine.
You will need to use lookup the ansible documentation to get an idea on what things you might need to set.

You will also need to use this command to hash your user's password
```bash
openssl passwd -6 --stdin
```

### Task 3 Edit `/etc/hosts` with a few fake hosts
This task requires you to edit a file.
Look up the documentation for editing a file and get a feel for what you need to do.

Your job is to add a few hosts to the end of the file.
I recommend taking a look at `/etc/hosts` to see the format.
We are also not replacing the file, just editing it.

### Task 4 Create Playbook that Calls other Playbooks
Now we want a convient way to run all of the playbooks together so we don't have to run `ansible-playbook` on every playbook.
That could take too long.
Instead, we want to make it so that we can run all of the playbooks with one command.

Your tasks is to figure this out and write the playbook that calls the example playbooks and the playbooks you wrote for the other tasks.

## Clean up
```bash
# Stop the container from running
docker stop ansible_workshop

# Optionally delete the container
docker rm ansible_workshop
```

## Summary
Ansible is a really powerfull tool whose full power couldn't be expressed in this activity.
If this interests you, then you should look into it more.
