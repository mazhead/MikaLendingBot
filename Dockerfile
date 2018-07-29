FROM amancevice/pandas:0.21.0-python2-alpine
LABEL "project.home"="https://github.com/BitBotFactory/poloniexlendingbot"

WORKDIR /usr/src/app


RUN apk update && apk add --no-cache git ruby ruby-json py-requests && gem instal --no-document tiller && git clone https://github.com/mazhead/MikaLendingBot.git . && apk del git

VOLUME /data

RUN mv market_data market_data_git && \
    ln -s /data/ market_data && \
    touch /data/botlog.json && \
    ln -s /data/botlog.json www/botlog.json

EXPOSE 8000

CMD ["/usr/bin/tiller", "-v", "-b", "/usr/src/app/tiller"]