Zabbix_API_user_offboardning

This Script is for search or delete user/s in multi servers there is two different script for this job :
offboarding.sh
this script need a file "zabbixservers.txt" for access to servers.
this file must include Zabbix servers URL and token with this format :
```
[ZABBIX Server1 URL(full API URL without '/api_jsonrpc.php)'],[API_TOKEN1]
[ZABBIX Server2 URL(full API URL without '/api_jsonrpc.php)'],[API_TOKEN2]
[ZABBIX Server3 URL(full API URL without '/api_jsonrpc.php)'],[API_TOKEN3]
```

zabbixservers.txt sample data :
```
http://test-frontend2.net,b375e3e0cf8adaea84c1c66f826435e5
http://test-frontend3.net,b375e3e0cf8adaea84c1c66f826435e5
```


this script need to pass username(full or part of it) by -u switch ,and action "search/delete" by -a for example :
```
./offfboardinf.sh -u smith -a searsh
./offfboardinf.sh -u smith -a delete
```






sample output for searchUser2 :
```


=======================================================
 _   _               _____                     _     
| | | |             /  ___|                   | |    
| | | |___  ___ _ __\ `--.  ___  __ _ _ __ ___| |__  
| | | / __|/ _ \ .__|`--. \/ _ \/ _` |  __/ __|  _ \ 
| |_| \__ \  __/ |  /\__/ /  __/ (_| | | | (__| | | |
 \___/|___/\___|_|  \____/ \___|\__,_|_|  \___|_| |_|
=======================================================


Searching for username: <<power>> on zabbix server: <<http://192.168.0.77>>
      "username": "Bob Power",
      "username": "Max power",
      "username": "m_power",
```




sample output for deleteUser :
```



==============================================
 _   _              ______     _      _       
| | | |             |  _  \   | |    | |      
| | | |___  ___ _ __| | | |___| | ___| |_ ___ 
| | | / __|/ _ \  __| | | / _ \ |/ _ \ __/ _ \
| |_| \__ \  __/ |  | |/ /  __/ |  __/ ||  __/
 \___/|___/\___|_|  |___/ \___|_|\___|\__\___|
==============================================


Deleting user/s: <<power>> on zabbix server: <<http://192.168.0.77>>
      "username": "Max power"
      "username": "m_power"
```
