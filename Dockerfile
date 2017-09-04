FROM postgres:9.6.5

MAINTAINER Andrew Graham-Yooll

RUN apt-get update && apt-get install -y python3-pip python3 lzop pv daemontools sudo && rm -rf /var/lib/apt/lists/*
RUN pip3 install --upgrade pip
RUN python3 -m pip install wal-e[azure] && apt-get clean

# Change the entrypoint so wale will always be setup, even if the data dir already exists
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

COPY setup-wale.sh fix-acl.sh /docker-entrypoint-initdb.d/
COPY backup /

CMD ["postgres"]
