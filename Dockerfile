FROM archlinux
MAINTAINER Fred Richards - docker-frichards@gxize.net

ENV ZEROTIER_VERSION=1.10.2

RUN pacman --sync --refresh --sysupgrade --noconfirm --noprogressbar --quiet
RUN pacman --sync --noconfirm --noprogressbar --quiet zerotier-one supervisor
RUN yes | pacman -Scc
RUN set -eux; \
    zerotier-one -v; \
    echo "tun" >> /etc/modules

COPY files/supervisor-zerotier.conf /etc/supervisor/supervisord.conf
COPY files/entrypoint.sh /entrypoint.sh

RUN chmod 755 /entrypoint.sh

VOLUME ["/var/lib/zerotier-one"]
ENTRYPOINT ["/entrypoint.sh"]
