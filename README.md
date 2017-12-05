# Alpine-MARIADB (x86_64)

This is a Docker Container that uses alpine 3.6, adds s6 overlay(process manager), installs latest mariadb, mariadb-client.

MariaDB is a drop-in replacement for MySQL server. For more information please see [MariaDB](https://mariadb.org)

### Prerequisites

Any OS supporting Docker, I prefer Linux.

[Docker](https://www.docker.com/get-docker)


### Installing

Assuming you have Docker configured correctly, simply pull my image.

Step 1)

```
$ docker pull rjarow/alpine-mariadb

```
### Deploying

There are a few ways to deploy this, I would suggest using the -v volume mount to point to your application that needs to be hosted. The DB's are stored in /var/lib/mysql

The mysql user in the container UID/GIDD can be changed by passing environment variables, PUID and PGID. If not set, these default to UID 1050.

There are also VERY useful environment variables that can be used to setup a new db, user, and password on first launch.

```
MYSQL_ROOT_PASSWORD - Set this to set the mysql root password
MYSQL_DATABASE - Set this to the database you'd like to be created
MYSQL_USER - Set this to the username you'd like to use to access the database
MYSQL_PASSWORD - Set this to set the username's password to access the database.
```

Knowing these options here is an example of running as your current user.
Example:

```
docker create --name mariadb -v $(pwd):/var/lib/mysql \
-e PUID=$(id -u) \
-e PGID=$(id -u) \
-e MYSQL_ROOT_PASSWORD=rootpass \
-e MYSQL_DATABASE=mydbname \
-e MYSQL_USER=myuser \
-e MYSQL_PASSWORD=mypassword \
rjarow/alpine-mariadb
```
```
docker container start mariadb
```

This image exposes port 3306 to connect to mariadb server.

If you want to bind this to the hosts port 3306 the example would change slightly.

```
docker create --name mariadb -v $(pwd):/var/lib/mysql \
-e PUID=$(id -u) \
-e PGID=$(id -u) \
-e MYSQL_ROOT_PASSWORD=rootpass \
-e MYSQL_DATABASE=mydbname \
-e MYSQL_USER=myuser \
-e MYSQL_PASSWORD=mypassword \
-p 3306:3306 \
rjarow/alpine-mariadb
```

There are many ways you can deploy this, including Docker Compose, so have fun with it. :)


## Built With

* [Docker](https://docker.com) - Obviously?
* [Alpine](alpinelinux.org) - The tiny linux!
* [s6-overlay](https://github.com/just-containers/s6-overlay) - Making Docker play nice with processes.
* [MariaDB](https://mariadb.org) - Our favorite MySQL server.

Base image is built from scratch using alpine's source, and is maintained by me.

[Base Image](https://github.com/rjarow/alpine64-s6)


## Authors

*Initial work* - [rjarow](https://github.com/rjarow)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

## Acknowledgments

* Everyone making beautiful & efficient Docker Images
* Hi Mom!
