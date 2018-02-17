FROM arm64v8/ubuntu:slim

RUN apt-get update \
	&& apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6 \
	&& echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list\
	&& apt-get update \
	&& mkdir -p /data/db \
	&& apt-get install mongodb-org -y \
	&& systemctl enable mongod.service 

COPY mongod.conf /etc/

# Expose listen port
EXPOSE 27017
EXPOSE 28017

# Expose our data volumes
VOLUME ["/data/db"]

CMD ["mongod"]
