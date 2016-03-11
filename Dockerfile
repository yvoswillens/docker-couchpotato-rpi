FROM resin/rpi-raspbian
MAINTAINER Yvo Swillens <yvoswillens@gmail.com> 

RUN apt-get -q update
RUN apt-get -qy --force-yes dist-upgrade

RUN apt-get install -qy --force-yes  python python-pip git-core python-dev libffi-dev libssl-dev libxml2-dev libxslt1-dev gcc
RUN git clone -c http.sslVerify=false https://github.com/RuudBurger/CouchPotatoServer.git /CouchPotatoServer
RUN pip install lxml
RUN pip install pyopenssl

VOLUME /config
VOLUME /data

ADD ./start.sh /start.sh
RUN chmod u+x  /start.sh

EXPOSE 5050

RUN apt-get -qy autoremove &&\
    apt-get clean &&\
    rm -rf /var/lib/apt/lists/* &&\
    rm -rf /tmp/*

CMD ["/start.sh"]
