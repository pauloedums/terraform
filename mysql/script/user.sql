CREATE USER IF NOT EXISTS 'terraform'@'%' IDENTIFIED BY 'terraform';

GRANT ALL PRIVILEGES ON terraform.* TO 'terraform'@'%' IDENTIFIED BY 'terraform';