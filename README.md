# A basic mirrormaker demo

This repo contains a fairly basic demonstration of how mirror maker can replicate topics between 2 separate Kafka clusters.

The scripts are written in a fairly primative way to ease understanding

## Prerequisites

- An local copy of the Kafka CLI. Download from [here](https://kafka.apache.org/downloads)
  - Then set the `KAFKA_BIN` environment variable to the location of the `/bin` folder in the CLI. This is referenced in the scripts


## Steps

_(Throughout these steps I will mention opening many separate terminals, but feel free to run the scripts however feels best for you)_

1. Open a terminal and run `./start-zookeeper-1.sh` to start a Zookeeper for the first Kafka cluster to use
2. Open another terminal and run `./start-zookeeper-2.sh` to start a Zookeeper for the second Kafka cluster to use
3. Once the first Zookeeper is running, open another terminal and run `./start-kafka-1.sh` to start the first Kafka cluster
4. Once the second Zookeeper is running, open another terminal and run `./start-kafka-2.sh` to start the second Kafka cluster

Both Kafka clusters are now running and should be accessible on ports 9092 and 9093 respectively.

The first Kafka cluster will act as the base cluster that will be replicated from. The second cluster will act as the mirror cluster that will be replicated to.

The goal will be to mirror a topic called `test-topic` on the base cluster to the mirrored cluster.

Next step is to setup consumers/producers in order to send/see messages in the clusters

7. Open a new terminal and run `./consume-from-base-topic.sh`. The process will hang and output messages when they become available so leave this terminal open.
8. Open a new terminal and run `./consume-from-mirror-topic.sh`. As above, keep this terminal open. _(Note that these 2 steps actually auto-create their topics, a detail you might not want in a production scenario)_
9. Open a new terminal and run `./produce-to-base-topic.sh`
10. When the `>` appears messages are ready to be sent. Enter some test messages and they should appear in the consumer for the base topic but not the mirror topic.

And then finally run mirror maker in order to start the replication between the 2 topics.

11. Open a new terminal and run `./start-mirrormaker.sh`.
12. The messages from the base topic should now appear in the mirror topic and any future messages sent should also be replicated.
13. When you're finished playing around, exist all the running processes and run `./clear-temps.sh`. This will give you a fresh start for when you run this again.

## Explanations

Please take a look inside the `.sh` script files. They're not complicated at all and were made just to make documenting the steps easier.

Also note the `./get-topics.sh` script which will show you the topics in each cluster. Be sure to take a look at all the topics that get auto-created by mirrormaker in each cluster.

The `./kafka.*.properties` files contains all the running config for the Kafka clusters

The `./zookeeper.*.properties` files contains all the running config for the Kafka clusters

These Kafka and Zookeeper configs are mostly copy and pasted from the default configs so comments aren't written by me.

The `./mm.properties` files contains the config for mirror maker.

I won't explain the configs here as there are many other resources online, but this repo can be used as a playground.

## Resources

Microsoft Learn:  [How to use Kafka MirrorMaker 2.0 in data migration, replication and the use-cases](https://learn.microsoft.com/en-us/azure/hdinsight/kafka/kafka-mirrormaker-2-0-guide)

Kafka: [6.3 Geo-Replication (Cross-Cluster Data Mirroring)](https://kafka.apache.org/documentation/#georeplication)

IBM: [Mirror Maker 2](https://ibm-cloud-architecture.github.io/refarch-eda/technology/kafka-mirrormaker/)