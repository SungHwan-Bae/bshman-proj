#!/bin/bash
#내부 proxy 서버에서 다른서버에 접근하는 용도의 shell script
i=0
iCnt=0
id='id'
IFS=$'\n' ARR=(`gcloud compute instances list --format='table(name,zone,EXTERNAL_IP,INTERNAL_IP,status)'`)

for VALUE in "${ARR[@]}";
do
  echo "[$i] :  $VALUE";
  i=$(($i+1))
done


iCnt=$(($i-1))

echo -n "접속 대상 VM 번호 선택[1~$iCnt] : ";
read input

if [[ $iCnt -ge $input ]]; then
  echo ${ARR[input]}
  name=$(echo ${ARR[input]} | awk '{print $1}')
  ip=$(echo ${ARR[input]} | awk '{print $4}')

  echo "--------------Server Name : $name, IP : $ip  으로 접속합니다 ------------------"
  # 사이트별로 proxy접근 계정을 생성하여서 neogames > 해당계정으로 변경하여서 입력
  ssh $id@$ip

else
  break;
fi
