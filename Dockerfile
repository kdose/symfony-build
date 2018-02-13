FROM php:7.1

# grundlegende Software
RUN apt-get update && \
    apt-get install -y automake libtool apt-transport-https wget zip unzip bzip2 ruby ruby-dev gcc rpm subversion git gnupg

# php extensions (und dafür benötigte deps) installieren
RUN apt-get install -y libicu-dev libldap2-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev && \
    docker-php-ext-install pdo pdo_mysql intl  && \
    printf "\n" | pecl install apcu && \
    docker-php-ext-enable apcu && \
    docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && \
    docker-php-ext-install ldap && \
    docker-php-ext-install -j$(nproc) iconv mcrypt && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install -j$(nproc) gd && \
    docker-php-ext-install opcache && \
    docker-php-ext-install zip

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
    mv composer.phar /usr/local/bin/composer && \
    composer global require hirak/prestissimo

# compass installieren
RUN gem update --system && \
    gem install compass

# Node und Node-Pakete installieren
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g bower uglify-js

# symbolische Links setzen
RUN ln -s /usr/bin/nodejs /usr/local/bin/node && ln -s /usr/bin/bower /usr/local/bin/bower && ln -s /usr/bin/uglifyjs /usr/local/bin/uglifyjs
