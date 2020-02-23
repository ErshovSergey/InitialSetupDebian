
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
##### Using snap  
```
# Mozilla provides an official Snap package for Firefox: 
sudo apt install snapd
sudo snap install firefox
snap run firefox
```

### Устраннение ошибки *W: Possible missing firmware /lib/firmware/i915/kbl_dmc_ver1_01.bin for module i915*  
Необходимо подключить репозиторий nonfree  
```
apt-get install firmware-misc-nonfree
update-initramfs -um'
```
### Дополнительные пакеты для установки
##### Подсчет занимаемого пространства
apt-get install ncdu — визуализация занимаемого места  
apt-get install bash-completion - 
apt-get install cmatrix

### Подсказки
https://cht.sh/wget
