# from google.cloud import bigquery
import GcpAuthLib
from pprint import pprint
# from google.oauth2 import service_account
from googleapiclient import discovery

## api 호출을 위한 기본정보
project = 'encore-product-proj' 
zone = 'asia-northeast3-a' 
## 변수선언
vZone = ""
NotName = {'jskim-hadoop'}
## 키정보
key_path = "D:\dev\gcp-vm-key.json"

## 인증시작
vAuth = GcpAuthLib.GcpAuthConnect(key_path)
credentials = vAuth.GetGcpAuth()

## instance 리스트 가져오기
service = discovery.build('compute', 'v1', credentials=credentials)

request = service.instances().list(project=project, zone=zone)
response = request.execute()
# print(response)
## instance 정보 찾기
for instance in response['items'] :
    # if instance['name'] == 'encore-test': 
    if instance['status'] == 'RUNNING' and instance['name'] not in NotName: 
        vm_name = instance['name']
        vm_status = instance['status']
        vZone = instance['zone']
        vZone = vZone.replace("https://www.googleapis.com/compute/v1/projects/encore-product-proj/zones/","")
        print(vm_name , vm_status , vZone)

        # name = 'encore-test'
        request = service.instances().stop(project=project, zone=vZone, instance=vm_name)
        # response = request.execute()  ##시작
