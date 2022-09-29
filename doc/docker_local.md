# Prérequis

* docker (avec compose v2, ou bien utiliser docker-compose au lieu de "docker compose")

# Commandes principales

```bash
# démarrer l'ensemble de l'application
docker compose up
# s'il y a eu des changements dans le Dockerfile
docker compose up --build web
# pour recréer le docker web from scratch
docker compose up --build --force-recreate web
# suivre les logs apaches
docker compose exec web bash -c "tail -f /var/log/apache2/*"
# nettoyer le cache symfony
docker compose exec web bash -c "php symfony cc"
# se connectersur la db
docker compose exec mysql mysql -uroot -proot_password 
```

# Setup de l'application
```
cp config/app.yml.example.docker config/app.yml
cp config/databases.yml.example.docker config/databases.yml
cp lib/vendor/SolrServer/solr/conf/solrconfig.xml.example lib/vendor/SolrServer/solr/conf/solrconfig.xml
docker compose exec web bash -c "make all"
```

# Setup de la base de données

```bash
# la commande suivante est a effectuer à chaque démarrage du docker
docker compose exec mysql mysql -uroot -proot_password cpc -e "SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));"
docker compose exec web bash -c "php symfony doctrine:build --all --no-confirmation"
wget https://data.regardscitoyens.org/nosdeputes.fr/nosdeputes.fr_donnees.sql.gz -O data/sql/donnees.sql.gz
gunzip data/sql/donnees.sql.gz
docker compose exec mysql mysql -ucpc -pMOT_DE_PASSE cpc -e 'source /data/sql/donnees.sql'
```

# Indexation dans solr

```bash
docker compose exec web bash -c "bin/indexSolr"
```

# Accès

* nosdeputes.fr : http://localhost:8082
* phpmyadmin : http://localhost:8081
* solr : http://localhost:8080/solr_nosdeputes