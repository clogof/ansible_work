FROM ubuntu:latest
RUN apt update && apt install openssh-server sudo -y && apt -y install vim iproute2

RUN adduser admin
RUN echo 'admin:admin' | chpasswd

ARG ssh_pub_key
RUN mkdir -p /home/admin/.ssh
RUN echo "$ssh_pub_key" > /home/admin/.ssh/authorized_keys

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN service ssh start
EXPOSE 22
CMD ["/usr/sbin/sshd","-D"]
