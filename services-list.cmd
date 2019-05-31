SET DOCKER_DEVSVC_PROJECT=devsvc
SET DOCKER_DEVSVC_COMPOSE_FILES=^
 -f compose-elasticsearch.yml^
 -f compose-kibana.yml^
 -f compose-mongo.yml^
 -f compose-rabbitmq.yml^
 -f compose-eventstore.yml^
 -f network.yml


REM Add to the list above as required
REM -f compose-logstash.yml^
REM -f compose-redis.yml^
REM -f compose-sqlserver.yml^
REM -f compose-postgres.yml^
REM -f compose-vault.yml^

