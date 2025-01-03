# **Лабораторная работа №4: CI/CD**

## **Описание**

Для выполнения лабораторной работы использовался **GitLab** CI/CD.  
![image](https://github.com/user-attachments/assets/18824875-5c5c-4db6-ad39-0b926f719c82)

В рамках работы разработаны два пайплайна для простого проекта на Python:  

1. **"Плохой" файл CI/CD** — содержит пять распространенных ошибок ("bad practices") в настройке CI/CD.  
2. **"Хороший" файл CI/CD** — исправления ошибок, направленные на повышение надежности, безопасности и читаемости пайплайна.  

---

## **"Плохой" файл CI/CD**
```yaml
stages:
  - setup
  - install
  - test
  - deploy

setup_environment:
  stage: setup
  script:
    - echo "Setting up environment..."
    - apt-get update && apt-get upgrade -y 
    - apt-get install python3 

install_dependencies:
  stage: install
  image: python:3.8
  script:
    - pip install -r requirements.txt exit 0  

run_tests:
  stage: test
  image: python:3.8
  script:
    - pip install pytest
    - pytest my_simple_project/test_app.py echo "Tests failed, but continuing..." 

deploy_application:
  stage: deploy
  script:
    - echo "Deploying application..."
    - echo "export API_KEY=super_secret_key" >> ~/.bashrc

cleanup:
  stage: deploy
  script:
    - rm -rf /builds || true
```
## **"Хороший" файл CI/CD**
```yaml
stages:
  - install
  - test
  - deploy

install_dependencies:
  stage: install
  image: python:3.8
  script:
    - pip install --upgrade pip  
    - pip install -r requirements.txt 

run_tests:
  stage: test
  image: python:3.8
  script:
    - pip install pytest 
    - pytest my_simple_project/test_app.py  
  allow_failure: false  

deploy_application:
  stage: deploy
  script:
    - echo "Deploying application..."
  only:
    - main
```
## **Ошибки "плохого" файла и их исправления**

## **1. Установка системных пакетов в CI/CD**
- **Ошибка:**  
  Выполнялась команда `apt-get update && apt-get upgrade -y` и установка Python через `apt-get install python3`, что избыточно при использовании Docker-образа с предустановленным окружением.  
- **Исправление:**  
  Удален этап `setup`, так как Python уже предустановлен в образе.  
- **Результат:**  
  Сокращено время выполнения пайплайна и исключены ошибки обновления системы.

---

## **2. Игнорирование ошибок установки зависимостей**
- **Ошибка:**  
  Использовалась команда `pip install -r requirements.txt exit 0`, игнорирующая ошибки установки зависимостей.  
- **Исправление:**  
  Удалено подавление ошибок. Пайплайн останавливается, если зависимости не установлены.  
- **Результат:**  
  Повышена надежность установки зависимостей.

---

## **3. Продолжение выполнения при провале тестов**
- **Ошибка:**  
  При провале тестов пайплайн продолжал выполнение этапа деплоя.  
- **Исправление:**  
  Установлен параметр `allow_failure: false`. Пайплайн останавливается, если тесты не пройдены.  
- **Результат:**  
  Исключена возможность деплоя некорректного кода.

---

## **4. Небезопасное хранение ключей**
- **Ошибка:**  
  Секретный ключ сохранялся в `.bashrc`, что может привести к его утечке.  
- **Исправление:**  
  Удалено использование ключей в пайплайне. Для реальных проектов ключи рекомендуется хранить в защищенных переменных.  
- **Результат:**  
  Повышена безопасность пайплайна.

---

## **5. Опасное удаление файлов**
- **Ошибка:**  
  Команда `rm -rf /builds || true` могла удалить все данные в CI/CD runner.  
- **Исправление:**  
  Удален этап `cleanup`, так как он не нужен в проекте.  
- **Результат:**  
  Исключен риск случайного удаления данных.

---

## **Тестирование плохого CI/CD:**
![image](https://github.com/user-attachments/assets/49799859-6ca9-444c-988f-bbdcacc1b74c)

## **Тестирование хорошего CI/CD:**
![image](https://github.com/user-attachments/assets/7d427c79-26b0-413f-a954-65f10cd85b98)

---

## **Результаты**

Исправления позволили:  
1. **Сократить время выполнения пайплайна** за счет удаления ненужных этапов.  
2. **Повысить надежность пайплайна**, добавив остановку при ошибках.  
3. **Сделать процесс деплоя безопасным**, убрав небезопасные действия с ключами.  
4. **Упростить код пайплайна**, оставив только необходимые шаги.

