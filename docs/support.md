# Support Info

* Shell access whilst the container is running: `docker exec -it 7dtdserver /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f 7dtdserver`
* container version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' 7dtdserver`
* image version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' vinanrra/7dtd-server`
