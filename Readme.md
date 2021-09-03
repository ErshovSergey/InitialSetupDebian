
### Изменить порт ssh на отличный от 22  
В файле */etc/ssh/sshd_config* ищем строку, если закомментирована - раскомметируем 
```
Port 22
```
и меняем *22* на любой другой порт.  
Перезапускаем ssh  
```
service ssh restart
```
Проверяем доступность на другой консоли.  

### Запрещаем удаленный вход root  
#### Добавляем нового пользователя  
```
useradd --create-home --gid  UserName
```
Устанавливаем пароль для нового пользователя  
```
passwd UserName
```
Дополнительно можно установить sudo  
```
apt-get install sudo
```
Добавить файл */etc/sudoers.d/UserName* следующего содержания для запуска sudo без пароля  
```
UserName ALL=(ALL) NOPASSWD:ALL
```
или с паролем  
 UserName ALL=(ALL) ALL:ALL
Добавить пользователя в группу sudo  
```
usermod -a -G sudo UserName
```
#### Запрещаем вход root  
В файле */etc/ssh/sshd_config* ищем строку  
```
PermitRootLogin yes
```
и меняем на  
```
PermitRootLogin no
```
Перезапускаем ssh.  
```
service ssh restart
```
Проверяем доступность на другой консоли.  
### Авторизацию в ssh по по ключу
Утилитой PuTTYgen сгенерируем публичный и приватный ключ.  
Открываем утилиту и нажимаем Generate    
Создаем каталог для ключей  
```
mkdir .ssh
```
Помещаем в файл *.ssh/authorized_keys* публичный ключ.  
Проверяем доступность на другой консоли.
### Раскрашиваем top  
- необходимо запустить top
- последовательно нажать (латинские буквы)
```
A z az az az
```
##### Команды:  
```
W - сохранить настройки в файл (в файл  ~/.toprc)
 x - подсветить столбец по которому идет сортировка
 < или > - поменять сортировку
 x - перейтив другое окно
 V - в виде дерева
 1 - загрузка по ядрам
 t - по кругу переключает вид строки обобщённой информации об использовании процессора
 c - показать команду запуска с опциями
``` 
##### По мотивам
- https://habr.com/ru/company/cloud4y/blog/469487/
- https://zalinux.ru/?p=1811

### Установка Firefox более новой версии чем ESR  
По мотивам https://wiki.debian.org/Firefox
##### youtube-dl-gui - скачивание с youtube
устанавливаем из под пользователя
http://ppa.launchpad.net/nilarimogard/webupd8/ubuntu/pool/main/y/youtube-dlg/

##### Using snap  
```
# Mozilla provides an official Snap package for Firefox: 
sudo apt install snapd
sudo snap install firefox
install libreoffice
snap run firefox
```
##### YouTube-DL GUI
snap install youtube-dl-pro
После установки надо изменить ярлык запуска, иначе не запускается при использовании wayland.
Изменить можно с помощью Alacarte
```sudo apt-get install alacarte```
Далее с помощью alacarte добавить в ярлык запуска параметр
```DISABLE_WAYLAND=1```, вставлять  после env.

##### youtube-dl-gui
Оф.сайт [youtube-dl-gui](https://mrs0m30n3.github.io/youtube-dl-gui/)  
Установка:  
- скачать 
```wget http://ppa.launchpad.net/nilarimogard/webupd8/ubuntu/pool/main/y/youtube-dlg/youtube-dlg_0.4-1~webupd8~zesty4_all.deb```  
- установить  
```dpkg -i youtube-dlg_0.4-1~webupd8~zesty4_all.deb```  
- - для установки в debian 11 необходим python-wxgtk3.0, который есть в debian 10.
добавляем в _/etc/apt/sources.list_ строки  
   ```deb http://deb.debian.org/debian buster  main contrib non-free```  
   Выполнить команды и снова попробовать установить  
   ``` apt-get -t buster install python-wxgtk3.0```  
   ```apt-get update```  
   ```apt --fix-broken install```  

### Блокировка рекламы в Firefox с помощью ublock origin (https://github.com/gorhill/uBlock)  
[uBlockOrigin](./uBlockOrigin.md)  

### Устраннение ошибки *W: Possible missing firmware /lib/firmware/i915/kbl_dmc_ver1_01.bin for module i915*  
Необходимо подключить репозиторий nonfree  
```
apt-get install firmware-misc-nonfree
update-initramfs -um'
```
### Устраннение ошибки *[Firmware Bug]: TSC_DEADLINE disabled due to Errata; please update microcode to version: 0x52 (or later)*    
```sudo apt-get install intel-microcode```  
### Дополнительные пакеты для установки
##### Подсчет занимаемого пространства
apt-get install ncdu — визуализация занимаемого места  
apt-get install bash-completion - 
apt-get install cmatrix

### Подсказки
https://cht.sh/wget

### Руссицикация - переключение раскладки через Capslock  
``` gsettings set org.gnome.desktop.input-sources xkb-options "['grp:caps_toggle']" ```

### Автоматические обновления безопасности - Unattended Upgrades  
#### Устанавливаем пакет  
```
apt-get install unattended-upgrades
```
#### Создаем конфигурационный файл, для этого запускаем интерактивное меню для настройки  
```
dpkg-reconfigure  unattended-upgrades
```
#### Включение репорта по почте  
В файле */etc/apt/apt.conf.d/02periodic* строку   
```
//Unattended-Upgrade::Mail "root";
```
на  
```
Unattended-Upgrade::Mail "replacewithyouremail";
``` 
#### Запустить для отладки  
```
unattended-upgrades --dry-run --debug
```

