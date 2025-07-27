-- Create the main database
CREATE DATABASE IF NOT EXISTS synclecta CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Create a user for the application
CREATE USER IF NOT EXISTS 'synclecta'@'%' IDENTIFIED BY 'secret';
GRANT ALL PRIVILEGES ON synclecta.* TO 'synclecta'@'%';

-- Create databases for multi-tenancy (example tenants)
CREATE DATABASE IF NOT EXISTS tenant_1 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS tenant_2 CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Grant privileges to tenant databases
GRANT ALL PRIVILEGES ON tenant_1.* TO 'synclecta'@'%';
GRANT ALL PRIVILEGES ON tenant_2.* TO 'synclecta'@'%';

FLUSH PRIVILEGES; 