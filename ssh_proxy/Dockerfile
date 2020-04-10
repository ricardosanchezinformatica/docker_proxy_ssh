FROM alpine

RUN apk add busybox-extras
RUN apk add nmap-ncat

#sshd copiado de https://github.com/sickp/docker-alpine-sshd/blob/master/versions/7.5-r2/Dockerfile
ENTRYPOINT ["/entrypoint.sh"]
EXPOSE 22
COPY rootfs /

RUN apk add --no-cache openssh \
  && sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
  && sed -i s/^AllowTcpForwarding.*/AllowTcpForwarding\ yes/ /etc/ssh/sshd_config

RUN \
  adduser -D -s /bin/ash ricardo && \
  passwd -u ricardo && \
  mkdir /home/ricardo/.ssh && \
  ssh-keygen -t rsa -N '' -f /home/ricardo/.ssh/id_rsa && \
  cp /home/ricardo/.ssh/id_rsa.pub /home/ricardo/.ssh/authorized_keys && \
  chown -R ricardo:ricardo /home/ricardo

RUN ssh-keygen -A

RUN apk add iptables

RUN echo "build terminado"
