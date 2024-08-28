FROM rethinkdb:latest

RUN apt-get update && apt-get install -y python3-pip
RUN pip3 install rethinkdb --break-system-packages

COPY setup_rethinkdb.py setup_rethinkdb.py

EXPOSE 8080 28015
