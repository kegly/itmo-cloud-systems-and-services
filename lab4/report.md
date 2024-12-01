# **Лабораторная работа №4: CI/CD**

## **Описание**

Для выполнения лабораторной работы использовался **GitLab** CI/CD.  
В рамках работы разработаны два пайплайна:  

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

cleanup:
  stage: deploy
  script:
    - rm -rf /builds || true  # Рекурсивное удаление, которое может уничтожить всё в CI/CD runner

