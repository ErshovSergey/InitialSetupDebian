### Установка docker на Debian
Устанавливаем  
```
apt-get install snmpd snmp
```
Сохраняем файл настроек:
```
cp /etc/snmp/snmpd.conf /etc/snmp/snmpd.conf.orig
```
Редактируем файл */etc/snmp/snmpd.conf*  
```
# доступ по snmp будет только с адреса 192.168.1.1
rocommunity public 192.168.1.1
# отключаем логирование в системном журнале
dontLogTCPWrappersConnects yes
```
Перезапускаем службу snmp:  
```
service snmpd restart
```

Проверяем с узла zabbix доступность узла по snmp
```
snmpwalk -v 2c -c public -O e host_ip_addr
```
