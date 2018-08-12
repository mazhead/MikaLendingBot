FROM amancevice/pandas:0.21.0-python2-alpine
LABEL "project.home"="https://github.com/BitBotFactory/poloniexlendingbot"

WORKDIR /usr/src/app


RUN apk update && apk add --no-cache git py-requests ca-certificates && git clone https://github.com/mazhead/MikaLendingBot.git . && apk del git

VOLUME /data

RUN mv market_data market_data_git && \
    ln -s /data/ market_data && \
    cp /usr/src/app/default.cfg.example /usr/src/app/default.cfg && \
    ln -s /data/botlog.json /usr/src/app/www/botlog.json

EXPOSE 8000

CMD ["/usr/bin/python", "lendingbot.py", "-cfg", "/usr/src/app/default.cfg"]