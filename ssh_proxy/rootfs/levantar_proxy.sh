#!/bin/ash -x

# generate host keys if not present
#ssh-keygen -A

#momentazo
#por defecto restrictivo
iptables -P OUTPUT DROP
#se permiten conexiones a la red docker
iptables -A OUTPUT -d 192.168.0.0/24 -p tcp -j ACCEPT
#se permiten respuestas (fundamentalmente las respuestas que da el proxy dinamico a internet)
iptables -A OUTPUT -m state --state=ESTABLISHED,RELATED -j ACCEPT
#se permiten conexiones a local (necesario para todos los ssh a local, para establecer tuneles)
iptables -A OUTPUT -d 127.0.0.1 -j ACCEPT
#se permite udp, para que funcione la resolucion de nombres (de todos modos el tunel solo reenvia tcp)
iptables -A OUTPUT -p udp -j ACCEPT
#permitir el acceso a cada servicio de la ip externa (cambiarla en "prod")
#esto solo es necesario si al definir la conexion, tras pasar el proxy, se quiere usar la ip del anfitrion. Si se pusiera la del router por defecto (192.168.0.254), esto no seria necesario.
iptables -A OUTPUT -p tcp -d 192.168.18.99 --dport 3306 -j ACCEPT
iptables -A OUTPUT -p tcp -d 192.168.18.99 --dport 5432 -j ACCEPT

#levantamos el proxy ssh (he tenido que poner el -p porque a veces ya existe y a veces no)
mkdir -p ~/.ssh
ssh-keyscan -H localhost > ~/.ssh/known_hosts

exec ssh -i /home/ricardo/.ssh/id_rsa -N -D 0.0.0.0:443 ricardo@localhost &

#traer a local el postgres de otra red de docker pero con el puerto expuesto
#esto funciono y luego no, y ahora no me hace falta (porque me conecto a la ip de la máquina)
#exec ssh -L 0.0.0.0:5432:192.168.0.254:5432 ricardo@localhost -i /home/ricardo/.ssh/id_rsa &

#traer a local el mysql de otra red de docker pero con el puerto expuesto
#exec ssh -L 0.0.0.0:3306:192.168.0.254:3306 ricardo@localhost -i /home/ricardo/.ssh/id_rsa &
