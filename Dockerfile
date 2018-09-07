FROM jaskon139/qemuopenvpn

RUN apt-get update && apt-get install -y curl xvfb chromium-bsu

ADD xvfb-chromium /usr/bin/xvfb-chromium
RUN ln -s /usr/bin/xvfb-chromium /usr/bin/google-chrome
RUN ln -s /usr/bin/xvfb-chromium /usr/bin/chromium-browser

RUN apt-get update && apt-get install -y \
    python python-pip curl unzip libgconf-2-4 python-dev npm

RUN pip install pytest selenium

ENV CHROMEDRIVER_VERSION 2.36
ENV CHROMEDRIVER_SHA256 2461384f541346bb882c997886f8976edc5a2e7559247c8642f599acd74c21d4

RUN curl -SLO "https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip" \
  && echo "$CHROMEDRIVER_SHA256  chromedriver_linux64.zip" | sha256sum -c - \
  && unzip "chromedriver_linux64.zip" -d /usr/local/bin \
  && rm "chromedriver_linux64.zip"
  
ADD . /app
RUN chmod +x /app/entrypoint.sh

RUN cd /app && npm install npm -g && npm install 

ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["/app/entrypoint.sh"]
