#!/bin/bash

sudo apt-get install -y postgresql postgresql-contrib libpq-dev;
sudo su - postgres;
createuser --pwprompt ubuntu;
createdb -O ubuntu m2_carts;
exit;

#para probar o jugar
sudo -i -u postgres