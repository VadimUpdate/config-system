-- Таблица setting
CREATE TABLE IF NOT EXISTS setting (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    default_value VARCHAR(255) NOT NULL
);

-- Вставка настроек (если таблица пустая)
INSERT INTO setting (name, default_value)
SELECT name, default_value FROM (VALUES
    ('max_connections', '100'),
    ('enable_logging', 'true'),
    ('welcome_message', 'Добро пожаловать!'),
    ('timeout_seconds', '30'),
    ('enable_feature_x', 'false'),
    ('min_password_length', '8'),
    ('support_email', 'support@example.com'),
    ('max_upload_size', '50'),
    ('maintenance_mode', 'false'),
    ('date_format', 'dd.MM.yyyy'),
    ('enable_notifications', 'true'),
    ('currency', 'RUB'),
    ('default_language', 'ru'),
    ('items_per_page', '20'),
    ('api_access_enabled', 'true'),
    ('session_timeout_minutes', '15'),
    ('show_tutorial', 'false'),
    ('backup_enabled', 'true'),
    ('theme', 'light'),
    ('max_login_attempts', '5')
) AS s(name, default_value)
WHERE NOT EXISTS (
    SELECT 1 FROM setting WHERE setting.name = s.name
);

-- Таблица users
CREATE TABLE IF NOT EXISTS users (
    id BIGSERIAL PRIMARY KEY,
    password VARCHAR(255) NOT NULL,
    username VARCHAR(255) NOT NULL UNIQUE,
    role VARCHAR(50) NOT NULL
);

-- Вставка пользователя test1 (если ещё нет)
INSERT INTO users (password, username, role)
VALUES ('$2a$10$/jMHh0q9QZ/4J7e4LJmVK.uX6DLHOZqY7Vp8bJ2nivfkWN4Tp7dsq', 'test1', 'ROLE_USER')
    ON CONFLICT (username) DO NOTHING;

-- Убедимся, что есть пользователь с id = 24
INSERT INTO users (id, password, username, role)
VALUES (24, 'stub-password', 'user24', 'ROLE_USER')
    ON CONFLICT (id) DO NOTHING;

-- Таблица user_setting_value
CREATE TABLE IF NOT EXISTS user_setting_value (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    setting_id BIGINT NOT NULL REFERENCES setting(id) ON DELETE CASCADE,
    value VARCHAR(255) NOT NULL
);

-- Вставка настроек для пользователя 24, который может менять значения
INSERT INTO user_setting_value (user_id, setting_id, value)
SELECT
    24,
    s.id,
    s.default_value
FROM setting s
WHERE NOT EXISTS (
    SELECT 1 FROM user_setting_value usv
    WHERE usv.user_id = 24 AND usv.setting_id = s.id
);
