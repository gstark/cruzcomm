

# DOCKER!

![Docker?! Docker, docker, docker, docker. DOCKER!](https://cdn-images-1.medium.com/max/1600/1*42K-swiwgm3lZ2xRyNU5ow.gif)

## To initialize the docker stuff

`docker-compose build && docker-compose up`

This will likely error the first time since postgraphql will try to run before postgres is all setup. Just kill it and start it again. Later on I'll try to coodinate the docker compose dependencies, but that isn't trivial.
