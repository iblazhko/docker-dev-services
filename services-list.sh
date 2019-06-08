DOCKER_DEVSVC_PROJECT=devsvc
DOCKER_DEVSVC_COMPOSE_FILES="\
 -f compose-elasticsearch.yml\
 -f compose-eventstore.yml\
 -f compose-kibana.yml\
 -f compose-logstash.yml\
 -f compose-mongo.yml\
 -f compose-postgres.yml\
 -f compose-rabbitmq.yml\
 -f compose-redis.yml\
 -f compose-sqlserver.yml\
 -f compose-vault.yml\
 -f network.yml\
 "

# Add to the list above as required:
# -f compose-elasticsearch.yml\
# -f compose-eventstore.yml\
# -f compose-kibana.yml\
# -f compose-logstash.yml\
# -f compose-mongo.yml\
# -f compose-postgres.yml\
# -f compose-rabbitmq.yml\
# -f compose-redis.yml\
# -f compose-sqlserver.yml\
# -f compose-vault.yml\
