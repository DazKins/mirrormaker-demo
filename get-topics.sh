echo "[--main cluster topics--]"
$KAFKA_BIN/kafka-topics.sh --bootstrap-server localhost:9092 --list
echo ""
echo "[--mirror cluster topics--]"
$KAFKA_BIN/kafka-topics.sh --bootstrap-server localhost:9093 --list
