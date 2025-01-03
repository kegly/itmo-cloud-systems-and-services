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


```sh
FROM ubuntu:20.04
RUN apt-get update && apt-get install -y python3 python3-pip python3-venv


COPY app.py /app.py 
COPY requirements.txt /requirements.txt




RUN python3 -m venv /venv


ENV PATH="/venv/bin:$PATH"


RUN pip install --no-cache-dir -r requirements.txt


ENV EXAMPLE example


EXPOSE 80


CMD ["python", "/app.py"]



```

 Время билда и размер образа уменьшились

![image](https://github.com/kegly/itmo-cloud-systems-and-services/blob/main/lab2/images/Screenshot%20from%202024-10-15%2003-48-01.png)




#### 3. Сравнение и анализ


##### 1. Неправильное использование нескольких FROM

Почему плохо:  Docker интерпретирует только последний FROM
Как было исправлено: было оставлено только FROM ubuntu
Влияние на результат: скрипт более понятен


##### 2. Определение переменной окружения и окрытие порта в начале файла

Почему плохо: если переменные поменяются, то будет ребилд всего написанного ниже
Как было исправлено: добавлено в конце
Влияние на результат: при изменении переменной окружения или порта билд выполняется быстро


##### 3. Обновление системы upgrade; update и install в разных строчках

Почему плохо: обновление системы приводит к нестабильности, а если разделить update и install, то update закешируется и не будет выполнять каждый раз когда нужно выполнить команду install
Как было исправлено: upgrade не делается, а update и install в одну строчку
Влияние на результат: система стабильна, а update не кешируется


##### 4. Копирование приложения c помощью  ADD вместо COPY


Почему плохо:  Команда ADD имеет дополнительные функции (например, распаковка архивов), поэтому ее поведение непредсказуемо
Как было исправлено: замена на COPY
Влияние на результат: скрипт более предсказуем


 ##### 4. Неявная установка зависимостей + без указания версии 


Почему плохо:  Не указывание версии ведет к неконсистенстности среды приложения, а неявная установка ухудшает читабельность 
Как было исправлено: использование VENV +  файла с зависимостями 
Влияние на результат: скрипт гарантирует консистентность; было облегчено управление зависимостями 




#### 4.  Плохие практики по работе с контейнерами
##### 1. Отсутствие контроля за ресурсами
необходимо проверять что потребление ресурсов обосновано
также ресурсы можно ограничивать при запуске контейнера с помощью флагов
##### 2. Запускание контейнеров от рута
Это создает уязвимость в безовасности
