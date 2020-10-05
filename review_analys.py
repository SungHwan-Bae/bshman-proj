# 테이블생성
# date:STRING,user_name:STRING,review_text:STRING,rating:INTEGER,score:FLOAT,magnitude:FLOAT
import argparse
import os
# from time import sleep
from google.cloud import language
from google.cloud.language import enums
from google.cloud.language import types
from google.cloud import bigquery

rows_to_inserts=[]

def analyze(date,user_name,review_text,rating):
    # Instantiates a client
    client = language.LanguageServiceClient()
    document = types.Document(
        content=review_text,
        type=enums.Document.Type.PLAIN_TEXT)

    # Detects the sentiment of the text
    sentiment = client.analyze_sentiment(document=document).document_sentiment

#     print(path,'Text: {}'.format(review_text))
#     print(date)
    rewview_insert(date,user_name,review_text,rating,sentiment.score, sentiment.magnitude)

#감정분석 대상 데이터를 DATABASE에서 조회.
def rewview_select(connect_info):
    # Instantiates a client    
    bigquery_client = bigquery.Client()
    ## sql 수행
    QUERY = (
        'SELECT user_name,date,rating,review_text '
        'FROM `bshman-test-proj.nc_new.review_table` '
        'WHERE 1 = 1 '
    )
    query_job = bigquery_client.query(QUERY)  # API request
    rows = query_job.result()  # Waits for query to finish

    for row in rows:
        analyze(row.date
               ,row.user_name
               ,row.review_text
               ,row.rating)

#분석한 데이터를 다시 DATABASE에 저장한다        
def rewview_insert(date,user_name,review_text,rating,socre,magnitude):
    bigquery_client = bigquery.Client()
    dataset_ref = bigquery_client.dataset('nc_new')

    table_ref = dataset_ref.table('nature_review_val')
    table = bigquery_client.get_table(table_ref)  # API call

    rows_to_insert = [
            (date,user_name,review_text,rating,socre,magnitude)
        ]
    errors = bigquery_client.insert_rows(table, rows_to_insert)  # API request
    print(errors)

    
##시작
print("시작")
rewview_select("gogo")
print("끝")
