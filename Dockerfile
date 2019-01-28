FROM phpdocker/phpdocker:7.2

COPY . /var/www/
WORKDIR /var/www
COPY entrypoint.sh /entrypoint.sh

# SSH server
RUN apt-get -q -y --force-yes update && \
    apt-get -q -y --force-yes install sudo openssh-server && \
    sed -i '/^PermitRootLogin/s/without-password/yes/' /etc/ssh/sshd_config && \
    mkdir /var/run/sshd

RUN chmod +x /entrypoint.sh

RUN composer install --no-dev --no-scripts

RUN php artisan migrate --seed --force

# Set root password
RUN  echo 'root:tinkerapp' | chpasswd

# SSH port for file management
EXPOSE 22

ENTRYPOINT ["/entrypoint.sh"]

CMD ["php", "/var/www/artisan", "tinker"]
