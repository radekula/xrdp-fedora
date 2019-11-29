FROM fedora

COPY entrypoint.sh /

ENV LANG=en_US.UTF-8

RUN dnf -y install glibc-locale-source

RUN echo "LANG=en_US.UTF-8" > /etc/locale.conf \
    && localedef -c -i en_US -f UTF-8 en_US.UTF-8

RUN dnf clean all \
    && dnf -y upgrade \
    && dnf -y reinstall glibc-common 

RUN dnf -y install --allowerasing --best \
       mate-panel \
       mate-desktop-libs \
       mate-session-manager \
       mate-control-center \
       mate-terminal \
       mate-menus \
       mate-desktop \
       mate-themes \
       mate-utils \
       mate-common \
       mate-icon-theme \
       mate-utils-common \
       liberation-*fonts* \
       dejavu-*fonts* \
       marco \
       caja \
       procps \
       xrdp \
       xorgxrdp \
       mc \
       sudo \
       tigervnc-server \
       tigervnc-server-module \
       openssh-server \
       wget \
       firefox \
       geany \
       tilix \
    && dnf clean all \
    && echo "mate-session" >> /etc/X11/Xsession

RUN chmod +x /entrypoint.sh \
    && mkdir -p /var/run/xrdp/sockdir \
    && rm -f /etc/xrdp/xrdp.ini \
    && rm -f /etc/xrdp/sesman.ini

COPY xrdp.ini /etc/xrdp
COPY sesman.ini /etc/xrdp

VOLUME ["/home"]
EXPOSE 22 3389

ENTRYPOINT ["/entrypoint.sh"]
