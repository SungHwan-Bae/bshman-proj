#!/bin/bash
#외부에서 gcp vm instance 접근사용용도
gi=0
ki=0
giCnt=0
kiCnt=0
id='bshman'

keyflag=1 ## 해당 플래그는 로그인시 키정보를 선택여부 : 0(안물어본다),1(물어본다)
keypath=~/gcp-key  ## gcp key 파일 위치

keyfilename=~/gcp-key/rsa-gcp-key
#keyfilename=~/gcp-key/rfkey

IFS=$'\n' KEYARR=(`find ~/gcp-key/ -type f -not -name "*.*"`)
IFS=$'\n' GCPARR=(`gcloud compute instances list --format='table(name,zone,EXTERNAL_IP,status)'`)

  ## GCP VM리스트 담기
  for GCPVALUE in "${GCPARR[@]}";
  do
    echo "[$gi] :  $GCPVALUE";
    gi=$(($gi+1))
  done

  giCnt=$(($gi-1))

  echo -n "접속 대상 VM 번호 선택[1~$giCnt] : ";
  read gcpinput

  ## GCP key파일 정보를 선택하는 로직
  if [ $keyflag -ge 1 ]; then
    ## gcp-key파일 리스트담기
    for KEYVALUE in "${KEYARR[@]}";
    do
      filelist=`basename $KEYVALUE`
      echo "[$ki] : $keypath/$filelist";
      ki=$(($ki+1))
    done

    kiCnt=$(($ki-1))
    echo -n "사용 key 선택[1~$kiCnt] : ";
    read keyinput
    keyfile=$(echo ${KEYARR[keyinput]})
    keyfile=$keypath/`basename $keyfile`
  else
    keyfile=$keyfilename
  fi

  ## 해당키정보를 보여준다.
  echo $keyfile

  ##서버 접근
  if [[ $giCnt -ge $gcpinput ]]; then
    #echo ${GCPARR[gcpinput]}
    name=$(echo ${GCPARR[gcpinput]} | awk '{print $1}')
    ip=$(echo ${GCPARR[gcpinput]} | awk '{print $3}')

    echo "--------------Server Name : $name, IP : $ip  으로 접속합니다 ------------------"
    #ssh -i ~/gcp-key/homepage homepage@$ip
    #ssh -i ~/.ssh/rsa-gcp-key bshman@$ip
    #ssh -i ~/gcp-key/rfkey bshman@$ip
    ssh -i $keyfile $id@$ip

  else
    break;
  fi
