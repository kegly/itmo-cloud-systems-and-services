
# Лабораторная работа №3 *

### Задание

Создать helm chart на основе обычной 3 лабы
Задеплоить его в кластер
Поменять что-то в сервисе, задеплоить новую версию при помощи апгрейда релиза
В отчете приложить скрины всего процесса, все использованные файлы, а также привести три причины, по которым использовать хелм удобнее чем классический деплой через кубернетес манифесты




### Ход работы
#### 1. Поднятие кластера - minikube start

![image](https://github.com/kegly/itmo-cloud-systems-and-services/blob/main/lab3/images/Screenshot%20from%202024-10-15%2004-45-56.png)


#### 2. Создание helm чарта  и редактирование 

![image](https://github.com/kegly/itmo-cloud-systems-and-services/blob/main/lab3*/images/1.png)

values.yaml :

![image](https://github.com/kegly/itmo-cloud-systems-and-services/blob/main/lab3*/images/2.png)

service.yaml :

![image](https://github.com/kegly/itmo-cloud-systems-and-services/blob/main/lab3*/images/5.png)

#### 3. Изменение приложения

![image](https://github.com/kegly/itmo-cloud-systems-and-services/blob/main/lab3*/images/3.png)

#### 4. Обновление приложения


![image](https://github.com/kegly/itmo-cloud-systems-and-services/blob/main/lab3*/images/4.png)

Задеплоенный сервис в Lens :

![image](https://github.com/user-attachments/assets/3690f73d-96ed-478f-8ab0-1f32cbd60732)
