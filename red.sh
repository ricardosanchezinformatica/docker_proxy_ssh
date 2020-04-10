#!/bin/bash -x 


#levantamos servicios (ojo que no se pone el -it)
docker exec --privileged proxy /levantar_proxy.sh

#listamos contenedores
../listar_contenedores.sh
