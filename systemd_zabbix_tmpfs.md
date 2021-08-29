### Проблема
Если логи zabbix находятся на файловой системе tmpfs - при перезагрузке нет папки для файлов.

### Решение  
Создать папки при загрузке.  
#### Если используется systemd  
Добавить в файл */lib/systemd/system/zabbix-agent.service* строки  
```
[Service]
...
PermissionsStartOnly=true
ExecStartPre=-/bin/mkdir -p /var/log/zabbix
ExecStartPre=-/bin/chown zabbix:zabbix /var/log/zabbix
...
```
Перечитать настройки и запустить  
```systemctl daemon-reload```  
```systemctl start zabbix-agent.service```  
