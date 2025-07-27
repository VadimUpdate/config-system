-- Таблица setting
CREATE TABLE IF NOT EXISTS setting (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    default_value VARCHAR(255) NOT NULL
);

INSERT INTO setting (name, default_value)
SELECT name, default_value FROM (VALUES
    ('max_connections', '100'),
    ('enable_logging',  'true'),
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

-- Таблица setting_sbp
CREATE TABLE IF NOT EXISTS setting_sbp (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    value VARCHAR(255) NOT NULL
);

INSERT INTO setting_sbp (name, value)
SELECT name, value FROM (VALUES
    ('sbp_max_transactions', '500'),
    ('sbp_enable_reconciliation', 'true'),
    ('sbp_default_currency', 'USD'),
    ('sbp_api_endpoint', 'https://sbp.example.com/api'),
    ('sbp_timeout_seconds', '45'),
    ('sbp_retry_attempts', '3'),
    ('sbp_enable_notifications', 'false'),
    ('sbp_support_email', 'sbp-support@example.com'),
    ('sbp_max_daily_limit', '10000'),
    ('sbp_min_transaction_amount', '1'),
    ('sbp_transaction_fee_percent', '0.5'),
    ('sbp_enable_logging', 'true'),
    ('sbp_backup_enabled', 'false'),
    ('sbp_maintenance_mode', 'false'),
    ('sbp_theme', 'dark'),
    ('sbp_default_language', 'en'),
    ('sbp_session_timeout_minutes', '10'),
    ('sbp_show_tutorial', 'true'),
    ('sbp_items_per_page', '50'),
    ('sbp_enable_api_access', 'true')
) AS s(name, value)
WHERE NOT EXISTS (
    SELECT 1 FROM setting_sbp WHERE setting_sbp.name = s.name
);

-- Таблица users
CREATE TABLE IF NOT EXISTS users (
    id BIGSERIAL PRIMARY KEY,
    password VARCHAR(255) NOT NULL,
    username VARCHAR(255) NOT NULL UNIQUE,
    role VARCHAR(50) NOT NULL
    );

-- Пароль 123
INSERT INTO users (id, password, username, role)
VALUES (1, '$2a$10$/jMHh0q9QZ/4J7e4LJmVK.uX6DLHOZqY7Vp8bJ2nivfkWN4Tp7dsq', 'admin', 'ROLE_ADMIN')
    ON CONFLICT (id) DO NOTHING;
