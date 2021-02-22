import GcpAuthLib
import json
from pprint import pprint
from google.cloud import bigquery_datatransfer_v1
from googleapiclient import discovery
# from google.cloud import scheduler_v1

## 키정보
key_path = "D:\공통관리\키정보\encore-product-proj-36a76d713686.json"
vProject = 'encore-product-proj'
vDataSet = 'kor_bshman'
vLocation = 'asia-northeast3'
# parent='projects/encore-product-proj/locations/asia-northeast3'

# 인증시작
vAuth = GcpAuthLib.GcpAuthConnect(key_path)
credentials = vAuth.GetGcpAuth()

# scheduler_v1.cloud_scheduler_client
client = bigquery_datatransfer_v1.DataTransferServiceClient(credentials=credentials)

parent = client.common_location_path(vProject,vLocation)
# rVal = client.list_transfer_configs(parent=parent)
rVal = client.transfer_config_path(parent=parent)

for rVals in rVal:
#     print(rVals.params('fields').key)
    # print('{}:'.format(rVals.params{'query'}))
    # print({rVals.params})
    print(f"\destination_dataset_id: {rVals.destination_dataset_id}, display_name: {rVals.display_name}, QueryString:{rVals.params.fields.key}")

# params {
#       fields {
#         key: "destination_table_name_template"
#         value {
#           string_value: "test_insert"
#         }
