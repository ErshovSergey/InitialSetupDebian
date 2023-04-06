Обновление

/etc/apt/sources.list

deb http://ftp.ru.debian.org/debian bullseye main contrib

deb http://ftp.ru.debian.org/debian bullseye-updates main contrib

# security updates
deb http://security.debian.org/debian-security bullseye-security main contrib non-free

Установить пакеты

apt install bash-completion sudo tmux qemu-guest-agent rsync

Окружение
добавить в /root/.bashrc содержимое файла

добавить в /root/.nanorc содержимое файла

Выключить ipv6 на узле

создать файл /etc/sysctl.d/disable-ipv6.conf

echo 'net.ipv6.conf.all.disable_ipv6 = 1' > /etc/sysctl.d/disable-ipv6.conf
echo 'net.ipv6.conf.default.disable_ipv6 = 1' >> /etc/sysctl.d/disable-ipv6.conf

Меняем часовой пояс

timedatectl set-timezone Europe/Moscow

Пользователь support

добавить пользователя support

adduser support

добавить права на переход в root - создать файл /etc/sudoers.d/support

mkdir -p /etc/sudoers.d && echo 'support ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/support


Установить сервер времени (для физичеких ПК)

в файле /etc/chrony/chrony.conf указать сервер времени

pool 10.1.1.254 iburst




Debian - как установить locale - en US.UTF-8

Debian - как установить locale - en US.UTF-8

sed -i "s/# ru_RU/ru_RU/" /etc/locale.gen
sed -i "s/# en_US/en_US/" /etc/locale.gen
locale-gen en_US.UTF-8 ru_RU.UTF-8
echo LANG=en_US.UTF-8 > /etc/default/locale
source /etc/default/locale

Проверяем результат:

locale

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

Сетевой интерфейс

Статический адрес на сетевом интерфейсе

/etc/network/interfaces

# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

/etc/network/interfaces.d/primary

# The primary network interface
auto ens18
allow-hotplug eth0
iface ens18 inet static
  address 10.C.B.A
  mask 255.255.D.0

Удалить файлы настроек "~*"

Роуты

Добавить роут по умолчанию

ip route add default via 10.20.0.1

Дополнительные роуты

Роут для все КСПД сетей добавить в /etc/network/interfaces

up ip route add 10.10.0.0/16 via 10.10.2.254

Перенаправление syslog на graylog2

Проверить доступность greylog2 командой (A.B.C.D заменить на адрес сервера)

echo "<1>Test UDP syslog message from \"$HOSTNAME\" " >> /dev/udp/A.B.C.D/6514

Создать файл /etc/rsyslog.d/remote-logging.conf

КСПД

echo '*.*  @10.1.32.210:6514' > /etc/rsyslog.d/remote-logging.conf

или

echo '*.*  @10.10.2.210:6514' > /etc/rsyslog.d/remote-logging.conf

yellow

echo '*.*  @10.2.0.210:6514' > /etc/rsyslog.d/remote-logging.conf

или

echo '*.*  @10.20.0.210:6514' > /etc/rsyslog.d/remote-logging.conf

Перезапустить rsyslog

service rsyslog restart

Настройка docker

В отдельной статье.

Установка агента FusionInventory(агент glpi)

В отдельной статье.

Установка агента zabbix

В отдельной статье.

Debian - systemd-timesyncd

В отдельной статье.

Настройка использования SWAP

Появилось после ухода в SWAP на хостах Proxmox.

По умолчанию при заполнении оперативной памяти на 60% и более начинает использоваться swap.

Проверить текущее значение

sysctl vm.swappiness

или

cat /proc/sys/vm/swappiness

Чтобы изменить процент сейчас:

sysctl -w vm.swappiness=10

Чтобы изменить процент после перезагрузки:

echo 'vm.swappiness = 10' >> /etc/sysctl.conf


что добавит в конец файла, где 10 - процент заполнения оперативной памяти
vm.swappiness = 10

Применить без перезагрузки

sysctl --load

sysctl --system

но лучше перезагрузить

Ссылки: [1], [2].

Добавление диска для данных
добавить диск физически или в ВМ
проверить подключение и узнать логическое имя диск

 fdisk -l

разметить весь диск как primary

fdisk /dev/sdb

m n p w

Форматирование диска

mkfs.ext3 /dev/sdb1

Создаем точку монтирования

mkdir /mnt/512G

chmod -R 660 /mnt/512G

Монитруем

mount /dev/sdb1 /mnt/512G

узнать UUID

blkid

добавить монтирование диска в /etc/fstab

echo "UUID=ca601d12-18d8-47dd-9a9e-9f735e8ffc3a /mnt/512G ext3 errors=remount-ro 0 1" >> /etc/fstab

Перезагрузить и проверить монтирование
Копирование на другой узел rsync

/usr/bin/rsync -vaz /home/DOCKER_BUILD/oxidized_docker-compose support@10.20.1.84:/tmp/
