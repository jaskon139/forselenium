FROM ubuntu:14.04

RUN mkdir -p /app

RUN apt-get update && apt-get install -y curl xvfb chromium-browser

RUN mv  /usr/bin/chromium-browser /usr/bin/chromium

ADD xvfb-chromium /usr/bin/xvfb-chromium
RUN ln -s /usr/bin/xvfb-chromium /usr/bin/google-chrome
RUN ln -s /usr/bin/xvfb-chromium /usr/bin/chromium-browser

RUN apt-get update && apt-get install -y \
    python python-pip curl unzip libgconf-2-4 python-dev wget git
    
RUN pip install pytest selenium

ENV CHROMEDRIVER_VERSION 2.36
ENV CHROMEDRIVER_SHA256 2461384f541346bb882c997886f8976edc5a2e7559247c8642f599acd74c21d4

RUN curl -SLO "https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip" \
  && echo "$CHROMEDRIVER_SHA256  chromedriver_linux64.zip" | sha256sum -c - \
  && unzip "chromedriver_linux64.zip" -d /usr/local/bin \
  && rm "chromedriver_linux64.zip"

RUN cd /usr/local/bin && wget https://github.com/yudai/gotty/releases/download/v1.0.1/gotty_linux_amd64.tar.gz &&\
	tar xvf gotty_linux_amd64.tar.gz



RUN cd /app && wget https://nodejs.org/dist/v8.11.4/node-v8.11.4-linux-x64.tar.xz && tar xvf node-v8.11.4-linux-x64.tar.xz
RUN PATH=/app/node-v8.11.4-linux-x64/bin/:$PATH npm install -g selenium-side-runner 

  
ADD . /app
RUN chmod +x /app/entrypoint.sh
WORKDIR /app

ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["/app/entrypoint.sh"]

