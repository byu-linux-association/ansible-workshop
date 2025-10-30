# Ansible Workshop




## Setting Up Ubuntu Docker Container

```bash

docker build -t ansible_ubuntu .
docker run -dit p 3000:22 -p 3001:80 --name ansible_workshop ansible_ubuntu:latest

```

To connect to the container
```bash
ssh -p 3000 root@127.0.0.1
```
