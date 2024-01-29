### Настройка обновлений   
[виртуальная][физическая][ноутбук]  
_/etc/apt/sources.list_
#### Debian 11
```
deb http://ftp.ru.debian.org/debian bullseye main contrib
deb http://ftp.ru.debian.org/debian bullseye-updates main contrib

# security updates
deb http://security.debian.org/debian-security bullseye-security main contrib non-free
```
#### Debian 12
```
deb http://deb.debian.org/debian bookworm main
deb-src http://deb.debian.org/debian bookworm main

deb http://deb.debian.org/debian-security/ bookworm-security main
deb-src http://deb.debian.org/debian-security/ bookworm-security main

deb http://deb.debian.org/debian bookworm-updates main
deb-src http://deb.debian.org/debian bookworm-updates main
```
### ДоУстановить пакеты
[физическая][ноутбук]  
```apt install -y bash-completion sudo tmux rsync```  
[виртуальная]  
```apt install -y qemu-guest-agent rsync```  

### Окружение
добавить в _/root/.bashrc_ содержимое файла
добавить в _/root/.nanorc_ содержимое файла

### Выключить ipv6 на узле  
[виртуальная][физическая][ноутбук]  
создать файл _/etc/sysctl.d/disable-ipv6.conf_  
```echo 'net.ipv6.conf.all.disable_ipv6 = 1' > /etc/sysctl.d/disable-ipv6.conf```  
```echo 'net.ipv6.conf.default.disable_ipv6 = 1' >> /etc/sysctl.d/disable-ipv6.conf```  
### Меняем часовой пояс  
```timedatectl set-timezone Europe/Moscow```  
### Пользователь support  
добавить пользователя support  
```adduser support```   
добавить права на переход в root - создать файл _/etc/sudoers.d/support_   
```mkdir -p /etc/sudoers.d && echo 'support ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/support```   
### Установить сервер времени (для физичеких ПК)   
[виртуальная][физическая][ноутбук]
в файле _/etc/chrony/chrony.conf_ указать сервер времени
```pool 10.1.1.254 iburst```

Debian - как установить locale - en US.UTF-8

```sed -i "s/# ru_RU/ru_RU/" /etc/locale.gen```  
```sed -i "s/# en_US/en_US/" /etc/locale.gen```  
```locale-gen en_US.UTF-8 ru_RU.UTF-8```  
```echo LANG=en_US.UTF-8 > /etc/default/locale```  
```source /etc/default/locale```  
Проверяем результат:   
```locale```

LANG=en_US.UTF-8  
LANGUAGE=en_US.UTF-8  
LC_CTYPE="en_US.UTF-8"  
LC_NUMERIC="en_US.UTF-8"  
LC_TIME="en_US.UTF-8"  
LC_COLLATE="en_US.UTF-8"  
LC_MONETARY="en_US.UTF-8"  
LC_MESSAGES="en_US.UTF-8"  
LC_PAPER="en_US.UTF-8"  
LC_NAME="en_US.UTF-8"  
LC_ADDRESS="en_US.UTF-8"  
LC_TELEPHONE="en_US.UTF-8"  
LC_MEASUREMENT="en_US.UTF-8"  
LC_IDENTIFICATION="en_US.UTF-8"  
LC_ALL=en_US.UTF-8  

### Сетевой интерфейс   
Статический адрес на сетевом интерфейсе   
_/etc/network/interfaces_   
```
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback
```
_/etc/network/interfaces.d/primary_  
```
# The primary network interface
auto ens18
allow-hotplug eth0
iface ens18 inet static
  address 10.C.B.A
  mask 255.255.D.0
```
### Удалить файлы настроек "~*"  
#### Роуты  
Добавить роут по умолчанию  
```ip route add default via 10.20.0.1```
### Дополнительные роуты  
Роут для все  сетей добавить в /etc/network/interfaces
```up ip route add 10.10.0.0/16 via 10.10.2.254```
### Настройка использования SWAP  
Появилось после ухода в SWAP на хостах Proxmox.  
По умолчанию при заполнении оперативной памяти на 60% и более начинает использоваться swap.  
Проверить текущее значение  
```sysctl vm.swappiness```  
или  
```cat /proc/sys/vm/swappiness```  
Чтобы изменить процент сейчас:  
```sysctl -w vm.swappiness=10```  
Чтобы изменить процент после перезагрузки:  
```echo 'vm.swappiness = 10' >> /etc/sysctl.conf```  
что добавит в конец файла, где 10 - процент заполнения оперативной памяти  
_vm.swappiness = 10_  
Применить без перезагрузки  
```sysctl --load```  
```sysctl --system```  
но лучше перезагрузить.  

### Добавление диска для данных  
добавить диск физически или в ВМ  
проверить подключение и узнать логическое имя диск  
- если нужна gpt  
устанавливаем parted   
```apt install parted```
создаем таблицу gpt  
```parted /dev/sdb```  
в parted  
```mklabel gpt```  

```fdisk -l```  
разметить весь диск как primary  
```fdisk /dev/sdb```  
```m``` ```n``` ```p``` ```w```  
Форматирование диска  
```mkfs.ext3 /dev/sdb1```  
Создаем точку монтирования   
```mkdir /mnt/512G```  
```chmod -R 660 /mnt/512G```  
Монитруем   
```mount /dev/sdb1 /mnt/512G```  
узнать UUID  
```blkid```  
добавить монтирование диска в _/etc/fstab_   
```echo "UUID=ca601d12-18d8-47dd-9a9e-9f735e8ffc3a /mnt/512G ext3 errors=remount-ro 0 1" >> /etc/fstab```  
Перезагрузить и проверить монтирование  
Копирование на другой узел rsync   
```/usr/bin/rsync -vaz /home/DOCKER_BUILD/oxidized_docker-compose support@10.20.1.84:/tmp/```  
