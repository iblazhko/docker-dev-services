DOCKER_DEVSVC_PROJECT=devsvc
DOCKER_DEVSVC_COMPOSE_FILES="\
 -f compose-elasticsearch.yml\
 -f compose-kibana.yml\
 -f compose-mongo.yml\
 -f compose-rabbitmq.yml\
 -f compose-eventstore.yml\
 -f compose-vault.yml\
 -f network.yml\
 "

# Add to the list above as required:
# -f compose-logstash.yml\
# -f compose-redis.yml\
# -f compose-sqlserver.yml\
# -f compose-postgres.yml\
# -f compose-vault.yml\
 