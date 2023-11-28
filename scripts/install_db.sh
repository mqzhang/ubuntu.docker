#!/usr/bin/env bash

apt-get -y install sqlite3 libsqlite3-dev \
    redis-server \
    postgresql postgresql-contrib libpq-dev

service redis-server start
service postgresql start

cd /tmp
sudo -u postgres createuser --superuser vagrant
sudo -u postgres bash -c "psql -c \"CREATE ROLE pg SUPERUSER LOGIN PASSWORD 'password';\""
# sudo -u postgres createdb -O vagrant -E UTF8 -T template0 activerecord_unittest
# sudo -u postgres createdb -O vagrant -E UTF8 -T template0 activerecord_unittest2
cd -

# debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
# debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
# install MySQL mysql-server libmysqlclient-dev libssl-dev
# # Set the password in an environment variable to avoid the warning issued if set with `-p`.
# MYSQL_PWD=root mysql -uroot <<SQL
# CREATE USER 'rails'@'localhost';
# CREATE DATABASE activerecord_unittest  DEFAULT CHARACTER SET utf8mb4;
# CREATE DATABASE activerecord_unittest2 DEFAULT CHARACTER SET utf8mb4;
# GRANT ALL PRIVILEGES ON activerecord_unittest.* to 'rails'@'localhost';
# GRANT ALL PRIVILEGES ON activerecord_unittest2.* to 'rails'@'localhost';
# GRANT ALL PRIVILEGES ON inexistent_activerecord_unittest.* to 'rails'@'localhost';
# SQL