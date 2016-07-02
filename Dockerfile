FROM codenvy/ubuntu_jdk8

USER user

RUN sudo apt-get update -qqy && \
  sudo apt-get -qqy install \
  supervisor \
  x11vnc \
  xvfb \
  gtk2.0 \
  blackbox \
  net-tools \
  rxvt-unicode \
  xfonts-terminus \
  nano && \
  sudo rm -rf /var/lib/apt/lists/*

RUN wget \
  --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" \
  -qO- \
"http://download.oracle.com/otn-pub/java/javafx_scenebuilder/2.0-b20/javafx_scenebuilder-2_0-linux-x64.tar.gz" | sudo tar -zx -C /opt/

RUN sudo mkdir -p /opt/noVNC/utils/websockify && \
    wget -qO- "http://github.com/kanaka/noVNC/tarball/master" | sudo tar -zx --strip-components=1 -C /opt/noVNC && \
    wget -qO- "https://github.com/kanaka/websockify/tarball/master" | sudo tar -zx --strip-components=1 -C /opt/noVNC/utils/websockify && \
    sudo mkdir -p /etc/X11/blackbox

ADD blackbox-menu /etc/X11/blackbox/
ADD index.html /opt/noVNC/
ADD supervisord.conf /opt/
ADD entrypoint.sh /home/user/

RUN sudo chmod +x /home/user/entrypoint.sh

WORKDIR /home/user/

EXPOSE 6080

LABEL che:server:6080:ref=noVNC che:server:6080:protocol=http

ENV DISPLAY :20.0

ENTRYPOINT ["/home/user/entrypoint.sh"]

CMD tail -f /dev/null

