FROM ubuntu:16.04
MAINTAINER tony.bussieres@ticksmith.com
RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get -y install python-pip python-dev mercurial git wget
RUN mkdir /opt/kallithea
RUN mkdir /var/repo
RUN wget https://bootstrap.pypa.io/ez_setup.py -O - | python
RUN wget https://files.pythonhosted.org/packages/source/K/Kallithea/Kallithea-0.3.2.tar.gz && tar xvzf Kallithea-0.3.2.tar.gz   && cd Kallithea-0.3.2 && python setup.py develop && python setup.py compile_catalog  

RUN cd /opt/kallithea && \
    paster make-config Kallithea production.ini && \
    sed -i 's/host = 127.0.0.1/host = 0.0.0.0/' production.ini && \
    yes | paster setup-db production.ini --user=admin --password=secret --email=admin@example.com --repos=/var/repo

VOLUME /opt/kallithea
VOLUME /var/repo

CMD cd /opt/kallithea && paster serve production.ini
