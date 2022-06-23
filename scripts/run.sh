#Druid Commands
curl -XPOST -H'Content-Type: application/json' -d @specs/supervisor_rollups.spec http://localhost:8081/druid/indexer/v1/supervisor
curl -XPOST -H'Content-Type: application/json'   http://localhost:8081/druid/indexer/v1/supervisor/terminateAll

#Docker commands
docker-compose -f distribution/docker/docker-compose.yml up -d

#Kafka Commands
./bin/zookeeper-server-start.sh config/zookeeper.properties
./bin/kafka-server-start.sh config/server.properties
./bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic wikipedia3
./bin/kafka-console-producer.sh --broker-list localhost:9092 --topic wikipedia3
./bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic wikipedia3 --from-beginning
