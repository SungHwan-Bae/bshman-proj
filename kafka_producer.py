import time
import random
import datetime
from kafka import KafkaProducer

# bootstrap_servers = ['localhost:9092'] # kafka broker ip
bootstrap_servers = ['34.64.188.92:9092'] # kafka broker ip
topicName1 = 'bshman-test3'
# topicName2 = 'bshman-test2'
producer = KafkaProducer(bootstrap_servers = bootstrap_servers)
# print(producer.config)

for i, _ in enumerate(range(10)):

    # test1 - send numeric type
    print(i)
    producer.send(topicName1, str(i).encode())
    # producer.send(topicName2, str(i).encode())

    # test2 = send string type
    text = 'my topic name ' + str(i) + ' msg'
    print(text)

    tim = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    # producer.send(topicName1, text.encode())
    # producer.send(topicName1, tim.encode())

    # producer.send(topicName2, text.encode())
    # producer.send(topicName2, tim.encode())

    time.sleep(1)
