FROM php:7.1

# grundlegende Software
RUN apt-get update && \
    apt-get install -y apt-transport-https wget zip unzip bzip2 ruby ruby-dev gcc rpm subversion git

# php extensions (und dafür benötigte deps) installieren
RUN apt-get install -y libicu-dev libldap2-dev && \
    docker-php-ext-install pdo pdo_mysql intl && \
    printf "\n" | pecl install apcu && \
    docker-php-ext-enable apcu && \
    docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && \
    docker-php-ext-install ldap

# yarn installieren
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

# eigene php.ini verwenden (memory-limit)
COPY php.ini /usr/local/etc/php/php.ini

# composer global installieren
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer

# compass installieren
RUN gem update --system && \
    gem install compass

# Node und Node-Pakete installieren
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g bower uglify-js

# symbolische Links setzen
# RUN ln -s /usr/bin/nodejs /usr/local/bin/node

