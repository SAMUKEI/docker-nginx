FROM alpine:3.4

ENV NGINX_VERSION 1.13.8
RUN mkdir -p /opt/data && mkdir /www \
  && apk update \
  && apk add --no-cache \
    git gcc binutils-libs binutils build-base libgcc make pkgconf pkgconfig \
    openssl openssl-dev ca-certificates pcre \
    musl-dev libc-dev pcre-dev zlib-dev gettext \
    logrotate tzdata \
  # Get nginx source.
  && cd /tmp && wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz \
  && tar zxf nginx-${NGINX_VERSION}.tar.gz \
  && rm nginx-${NGINX_VERSION}.tar.gz \
  # Compile nginx
  && cd /tmp/nginx-${NGINX_VERSION} \
  && ./configure \
    --prefix=/opt/nginx \
    --add-module=/tmp/nginx-http-auth-digest \
    --conf-path=/opt/nginx/nginx.conf \
    --error-log-path=/opt/nginx/logs/error.log \
    --http-log-path=/opt/nginx/logs/access.log \
    --with-http_sub_module \
    --with-http_auth_request_module \
    --with-debug \
  && cd /tmp/nginx-${NGINX_VERSION} && make && make install \
  && cp /tmp/nginx-http-auth-digest/htdigest.py /usr/local/bin/ \
  # Cleanup.
  && rm -rf /var/cache/* /tmp/* \
  # Create cache dir
  && mkdir -p /var/cache/nginx/cache /var/cache/nginx/tmp

ADD nginx.conf /opt/nginx/nginx.conf

EXPOSE 1935
EXPOSE 80

CMD ["/opt/nginx/sbin/nginx"]
