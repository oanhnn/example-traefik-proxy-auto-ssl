# oanhnn/example-traefik-proxy-auto-ssl

An example for setting auto proxy and auto setup SSL with Traefik 2

## Refs

- https://docs.traefik.io/

## Requirements

- Docker Engine 17.12.0+
- Docker Compose 1.18.0+

## Usage

- Clone this project and set environment variables by `.env` file (see `.env.example` file).

- Create docker network for reverse proxy
  ```bash
  $ docker network create --driver=overlay reverse-proxy
  ```

- Update docker node label if you run with Docker Swarm mode
  ```bash
  docker node update --label-add node-has-traefik-service=true $(docker info -f '{{.Swarm.NodeID}}') > /dev/null
  ```

- Launch the `traefik-proxy` stack   
  With `docker-compose`
  ```bash
  $ docker-compose -f docker-compose/traefik.yml up -d
  ```
  With Docker Swarm mode
  ```bash
  $ set -a; source .env; set +a; docker stack deploy -c docker-swarm/traefik.yml
  ```
  > **NOTE** Docker dosen't load `.env` file. So that you load it by add `set -a; source .env; set +a;` before docker command

- Create example service in `reverse-proxy` docker network like `whoami` service   
  With `docker-compose`
  ```bash
  $ docker-compose -f docker-compose/whoami.yml up -d
  ```
  With Docker Swarm mode
  ```bash
  set -a; source .env; set +a; docker stack deploy -c docker-swarm/whoami.yml
  ```

- Now your service was lauch and proxy with SSL.
  ```bash
  $ curl -H "Host: app.example.com" https://127.0.0.1/
  ```

- Traefik dashboard was lauch in URL https://traefik.example.com/dashboard and secured with basic authentication and whilelist IP

> **NOTE** You can use `setup.sh` script in `docker-compose` and `docker-swarm` for easier

## Contributing

All code contributions must go through a pull request and approved by a core developer before being merged. 
This is to ensure proper review of all the code.

Fork the project, create a feature branch, and send a pull request.

If you would like to help take a look at the [list of issues](https://github.com/oanhnn/example-traefik-proxy-auto-ssl/issues).

## License

This project is released under the MIT License.   
Copyright © 2021 [Oanh Nguyen](https://github.com/oanhnn)   
Please see [License File](https://github.com/oanhnn/example-traefik-proxy-auto-ssl/blob/master/LICENSE) for more information.
