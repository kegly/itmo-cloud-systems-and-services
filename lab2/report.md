# Лабораторная работа №2

### Задание

1.Написать “плохой” Dockerfile, в котором есть не менее трех “bad practices” по написанию докерфайлов

2.Написать “хороший” Dockerfile, в котором эти плохие практики исправлены

3.В Readme описать каждую из плохих практик в плохом докерфайле, почему она плохая и как в хорошем она была исправлена, как исправление повлияло на результат

4.В Readme описать 2 плохих практики по работе с контейнерами. ! Не по написанию докерфайлов, а о том, как даже используя хороший докерфайл можно накосячить именно в работе с контейнерами.


### Ход работы
#### 1. Написание плохого Dockerfile
```sh 
FROM ubuntu:latest 
FROM python:latest 
# !!Неправильное использование нескольких FROM


# Определение переменной окружения
ENV EXAMPLE example 
# !!должно быть в конце файла


# Открытие порта
EXPOSE 80
# !!должно быть в конце файла


# Установка зависимостей
RUN  apt-get upgrade -y 
# !!Использование обновления всех пакетов -> нестабильность
RUN apt-get update
RUN apt-get install -y python3-pip
# !!update и install  в разных строчках


# Копирование приложения
ADD app.py /app.py 
# !!Использование ADD вместо COPY


# Установка зависимостей Python
RUN pip install flask 
# !!Неявная установка зависимостей




# Запуск приложения
CMD ["python", "/app.py"]
```


Билд занял 241 секунду
![image](https://github.com/kegly/itmo-cloud-systems-and-services/blob/main/lab2/images/Screenshot%20from%202024-10-15%2003-27-56.png)

Запускаем контейнер:
![image](https://github.com/kegly/itmo-cloud-systems-and-services/blob/main/lab2/images/Screenshot%20from%202024-10-15%2003-30-54.png)

Размер образа:
![image](https://github.com/kegly/itmo-cloud-systems-and-services/blob/main/lab2/images/Screenshot%20from%202024-10-15%2003-36-55.png)


#### 2. Написание хорошего Dockerfile
