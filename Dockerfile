FROM phpdocker/phpdocker:7.2

WORKDIR /var/www

# SSH server
RUN apt-get -q -y --force-yes update && \
    apt-get -q -y --force-yes install sudo openssh-server && \
    sed -i 's/^\#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    mkdir /var/run/sshd

# Set root password
RUN echo 'root:tinkerapp' | chpasswd

# SSH port for file management
EXPOSE 22

COPY . /var/www/
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

RUN composer install --no-scripts

RUN php artisan migrate --seed --force

CMD ["php", "/var/www/artisan", "tinker"]
