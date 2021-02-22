from kafka import KafkaConsumer

consumer = KafkaConsumer('bshman-test3',bootstrap_servers=['34.64.188.92:9092'])
for message in consumer:
    print ("%s:%d:%d: key=%s value=%s" % (message.topic, message.partition,
                message.offset, message.key,
                message.value))
