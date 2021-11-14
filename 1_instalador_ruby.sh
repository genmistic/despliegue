#!/bin/bash
echo "CONFIGURANDO PAQUETES YARN Y NODEJS 😮"
sudo apt install curl;
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -;
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -;
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list;

echo "INSTALANDO DEPENDENCIAS PARA RBENV 🤐"
sudo apt-get update;
sudo apt-get install -y git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev nodejs yarn libpq-dev;

echo "COMENZANDO INSTALACIÓN RBENV 🙂"
cd;
git clone https://github.com/rbenv/rbenv.git ~/.rbenv;
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc;
echo 'eval "$(rbenv init -)"' >> ~/.bashrc;
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build;
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc;
git clone https://github.com/rbenv/rbenv-vars.git ~/.rbenv/plugins/rbenv-vars;
hash -r;

echo "INSTALANDO RUBY 💎😃 verificar version ruby"
rbenv install 3.0.1; # COLOCAR TU VERSIÓN DE RUBY
rbenv global 3.0.1;  # COLOCAR TU VERSIÓN DE RUBY
ruby -v;

echo "COMENZANDO PARTE 6 🤩"
git config --global color.ui true;
git config --global user.name "genmistic";         # COLOCAR TU NOMBRE
git config --global user.email "osoriolomena@gmail.com";   # COLOCAR TU CORREO DE GITHUB
ssh-keygen -t rsa -b 4096 -C "osoriolomena@gmail.com";     # COLOCAR TU CORREO DE GITHUB

cat ~/.ssh/id_rsa.pub;
echo "💎 FIN DE LA INSTALACIÓN, COPIAR LA LLAVE EN GITHUB.COM 💎"
