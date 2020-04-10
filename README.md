# docker_proxy_ssh

Cosas importantes para la reutilización de esto:
-en el docker-compose, el puerto. Está 443 a pelo
-en el red.sh, la ip del anfitrión, y el puerto
-en el levantar_proxy.ssh, el puerto

cosas para el futuro: entender bien lo del cmd y el entrypoint, para no tener que levantar manualmente el red.sh después del docker-compose. Ahora mismo, habría que:
-tocar a mano la ip del anfitrión y el puerto (en mi código 192.168.18.99 y 443), repartidos a lo largo de varios ficheros
-levantar con docker-compose up -d
-ejecutar el red.sh. A veces ahí tengo ue salir con control c, pero funciona.

Obviamente, lo ideal sería hacer sólo docker-compose up, además de definir todo en variables para no tener que andar toando ficheros
