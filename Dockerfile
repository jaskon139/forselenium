FROM dhoodlum/webdriverio-selenium

RUN mkdir -p /app

RUN apt-get update && apt-get install -y \
    wget git
    

RUN cd /usr/local/bin && wget https://github.com/yudai/gotty/releases/download/v1.0.1/gotty_linux_amd64.tar.gz &&\
	tar xvf gotty_linux_amd64.tar.gz

RUN cd /app && wget https://nodejs.org/dist/v8.11.4/node-v8.11.4-linux-x64.tar.xz && tar xvf node-v8.11.4-linux-x64.tar.xz
RUN PATH=/app/node-v8.11.4-linux-x64/bin/:$PATH npm install -g selenium-side-runner 
  
ADD . /app
RUN chmod +x /app/entrypoint.sh
WORKDIR /app

ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["/app/entrypoint.sh"]

