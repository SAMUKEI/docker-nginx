# docker-nginx
A Dockerfile installing NGINX. Built on Alpine Linux.

* Nginx 1.13.8 (compiled from source)

## Usage

### Server
* Pull docker image and run:
```
docker pull samukei/docker-nginx
docker run -p 8080:80 -d samukei/docker-nginx
```

## Resources
* https://alpinelinux.org/
* http://nginx.org
