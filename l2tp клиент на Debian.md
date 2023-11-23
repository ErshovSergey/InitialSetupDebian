### Настройка клиента l2tp+ipsec на Debian  
На Debian  
устанавливаем  
```sudo apt install network-manager-l2tp-gnome```  
*Параметры\Сеть* добавляем подключение по VPN  
Указываем *Название*, *Имя пользователя*, *Пароль*.  
В *Настройка IPsec* включаем *Enable IPsec tunnel to L2TP host*, 
указываем *Общие\Pre-shared key*  
*Advanced\Phase1Algoritms:* _3des-sha1-modp1024_  
*Advanced\Phase2Algoritms:* _3des-sha1_  
