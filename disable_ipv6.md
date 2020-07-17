### Отключаем ipv6  в debian
Для этого создаем файл */etc/sysctl.d/10-ipv6-privacy.conf*
```
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
```
Применяем настройки  
```
sysctl -p /etc/sysctl.d/10-ipv6-privacy.conf
```
