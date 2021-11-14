# Pasos para la configuración de la gema de Capistrano

1. Agregar las siguientes gemas a nuestro Gemfile

    ```ruby
    gem 'capistrano', '~> 3.11'
    gem 'capistrano-rails', '~> 1.4'
    gem 'capistrano-passenger', '~> 0.2.0'
    gem 'capistrano-rbenv', '~> 2.1', '>= 2.1.4'
    ```

2. Ejecutar los comandos bundle y cap

    ```bash
    bundle
    cap install STAGES=production
    ```

3. El comando anterior generará los siguientes archivos:

    - Capfile
    - config/deploy.rb
    - config/deploy/production.rb

    Debemos editar el archivo Capfile para agregar las versiones de ruby y dependencias

    ```ruby
    # Capfile
    require 'capistrano/rails'
    require 'capistrano/passenger'
    require 'capistrano/rbenv'

    set :rbenv_type, :user
    set :rbenv_ruby, '3.0.1' # ⏰ COLOCAR TU VERSIÓN DE RUBY
    ```

    Modificar el archivo de configuración para que Capistrano sepa de dónde sacar el código y dónde colocarlo

    ```ruby
    # config/deploy.rb
    set :application, "m2_carts"
    set :repo_url, "git@github.com:genmistic/m2_carts.git"

    # Deploy to the user's home directory
    set :deploy_to, "/home/ubuntu/#{fetch :application}"

    append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public/system', 'public/uploads'

    # Only keep the last 5 releases to save disk space
    set :keep_releases, 5

    # Optionally, you can symlink your database.yml and/or secrets.yml file from the shared directory during deploy
    # This is useful if you don't want to use ENV variables
    # append :linked_files, 'config/database.yml', 'config/secrets.yml'
    ```

    Modificar el archivo `config/deploy/production.rb` para darle la dirección de nuestro servidor

    ```ruby
    server '3.141.12.215', user: 'ubuntu', roles: %w{app db web}
    ```

4. Agregar las credenciales del servidor postgresql de AWS en el archivo de `credentials` y configurar los accesos en `config/database.yml`

    ```bash
    EDITOR="code --wait" rails credentials:edit
    ```

    ```yml
    # credentials.yml.enc
    db_production:
        username: ubuntu
        password: 1514 # 👈 Tiene que ser la contraseña de Postgres de AWS
    ```

    ```yml
    # config/database.yml
    production:
        <<: *default
        database: m2_carts # CAMBIAR EL NOMBRE DE LA BASE DE DATOS 🚥
        username: <%= Rails.application.credentials.db_production[:username] %>
        password: <%= Rails.application.credentials.db_production[:password] %>
    ```

5. Agregar los ssh de su equipo a AWS

    Ejecutar el comando en tu equipo local

    ```bash
    cat ~/.ssh/id_rsa.pub
    # COPIAR la llave pública 📎
    ```

    Ejecutar el comando en tu AWS

    ```bash
    nano ~/.ssh/authorized_keys
    # PEGAR la llave copiada 📂
    ```

    Guardar y salir con `Ctrl + x` y luego `y`

6. Ingresar al servidor y agregar la master.key y secret_key_base en .rbenv-vars

    Para obtener SECRET_KEY_BASE hay que ejecutar el siguiente comando tu TU equipo local

    ```bash
    # en la carpeta de tu proyecto
    EDITOR="code --wait" rails credentials:edit
    ```

    Luego conectarse al servidor en AWS

    ```bash
    # EN EL SERVIDOR DE AWS
    mkdir /home/ubuntu/m2_carts_production
    nano /home/ubuntu/m2_carts_production/.rbenv-vars
    ```

    Copiar el contenido de *secret_key_base* y *config/master.key*

    ```text
    #👉TU_master.key👈
    RAILS_MASTER_KEY=ecaf0c7cfc0b879fff5c877395c4ddab 
   
    SECRET_KEY_BASE=49e35a6225d7d0b385ebe8bf192426dc190f7e847c4237d734afe9eb8e40ad2814e43d89b92579618a4f3d4ea05edd091c261efb6382d92e8544a477ec9b4a7d 
  #👉TU_SECRET_KEY_BASE_DENTRO_DEL_ARCHIVO_CREDENTIALS👈

    Para cerrar el programa `Ctrl + x` y luego `y`

7. Ejecutar el comando

    ```bash
    cap production deploy
    ```

8. Ver la matrix funcionar 💻🐱‍💻
