FROM markadams/chromium-xvfb-py2

# Install node & npm
RUN apt-get -qqy update && \
  DEBIAN_FRONTEND=noninteractive apt-get -y install vim git nodejs npm
RUN ln -s /usr/bin/nodejs /usr/bin/node

# Install Wetty
WORKDIR /opt/wetty
RUN git clone https://github.com/krishnasrinivas/wetty.git . && \
  git reset --hard 223b1b1
RUN npm install

# Set-up term user
RUN useradd -d /home/term -m -s /bin/bash term
RUN echo 'term:term' | chpasswd
RUN sudo adduser term sudo

# Default ENV params used by wetty
ENV REMOTE_SSH_SERVER ""
ENV REMOTE_SSH_PORT ""
ENV REMOTE_SSH_USER ""

ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["/app/entrypoint.sh"]
