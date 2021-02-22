import GcpAuthLib
from google.cloud import bigquery_datatransfer_v1

## 키정보
key_path = "D:\공통관리\키정보\encore-product-proj-36a76d713686.json"
vProject = 'encore-product-proj'
vDataSet = 'kor_bshman'
vLocation = 'asia-northeast3'

# 인증시작
vAuth = GcpAuthLib.GcpAuthConnect(key_path)
credentials = vAuth.GetGcpAuth()

client = bigquery_datatransfer_v1.DataTransferServiceClient(credentials=credentials)
# credentials = client.from_service_account_json(key_path)

parent = client.common_project_path(vProject)

query_string = """
SELECT
  CURRENT_TIMESTAMP() as current_time,
  @run_time as intended_run_time,
  @run_date as intended_run_date,
  17 as some_integer
"""

transfer_config = bigquery_datatransfer_v1.TransferConfig(
    destination_dataset_id=vDataSet,
    display_name="Your Scheduled Query Name",
    data_source_id="scheduled_query",
    params={
        "query": query_string,
        "destination_table_name_template": "your_table_{run_date}",
        "write_disposition": "WRITE_TRUNCATE",
        "partitioning_field": "",
    },
    schedule="every 24 hours",
)

#생성
response = client.create_transfer_config(
    request={
        "parent": parent,
        "transfer_config": transfer_config,
        # "authorization_code": authorization_code,
    }
)

print("Created scheduled query '{}'".format(response.name))
