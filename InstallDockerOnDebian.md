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
