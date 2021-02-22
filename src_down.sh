#!/bin/sh

ID="solution"
PW="solution"
NOW_DATE=$(date +%Y%m%d)
ROOT_PATH=/home/encore
FILE_PATH=$ROOT_PATH/en_solution
#FOLDER_NAME=$FILE_PATH$NOW_DATE

#download path
WGET_COMM='wget --user='$ID' --password='$PW' '
#WGET_COMM='wget --user='$ID' --password='$PW' -o '$ROOT_PATH'/log/wget.log '
NEX_SOUR_PATH='http://nexus.encore.rnd:8081/repository/maven-releases/'
#JEN_SOUR_PATH='http://192.168.4.66:18080/job/dataware470/ws/dist/scriptrunner470/ar_installer.zip'

#source file path
#AR_PG_PATH='com/encore/dataware/dataware-service-ar-postgresql/6.0.0/dataware-service-ar-postgresql-6.0.0.tar.gz'
AR_PG_PATH=$WGET_COMM$NEX_SOUR_PATH'com/encore/dataware/dataware-service-ar-postgresql/6.0.0/dataware-service-ar-postgresql-6.0.0.tar.gz'
AR_ORA_PATH=$WGET_COMM$NEX_SOUR_PATH'com/encore/dataware/dataware-service-ar-oracle/4.7.0/dataware-service-ar-oracle-4.7.0.zip'
META_PG_PATH=$WGET_COMM$NEX_SOUR_PATH'com/encore/dataware/dataware-module-meta-postgresql/4.7.0/dataware-module-meta-postgresql-4.7.0.war'
META_ORA_PATH=$WGET_COMM$NEX_SOUR_PATH'com/encore/dataware/dataware-module-meta-oracle/4.7.0/dataware-module-meta-oracle-4.7.0.war'
MOCA_PATH=$WGET_COMM$NEX_SOUR_PATH'com/encore/dataware/dataware-engine-moca/1.2.0/dataware-engine-moca-1.2.0.tar.gz'
DF_PATH=$WGET_COMM$NEX_SOUR_PATH'com/encore/dataware/dataware-module-df/1.0.5/dataware-module-df-1.0.5.jar'
AP_PATH=$WGET_COMM$NEX_SOUR_PATH'com/encore/dataware/dataware-module-ap/4.5.4/dataware-module-ap-4.5.4.jar'


#route job start
./route.sh

PS3='Enter Repository: '
options=("DA" "META" "MOCA" "AR" "Quit")
select opt in "${options[@]}"
do
    case $opt in
                "DA" )
                echo "Installing $opt Version"
                cd $FILE_PATH"/DA"
                rm -r $NOW_DATE
                mkdir $NOW_DATE
                cd $NOWDATE
                break
                ;;
                "META" )
                echo "Installing $opt Version"
                cd $FILE_PATH"/META"
                rm -r $NOW_DATE
                mkdir $NOW_DATE
                cd $NOW_DATE
                $META_PG_PATH
                $META_ORA_PATH
                $DF_PATH
                $AP_PATH
                break
                ;;
                "MOCA" )
                echo "Installing $opt Version"
                cd $FILE_PATH"/MOCA"
                rm -r $NOW_DATE
                mkdir $NOW_DATE
                cd $NOW_DATE
                $MOCA_PATH
                break
                ;;
                "AR" )
                echo "Installing $opt Version"
                cd $FILE_PATH"/AR"
                rm -r $NOW_DATE
                mkdir $NOW_DATE
                cd $NOW_DATE
                $AR_PG_PATH
                $AR_ORA_PATH
                break
                ;;
                "Quit" )
                  break;
                ;;
                *) echo "invalid option $REPLY";;
        esac
done
echo ">>>>>>>> Installing Finish <<<<<<<<<<"

ps -ef | grep "openvpn" | grep -v "grep" | awk '{print $2}' | while read line; do sudo kill -9 $line; done
