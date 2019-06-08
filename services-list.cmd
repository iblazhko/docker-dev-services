SET DOCKER_DEVSVC_PROJECT=devsvc
SET DOCKER_DEVSVC_COMPOSE_FILES=^
 -f compose-elasticsearch.yml^
 -f compose-eventstore.yml^
 -f compose-kibana.yml^
 -f compose-logstash.yml^
 -f compose-mongo.yml^
 -f compose-postgres.yml^
 -f compose-rabbitmq.yml^
 -f compose-redis.yml^
 -f compose-sqlserver.yml^
 -f compose-vault.yml^
 -f network.yml


REM Add to the list above as required
REM -f compose-elasticsearch.yml^
REM -f compose-eventstore.yml^
REM -f compose-kibana.yml^
REM -f compose-logstash.yml^
REM -f compose-mongo.yml^
REM -f compose-postgres.yml^
REM -f compose-rabbitmq.yml^
REM -f compose-redis.yml^
REM -f compose-sqlserver.yml^
REM -f compose-vault.yml^
