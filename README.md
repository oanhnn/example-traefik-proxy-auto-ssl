# oanhnn/example-traefik-proxy-auto-ssl

An example for setting auto proxy and auto setup SSL with Traefik 2.0

## Refs

- https://docs.traefik.io/user-guides/docker-compose/acme-dns/

## Requirements

- Docker Engine 17.12.0+
- Docker Compose 1.18.0+

## Usage

- Launch the `traefik-proxy` stack in detached mode with:
  
  ```bash
  $ docker-compose up -d
  ```

- Create example service in `reverse-proxy` docker network like example service
  
  ```bash
  $ cd example-svc
  $ docker-compose up -d
  ```

- Now your service was lauch and proxy with SSL.
  ```bash
  $ curl -H "Host: example.com" https://127.0.0.1/
  ```

- Traefik dashboard aws lauch in URL https://proxy.example.com/dashboard and secured with basic authentication and whilelist IP

## Contributing

All code contributions must go through a pull request and approved by a core developer before being merged. 
This is to ensure proper review of all the code.

Fork the project, create a feature branch, and send a pull request.

If you would like to help take a look at the [list of issues](https://github.com/oanhnn/example-traefik-proxy-auto-ssl/issues).

## License

This project is released under the MIT License.   
Copyright © 2019 [Oanh Nguyen](https://github.com/oanhnn)   
Please see [License File](https://github.com/oanhnn/example-traefik-proxy-auto-ssl/blob/master/LICENSE) for more information.
