# Prérequis

* docker
* docker-compose

# Commandes

```bash
docker-compose up 
docker-compose up --build # s'il y a eu des changements dans le Dockerfile
docker-compose up --build --force-recreate web # pour recréer le docker web from scratch
```

# Préchargement des donnéees

```bash
wget https://data.regardscitoyens.org/nosdeputes.fr/nosdeputes.fr_donnees.sql.gz -O data/sql/donnees.sql.gz
gunzip data/sql/donnees.sql.gz
docker-compose exec db mysql -unosdeputes -ppassword nosdeputes -e 'source /data/sql/donnees.sql'
```

# Accès

* nosdeputes.fr : http://localhost:8080
* phpmyadmin : http://localhost:8081/