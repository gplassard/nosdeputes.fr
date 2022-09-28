# Prérequis

* docker
* docker-compose

# Commandes principales

```bash
docker-compose up # démarrer l'ensemble de l'application
docker-compose up --build web # s'il y a eu des changements dans le Dockerfile
docker-compose up --build --force-recreate web # pour recréer le docker web from scratch
docker-compose exec web bash -c "tail -f /var/log/apache2/*" # suivre les logs apaches
```

# Setup de l'application
```
cp config/app.yml.example config/app.yml
cp config/databases.yml.example.docker config/databases.yml
docker-compose exec web bash -c "make all"
```

# Setup de la base de données

```bash
docker-compose exec mysql mysql -uroot -proot_password cpc -e "SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));"
docker-compose exec web bash -c "php symfony doctrine:build --all --no-confirmation"
wget https://data.regardscitoyens.org/nosdeputes.fr/nosdeputes.fr_donnees.sql.gz -O data/sql/donnees.sql.gz
gunzip data/sql/donnees.sql.gz
docker-compose exec mysql mysql -ucpc -pMOT_DE_PASSE cpc -e 'source /data/sql/donnees.sql'
```

# Accès

* nosdeputes.fr : http://localhost:8080
* phpmyadmin : http://localhost:8081/