Если имя сетевого интерфейса слишком длинное - возникают непонятные проблемы.  
Иногда для упрощения понимания также стоит изменить имя интерфейса.  
### Как изменить имя интерфейса  
#### Создать файл, указать mac адрес нужного интефейса и новое име  
```
# interface with MAC address "00:50:56:92:95:88" will be assigned "eth0"
SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="e2:6f:13:f4:3c:4b", ATTR{dev_id}=="0x0", ATTR{type}=="1", KERNEL=="eth*", NAME="eth4"
```
#### При настройке в файле _/etc/network/interfaces_ указывать уже новое имя
```
auto eth4
#  iface enxe46f13f34b inet static
  iface eth4 inet static
  address 10.32.0.208
  netmask 255.255.252.0
  gateway 10.20.0.1
```
