# docker-kallithea
Kallithea in Docker

Runs the stable branch of [Kallithea SCM](https://kallithea-scm.org/)

It is based on the work I have done for running Rhodecode on Docker.

It can help you install and try Kallithea really fast


#How to use
---
```
docker run -d -p 5000:5000 codingtony/kallithea
```

Volumes
---


| important directories | description
|--- |---
|/opt/kallithea | contains initial config (database and production.ini), you probably want to change this or mount a volume with your database and configuration
|/var/repo | default directory for repo as specified in the initial config

Other info
---

By default this image of Kallithea will listen on port 5000

Default admin user  :  admin

Default password : secret

You can change it at your first login.

## How to create a data container for kallithea
```
docker run --name "kallitheadata" -v /opt/kallithea -v /var/repo tianon/true
```

If you need to upgrade or setup, you probably want to log to the image and update the configuration you will simply to this :

```
docker run -ti --rm  --volumes-from kallitheadata  -v /etc/localtime:/etc/localtime:ro -v /etc/sysconfig/clock:/etc/sysconfig/clock:ro codingtony/kallithea bash

# You can follow the setup instructions here : http://docs.kallithea-scm.org/en/latest/setup.html#setup
# use production.ini instead of my.ini

```

## How to create a Kallithea container using the data container
```
docker run -d -p 5000:5000 --name "kallithea" --volumes-from kallitheadata  -v /etc/localtime:/etc/localtime:ro -v /etc/sysconfig/clock:/etc/sysconfig/clock:ro codingtony/kallithea
```

## Start the container
```
docker start kallithea
```

## Stop the container
```
docker stop kallithea
```












