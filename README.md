## Description

The stack contains of three services rails-app (muscat), db (mariadb) and solr. Both the solr- as the mysql container are writing to a persistent volume. A proxy (HAproxy) can be used as loadbalancer, see the configuration file.

## Preparation

### Requirements
docker >= 17.09 with experimental: true
docker-compose 1.16.1

### Data
The muscat-mysql-dump (init.sql & eg import_db.sql) should be placed in the muscat_data volume for the restore
```bash
docker run -v muscat_data:/data --name helper busybox true
docker cp init.sql helper:/data
docker cp data/import_db.sql helper:/data
docker rm helper
```
Then the restore can be done with 
```bash
mysql -u root -p < data/init.sql
```
## Workflow

This contains the files for building the muscat fullstack for docker swarm.

- Builing the application image:
```bash
docker build -t muscat_app:3.6.12 application/.
```

- Pushing it
```bash
docker push rismit/muscat_app:3.6.12
```

- Bundle the service 
```bash
docker-compose bundle
```

- Deploying the stack:
```bash
docker stack deploy --compose-file docker-compose.yml muscat 
```

Enjoy!

Keep in mind that all three services (db, solr, app) are micro services!

Stopping the stack:
```bash
docker stack rm muscat
```

¯_(ツ)_/¯
