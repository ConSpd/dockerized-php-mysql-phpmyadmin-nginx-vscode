#!/bin/bash

docker build -t myphp .

if [ $? -eq 0 ]; then
    echo "PHP image build completed successfully."
else
    echo "PHP image build failed."
    exit 1
fi

docker compose -f docker-compose.yaml up -d

while true; do
    if docker compose logs | grep -q "/usr/sbin/mysqld: ready for connections."; then
        echo "MySQL Service Started."
        break
    fi
        sleep 1
done

sleep 5
docker exec -it mysql-service sh -c "mysql -u root -ppassword -e 'GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost'; FLUSH PRIVILEGES;'"
docker exec -it mysql-service sh -c "mysql -u root -ppassword -e 'create database general_insurance;'"
docker exec -it mysql-service sh -c "mysql -u root -ppassword general_insurance < /docker-entrypoint-initdb.d/your.sql/general_insurance.sql" 
