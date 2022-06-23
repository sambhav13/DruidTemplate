## Druid Template
This Template can be used to deploy Druid cluster using docker-compose.yml to spawn services(router, coordinator, historical etc.) needed for druid and also start a
Supervisor Spec Process to index data into druid using kafka indexing service plugin


## Folder Structure
> dockerCode 
- druid - Contains the druid code base and Dockerfile files, docker-compose.yml , environment parameters.
- specs - contains the supervisor spec to start the supervisor process for starting kafka indexing process and necessary tasks.
> scripts 
 - run.sh - Helper scripts

> data 
 - hourlyData.json - Initial producer data for kafka 
 - hourlyDelta.json - Delta producer data for kafka

## How to use
> 1. Start the Druid cluster either standalone or docker-compose.yaml()
- Standlone -
  - Download Link - https://www.apache.org/dyn/closer.cgi?path=/druid/0.22.1/apache-druid-0.22.1-bin.tar.gz
  - Deploy -  ./bin/start-micro-quickstart
- Cluster - 
  - Location -  druid/distribution/docker/docker-compose.yml
  - Deploy - docker-compose -f distribution/docker/docker-compose.yml up -d

> 2. Prepare the Supervisor Spec
    - Ref: dockerCode/specs/supervisor_rollups.json

> 3. Start a kafka server 
 - Standalone -
    - Download Link - https://archive.apache.org/dist/kafka/1.1.1/kafka_2.11-1.1.1.tgz
    - Deploy : deploy a standalone using kafka referring to the
 - Cluster - 
 - Location -  druid/distribution/docker/docker-compose.yml
   - Deploy - docker-compose -f distribution/docker/docker-compose.yml up kafka -d 
   - Deploy - docker-compose -f distribution/docker/docker-compose.yml up zookeeper2 -d  

> 4. Create Kafka Topic (wikipedia3)
  - Ref to the scripts folder 

> 5. Register the Supervisor Spec
  - curl -XPOST -H'Content-Type: application/json' -d @supervisor_rollups.json  http://localhost:8081/druid/indexer/v1/supervisor

> 6. Produce messages on Kafka Topic one by one
  - Initial Load - ./bin/kafka-console-producer.sh --broker-list localhost:9092 --topic wikipedia3 < data/hourlyData.json
    - Delta Load - ./bin/kafka-console-producer.sh --broker-list localhost:9092 --topic wikipedia3
    - Messages - Put messages from data/hourlyDelta.json

> 7. Observer Rollups on the Druid UI Console 
  - A Supervisor spec process woud start with name wikipedia3 creating necessary tasks and segments
  - Start querying your data once segements are created using sql tab in real time 
  - Query - select * from wikipedia3

## Miscellaneous
> you can refer to the Scripts folder for reference for various commands related to kafka. 

## NOTE:
The scripts should be changed accordingly when a druid cluster is deployed vs standalone 