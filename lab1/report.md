# Лабораторная работа №1 

### Задание
Настроить nginx по заданному тз:

  1.Должен работать по https c сертификатом
  
  2.Настроить принудительное перенаправление HTTP-запросов (порт 80) на HTTPS (порт 443) для обеспечения безопасного соединения.
  
  3.Использовать alias для создания псевдонимов путей к файлам или каталогам на сервере.
  
  4.Настроить виртуальные хосты для обслуживания нескольких доменных имен на одном сервере.
  
  5.Что угодно еще под требования проекта

### Ход работы
###### 1.  Покупка доменов
![image](https://github.com/kegly/itmo-cloud-systems-and-services/blob/main/lab1/images/Screenshot%20from%202024-10-14%2021-05-12.png)
###### 2.  Настройка DNS records 
![image](https://github.com/kegly/itmo-cloud-systems-and-services/blob/main/lab1/images/Screenshot%20from%202024-10-14%2021-06-03.png)

###### 3.  Контейнеризация приложения
В качестве приложения выбрано небольшое приложение с гайда для экономии времени.

![image](https://github.com/kegly/itmo-cloud-systems-and-services/blob/main/lab1/images/Screenshot%20from%202024-10-14%2021-15-21.png)

Написан стандартный Dockerfile 

![image](https://github.com/kegly/itmo-cloud-systems-and-services/blob/main/lab1/images/Screenshot%20from%202024-10-14%2021-22-11.png)

И docker-compose.yml 
![image](https://github.com/kegly/itmo-cloud-systems-and-services/blob/main/lab1/images/Screenshot%20from%202024-10-14%2021-49-32.png)


###### 4.  Настройка Nginx для двух доменов + alias
в серверном блоке написано перенаправление на порт 8080 на котором запущено приложение в докере

для alias написаны небольшие html скрипты и в конфиге nginx alias location /index/  

![image](https://github.com/kegly/itmo-cloud-systems-and-services/blob/main/lab1/images/Screenshot%20from%202024-10-14%2023-10-10.png)

![image](https://github.com/kegly/itmo-cloud-systems-and-services/blob/main/lab1/images/Screenshot%20from%202024-10-14%2023-10-21.png)

![image](https://github.com/kegly/itmo-cloud-systems-and-services/blob/main/lab1/images/Screenshot%20from%202024-10-14%2023-13-04.png)

###### 5.  HTTPS
![image](https://github.com/kegly/itmo-cloud-systems-and-services/blob/main/lab1/images/Screenshot%20from%202024-10-14%2023-13-17.png)

сертификаты получены с помощью Let's Encrypt
по статье: 
https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-ubuntu-20-04
