Описание сущностей базы данных
1. Users (Пользователи)

Описание: Хранит информацию о пользователях системы.
Поля:
user_id (INTEGER, PRIMARY KEY, NOT NULL): Уникальный идентификатор пользователя.
email (VARCHAR(255), UNIQUE, NOT NULL): Электронная почта.
password_hash (VARCHAR(255), NOT NULL): Хэш пароля.
first_name (VARCHAR(50)): Имя.
last_name (VARCHAR(50)): Фамилия.
role_id (INTEGER, FOREIGN KEY -> Roles(role_id)): Ссылка на роль.


Связи:
Один ко многим с Roles (одна роль для многих пользователей).
Один ко многим с Bookings (один пользователь может иметь много бронирований).
Один ко многим с Logs (один пользователь может иметь много логов).



2. Roles (Роли)

Описание: Хранит роли пользователей (Администратор, Сотрудник, Клиент).
Поля:
role_id (INTEGER, PRIMARY KEY, NOT NULL): Уникальный идентификатор роли.
role_name (VARCHAR(50), NOT NULL): Название роли.


Связи:
Один ко многим с Users (одна роль для многих пользователей).



3. Studios (Студии)

Описание: Хранит информацию о студиях для записи.
Поля:
studio_id (INTEGER, PRIMARY KEY, NOT NULL): Уникальный идентификатор студии.
name (VARCHAR(100), NOT NULL): Название студии.
description (TEXT): Описание студии.
capacity (INTEGER): Вместимость.


Связи:
Один ко многим с Bookings (одна студия может быть забронирована многократно).



4. Equipment (Оборудование)

Описание: Хранит информацию об оборудовании студии.
Поля:
equipment_id (INTEGER, PRIMARY KEY, NOT NULL): Уникальный идентификатор оборудования.
name (VARCHAR(100), NOT NULL): Название оборудования.
type (VARCHAR(50)): Тип оборудования (например, микрофон, гитара).
is_available (BOOLEAN, NOT NULL): Доступность.


Связи:
Многие ко многим с Bookings через промежуточную таблицу Booking_Equipment.



5. Bookings (Бронирования)

Описание: Хранит информацию о бронированиях студийного времени.
Поля:
booking_id (INTEGER, PRIMARY KEY, NOT NULL): Уникальный идентификатор бронирования.
user_id (INTEGER, FOREIGN KEY -> Users(user_id)): Ссылка на клиента.
studio_id (INTEGER, FOREIGN KEY -> Studios(studio_id)): Ссылка на студию.
start_time (DATETIME, NOT NULL): Время начала.
end_time (DATETIME, NOT NULL): Время окончания.
total_cost (DECIMAL(10,2)): Стоимость бронирования.


Связи:
Один ко многим с Users (один пользователь может иметь много бронирований).
Один ко многим с Studios (одна студия может быть забронирована многократно).
Многие ко многим с Equipment через Booking_Equipment.



6. Booking_Equipment (Промежуточная таблица для бронирования оборудования)

Описание: Связывает бронирования и оборудование.
Поля:
booking_id (INTEGER, FOREIGN KEY -> Bookings(booking_id)): Ссылка на бронирование.
equipment_id (INTEGER, FOREIGN KEY -> Equipment(equipment_id)): Ссылка на оборудование.


Связи:
Многие ко многим между Bookings и Equipment.



7. Tracks (Треки)

Описание: Хранит информацию о записанных треках.
Поля:
track_id (INTEGER, PRIMARY KEY, NOT NULL): Уникальный идентификатор трека.
title (VARCHAR(100), NOT NULL): Название трека.
genre (VARCHAR(50)): Жанр.
duration (INTEGER): Длительность в секундах.
user_id (INTEGER, FOREIGN KEY -> Users(user_id)): Ссылка на клиента.
booking_id (INTEGER, FOREIGN KEY -> Bookings(booking_id)): Ссылка на бронирование.


Связи:
Один ко многим с Users (один пользователь может записать много треков).
Один ко одному с Bookings (один трек связан с одним бронированием).



8. Payments (Платежи)

Описание: Хранит информацию о платежах.
Поля:
payment_id (INTEGER, PRIMARY KEY, NOT NULL): Уникальный идентификатор платежа.
booking_id (INTEGER, FOREIGN KEY -> Bookings(booking_id)): Ссылка на бронирование.
amount (DECIMAL(10,2), NOT NULL): Сумма платежа.
payment_date (DATETIME, NOT NULL): Дата платежа.


Связи:
Один ко многим с Bookings (одно бронирование может иметь несколько платежей).



9. Logs (Журнал действий)

Описание: Хранит логи действий пользователей.
Поля:
log_id (INTEGER, PRIMARY KEY, NOT NULL): Уникальный идентификатор лога.
user_id (INTEGER, FOREIGN KEY -> Users(user_id)): Ссылка на пользователя.
action (VARCHAR(255), NOT NULL): Описание действия.
action_time (DATETIME, NOT NULL): Время действия.


Связи:
Один ко многим с Users (один пользователь может иметь много логов).



10. Genres (Жанры)

Описание: Хранит музыкальные жанры для треков.
Поля:
genre_id (INTEGER, PRIMARY KEY, NOT NULL): Уникальный идентификатор жанра.
name (VARCHAR(50), NOT NULL): Название жанра.


Связи:
Один ко многим с Tracks (один жанр может быть у многих треков).



Типы связей

Один к одному: Tracks — Bookings (один трек связан с одним бронированием).
Один ко многим: Users — Bookings, Studios — Bookings, Roles — Users, Users — Logs, Bookings — Payments, Genres — Tracks.
Многие ко многим: Bookings — Equipment через Booking_Equipment.
