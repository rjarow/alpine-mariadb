### From alpine latest + s6 latest
FROM rjarow/alpine64-s6
LABEL maintainer "Rich J github.com/rjarow" architecture="AMD64/x86_64"

RUN apk update && \
    apk add bash less vim nginx ca-certificates git tzdata zip \
    mariadb mariadb-client \
    && rm -rf /var/cache/apk/*

RUN sed -Ei 's/^(bind-address|log)/#&/' /etc/mysql/my.cnf \
    && echo -e 'skip-host-cache\nskip-name-resolve' | awk '{ print } $1 == "[mysqld]" && c == 0 { c = 1; system("cat") }' /etc/mysql/my.cnf > /tmp/my.cnf \
    && mv /tmp/my.cnf /etc/mysql/my.cnf


COPY files/ /

ENV TERM="xterm"

EXPOSE 3306

VOLUME ["/var"]
