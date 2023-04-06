### При использовании без подписки исправить файл.  
_/etc/apt/sources.list.d/pve-enterprise.list_  
```
# PVE pve-no-subscription repository provided by proxmox.com, NOT recommended for production use
deb http://download.proxmox.com/debian/pve bullseye pve-no-subscription
``` 
### Убрать напоминание из веб-интерфейса об отсутствии подписки  
Для этого заменить в файле _/usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js_  
```
Ext.Msg.show({
title: gettext('No valid subscription'),
```
на  
```
void({ //Ext.Msg.show({
title: gettext('No valid subscription'),
```  
перезапустить сервис и сбросить кеш браузера  
```systemctl restart pveproxy.service```
### Выключить ipv6 на узле  
создать файл _/etc/sysctl.d/disable-ipv6.conf_  
```
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
```
