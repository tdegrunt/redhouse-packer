#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

# NodeJS
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
apt-get install -y nodejs
/usr/bin/npm install -g npm
/usr/bin/npm install -g yarn

# Postgres
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" |sudo tee  /etc/apt/sources.list.d/pgdg.list
sudo apt update
sudo apt install -y postgresql-12 postgresql-client-12

# Configure Postgres Remote Access
sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/12/main/postgresql.conf
echo "host    all             all             10.0.2.2/32               md5" | tee -a /etc/postgresql/12/main/pg_hba.conf
sudo -u postgres psql -c "CREATE ROLE redhouse LOGIN PASSWORD 'overyonder' SUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;"
sudo -u postgres psql -c "CREATE ROLE vagrant LOGIN SUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;"
sudo -u postgres /usr/bin/createdb --echo --owner=redhouse redhouse
service postgresql restart

# Other services & tools
apt-get -y install nginx sqlite3 libsqlite3-dev redis influxdb influxdb-client libpq-dev

# Final package update
apt-get -y update
apt-get -y upgrade
