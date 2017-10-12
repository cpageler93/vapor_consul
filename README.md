# vapor_consul
Docker Container for Vapor + Consul


# push image

from https://docs.docker.com/docker-cloud/builds/push-images/

export DOCKER_ID_USER="cpageler93"
docker login
docker build -t vapor_consul .
docker tag vapor_consul $DOCKER_ID_USER/vapor_consul
docker push $DOCKER_ID_USER/vapor_consul