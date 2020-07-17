### Установка docker на Debian
По мотивам https://docs.docker.com/install/linux/docker-ce/debian/  
```
sudo apt-get install -y curl
curl -fsSL https://get.docker.com -o get-docker.sh
sudo apt-get remove -y curl libcurl3
sudo sh get-docker.sh
```
### Установка docker-compose на Debian
```
sudo apt-get install -y curl
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo apt-get remove -y curl libcurl3
sudo chmod +x /usr/local/bin/docker-compose
```
### Изменить расположение docker data directory  
1. Stop the docker daemon
```
sudo service docker stop
```
2. Добавить в файл daemon.json (находится в /etc/docker), следующее содержимое:
```
{ 
   "graph": "/path/to/your/docker" 
}
```
заменив путь “/path/to/your/docker” на свой.  
3. Скопировать содержимое 
```
sudo rsync -aP /var/lib/docker/ /path/to/your/docker
```
4. Переименовать старый каталог   
```
sudo mv /var/lib/docker /var/lib/docker.old
```
5. Перестартовать docker daemon  
```
sudo service docker start
```
6. Тестировать
Если всё нормально - удалить старое местоположение  
```
sudo rm -rf /var/lib/docker.old
```
