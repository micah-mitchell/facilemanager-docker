# Quick reference
**About**: Unofficial Dockerization of the facileManager.com Web Interface

**Maintained by**: [myah-mitchell](https://github.com/myah-mitchell) (*not* the WillyXJ or the facileManager Team)

**Where to get help**:  This projects GitHub Issues or facileManager Issues if not related to docker

**Docker Hub Link**: https://hub.docker.com/r/myahmitchell/facilemanager

**GitHub Link**: https://github.com/myah-mitchell/facileManager-docker


# Supported tags and respective `Dockerfile` links
* [`latest`](https://github.com/myah-mitchell/facileManager-docker/blob/main/Dockerfile), [`4.6.1`](https://github.com/myah-mitchell/facileManager-docker/blob/main/Dockerfile)

# What is facileManger?

As quoted from facileManger.com; "facileManager is a modular suite of web apps built with the system administrator in mind. Say good-bye to manual management of services running on multiple servers. [Learn more](http://www.facilemanager.com/learn/) about what this suite can do for you."

![facilemanager logo](https://user-images.githubusercontent.com/47770376/153337478-4883286f-9308-4fd1-9e5c-a43cb6deac8c.png)

# Related Projects?

facileManager is just the web interface to which you can enable multiple modules. Each of these modules can run as their own container.

**fmDNS** : https://hub.docker.com/r/myahmitchell/fmdns

# How to use this image

The basic pattern for starting a drupal instance is:

```
$ docker run -d --name facilemanager-p 8080:80 \
   --hostname=<FQDN> \
   -e MYSQL_HOST=<fm-mysql> \
   -e MYSQL_DATABASE=facilemanager \
   -e MYSQL_USER=facilemanager \
   -e MYSQL_PASSWORD=<password> \
   myahmitchell/facilemanager`
```
Then, access it via http://localhost:8080, http://host-ip:8080, or http://<fqdn>:8080 in a browser.

This will support using MySQL and should support other MySQL similar databases like MariaDB (untested).

## MySQL
For using a MySQL database you'll want to run a MySQL container and configure it using environment variables for MYSQL_DATABASE, MYSQL_USER, MYSQL_PASSWORD, and MYSQL_ROOT_PASSWORD

```bash
$ docker run -d --name fm-mysql --network some-network \
    -e MYSQL_DATABASE=facilemanager \
    -e MYSQL_USER=facilemanager \
    -e MYSQL_PASSWORD=<password> \
    -e MYSQL_ROOT_PASSWORD=<password> \
    mysql:5.7
```

## Volumes
By default, this image does not include any volumes. As all data is stored in MySQL, there is no data to keep from inside facilemanager

## ... via docker stack deploy or docker-compose
### docker-compose.yml
```yaml
  facilemanager:
    build:
    image: myahmitchell/facilemanager:latest
    hostname: ${fm_URL}
    networks:
      - frontend
      - backend
    volumes:
      - "/etc/timezone:/etc/timezone:ro"
      - "/etc/localtime:/etc/localtime:ro"
    ports:
      - 8080:80
    restart: unless-stopped
    security_opt:
      - no-new-privileges:true
    environment:
      MYSQL_HOST: "${COMPOSE_PROJECT_NAME}-db"
      MYSQL_DATABASE: "${MYSQL_DATABASE}"
      MYSQL_USER: "${MYSQL_USER}"
      MYSQL_PASSWORD: "${MYSQL_PASSWORD}"
    links:
      - mysql

  mysql:
    image: mysql:5.7
    hostname: mysql
    networks:
      - backend
    volumes:
      - "/etc/timezone:/etc/timezone:ro"
      - "/etc/localtime:/etc/localtime:ro"
      - mysql:/var/lib/mysql
    restart: unless-stopped
    security_opt:
      - no-new-privileges:true
    environment:
      MYSQL_ROOT_PASSWORD: "${MYSQL_ROOT_PASSWORD}"
      MYSQL_DATABASE: "${MYSQL_DATABASE}"
      MYSQL_USER: "${MYSQL_USER}"
      MYSQL_PASSWORD: "${MYSQL_PASSWORD}"
      
volumes:
    mysql:

networks:
    frontend:
    backend:
```
### .env
```
# MYSQL
MYSQL_ROOT_PASSWORD=password
MYSQL_DATABASE=facilemanager
MYSQL_USER=facilemanager
MYSQL_PASSWORD=password

#facileManager
fm_URL=dns.example.com
```

# License
Due to this being an unoffical dockerization of the facilemanager.com web interface, we will be using the same as their project: https://github.com/WillyXJ/facileManager/blob/master/LICENSE

As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.

# Honorable Mentions

The layout and style of this Read-Me was directly influanced and copied from https://hub.docker.com/_/drupal

The following GitHub users and their projects that helped get this image to the state it is at. (If either of you would like to be added as co-maintainers please message me)
* https://github.com/erindru/fmDNS-docker
* https://github.com/MeCJay12/facileManager-docker
