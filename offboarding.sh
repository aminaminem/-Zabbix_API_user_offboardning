#!/bin/bash
CURL_JASON='Content-Type: application/json'
ZABBIX_SERVERS="zabbixservers.txt"
USER_NAME_SEARCH="AllUserDeletePrevention"
USER_NAME_ERASE="AllUserDeletePrevention"



while getopts 'a:u:' flag
do
    case "${flag}" in
        u) USER_NAME_SEARCH=${OPTARG};;
        a) ACTION=${OPTARG};;
        *) echo 'Syntax Error(Not Correct argument/Option)' >&2
       	exit 1
    esac
done




if [ "$ACTION" == "search" ] ; then
{{{
echo
echo
echo '======================================================='
echo ' _   _               _____                     _     '
echo '| | | |             /  ___|                   | |    '
echo '| | | |___  ___ _ __\ `--.  ___  __ _ _ __ ___| |__  '
echo '| | | / __|/ _ \ .__|`--. \/ _ \/ _` |  __/ __|  _ \ '
echo '| |_| \__ \  __/ |  /\__/ /  __/ (_| | | | (__| | | |'
echo ' \___/|___/\___|_|  \____/ \___|\__,_|_|  \___|_| |_|'
echo '======================================================='
echo
echo


#JSON Function for user name get :
USER_NAME_GET='{
    "jsonrpc": "2.0",
    "method": "user.get",
    "params":{
        "search": {
            "username": "'$USER_NAME_SEARCH'"
        		},
        "output": ["username"]
    },
    "auth": "'$ZABBIX_TOKEN'",
    "id": 1
}'


#these commands serach and show a user from part of username/name/surname :
	echo "Searching for username: <<"$USER_NAME_SEARCH">> on zabbix server: <<"$ZABBIX_URL">>"
	ZABBIX_URL=$ZABBIX_URL"/api_jsonrpc.php"
	curl -i -X POST -H "$CURL_JASON" -d "$USER_NAME_GET" $ZABBIX_URL 2>&1 | grep result | jq '.' | grep username
	echo
#done < "$ZABBIX_SERVERS"
echo
echo
exit 1
}}}


elif [ "$ACTION" == "delete" ] ; then
{{{

echo
echo
echo '=============================================='
echo ' _   _              ______     _      _       '
echo '| | | |             |  _  \   | |    | |      '
echo '| | | |___  ___ _ __| | | |___| | ___| |_ ___ '
echo '| | | / __|/ _ \  __| | | / _ \ |/ _ \ __/ _ \'
echo '| |_| \__ \  __/ |  | |/ /  __/ |  __/ ||  __/'
echo ' \___/|___/\___|_|  |___/ \___|_|\___|\__\___|'
echo '=============================================='
echo
echo

#JSON Function for user name get :
USER_NAME_GET='{
    "jsonrpc": "2.0",
    "method": "user.get",
    "params":{
        "search": {
            "username": "'$USER_NAME_ERASE'"
        		},
        "output": ["username"]
    },
    "auth": "'$ZABBIX_TOKEN'",
    "id": 1
}'

#JSON Function for user ID get :
USER_ID_GET='{
    "jsonrpc": "2.0",
    "method": "user.get",
    "params":{
        "search": {
            "username": "'$USER_NAME_ERASE'"
        		},
        "output": ["userid"]
    },
    "auth": "'$ZABBIX_TOKEN'",
    "id": 1
}'


	echo "Deleting user/s: <<"$USER_NAME_ERASE">> on zabbix server: <<"$ZABBIX_URL">>"
	ZABBIX_URL=$ZABBIX_URL"/api_jsonrpc.php"
	USERIDs_DELETE=( $(curl -i -X POST -H "$CURL_JASON" -d "$USER_ID_GET" $ZABBIX_URL 2>&1 | grep result |  jq '.result|map(.userid)' ))
	USERIDs_DELETE="${USERIDs_DELETE[@]}"

#JSON Function for user name Delete :
USER_NAME_DELETE='{
    "jsonrpc": "2.0",
	"method": "user.delete",
    "params":
    '$USERIDs_DELETE',
    "auth": "'$ZABBIX_TOKEN'",
    "id": 1
}'

#these commands show and delete searched user/s
	curl -i -X POST -H "$CURL_JASON" -d "$USER_NAME_GET" $ZABBIX_URL 2>&1 | grep result | jq '.' | grep username
	curl -s -X POST -H "$CURL_JASON" -d "$USER_NAME_DELETE" $ZABBIX_URL
	echo
#done < "$ZABBIX_SERVERS"
echo
echo
exit 1
}}}

else
 echo "syntax error"
 echo "correct format for searsh user : ./offfboardinf.sh -u "smith" -a searsh"
 echo "correct format for delete user : ./offfboardinf.sh -u "smith" -a delete"
 exit 1
fi
