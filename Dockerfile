FROM ubuntu:latest

RUN apt-get update && apt-get install -y openssh-server git sudo

# Configure SSH
RUN mkdir /var/run/sshd
RUN echo 'root:password' | chpasswd

#password for user login
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

EXPOSE 22
EXPOSE 80

# Start SSH server
RUN service ssh start

CMD ["/usr/sbin/sshd","-D"]