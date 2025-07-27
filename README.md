# config-system

Админ-консоль для управления конфигурационными настройками и пользователями.  
Реализована на Spring Boot (backend) и React (frontend). Использует PostgreSQL, JWT-аутентификацию и Docker-контейнеры.

Проект — это админ-консоль с разделением настроек на обычные и SBP-настройки, с аутентификацией через JWT. Центральное управление конфигурациями обеспечивается через Config Server и Config Client.  

Поддерживается работа в Docker с полным стеком: база данных, backend, frontend, конфиг-сервер и конфиг-клиент.

---

## Технологии

- Backend: Kotlin + Spring Boot, Spring Security, JWT  
- Frontend: React, axios, React Router  
- База данных: PostgreSQL  
- Контейнеризация: Docker, Docker Compose  
- Nginx для проксирования и CORS  

---

## Установка и запуск

### 1. Клонировать репозиторий с сабмодулями

git clone --recurse-submodules https://github.com/VadimUpdate/config-system.git
cd config-system

2. Собрать backend-сабмодули
Для каждого сабмодуля выполнить:

cd admin-console
./gradlew bootJar
cd ..

cd config-server
./gradlew bootJar
cd ..

cd config-client
./gradlew bootJar
cd ..

3. Собрать frontend

cd admin-console/frontend
npm install
npm run build
cd ../..

4. Запустить все сервисы в Docker

docker-compose up --build

Учетные данные по умолчанию

Для удобства тестирования в системе есть пользователь с ролью администратора:

Логин: admin

Пароль: 123

Тестирование конфигураций
Для проверки текущих значений конфигурационных параметров можно перейти по адресу:
http://localhost:8081/test

Там отображаются настройки, такие как max_connections и enableLogging.
Они должны обновляться каждые 15 секунд при внесении изменений.
