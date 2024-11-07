# Лабораторная работа №5

### Задание

Сделать мониторинг сервиса, поднятого в кубере (использовать, например, prometheus и grafana). Показать хотя бы два рабочих графика, которые будут отражать состояние системы. Приложить скриншоты всего процесса настройки.



### Ход работы
#### 1. Скачивание Lens Desktop для удобства работы с minikube

![image](https://github.com/kegly/itmo-cloud-systems-and-services/blob/main/lab5/images/Screenshot%20from%202024-11-07%2019-03-02.png)


#### 2. Установка helm chart-ов для Prometheus и Grafana
```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install prometheus prometheus-community/prometheus
kubectl expose service prometheus-server --type=NodePort --target-port=9090 --name=prometheus-server-np
helm repo add grafana https://grafana.github.io/helm-charts
helm install grafana grafana/grafana
kubectl expose service grafana --type=NodePort --target-port=3000 --name=grafana-np
kubectl get secret --namespace default grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```
Видим что все поды поднялись

![image](https://github.com/kegly/itmo-cloud-systems-and-services/blob/main/lab5/images/Screenshot%20from%202024-11-07%2019-10-55.png)
#### 3. Подключение Grafana к Prometheus

Добавляем новое соединение и источником (data source) - Prometheus

в качестве адреса - http://my-prometheus-server.default.svc.cluster.local

![image](https://github.com/kegly/itmo-cloud-systems-and-services/blob/main/lab5/images/Screenshot%20from%202024-11-07%2019-15-00.png)

#### 4. Добавление графиков в Dashboard

![image](https://github.com/kegly/itmo-cloud-systems-and-services/blob/main/lab5/images/Screenshot%20from%202024-11-07%2019-19-04.png)
