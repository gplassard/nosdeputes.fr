FROM tomcat:9-jre17

COPY config/solr_nosdeputes.xml.docker /usr/local/tomcat/conf/Catalina/localhost/solr_nosdeputes.xml
COPY lib/vendor/SolrServer/webapps/solr.war /opt/solr/webapps/solr.war
