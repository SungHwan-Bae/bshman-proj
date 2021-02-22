import time
import random
import datetime
from json import dumps
from kafka import KafkaProducer

# bootstrap_servers = ['localhost:9092'] # kafka broker ip
bootstrap_servers = ['34.64.188.92:9092'] # kafka broker ip
topicName1 = 'bshman-test3'
# topicName2 = 'bshman-test2'
msg={"id":"test2","tel":"010-1111-2222","regDate":"20190603"}
# producer = KafkaProducer(bootstrap_servers = bootstrap_servers,value_serializer=lambda x: dumps(x).encode('utf-8'))
producer = KafkaProducer(bootstrap_servers = bootstrap_servers,value_serializer=lambda m: dumps(msg).encode('utf-8'))
# print(producer.config)

for i in range(100):
    # test1 - send numeric type
    print(i)
    keydata = 'keynum' 
    data = {'str' : 'result'+str(i)}
    # producer.send(topicName1, value=data,key=data)
    producer.send(topicName1, {'key','value'})
    # test2 = send string type
    text = 'my topic name ' + str(i) + ' msg'
    print(text)
    time.sleep(1)
