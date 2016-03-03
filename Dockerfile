FROM java:latest

MAINTAINER Daniel Keler <danielk@jfrog.com>

RUN apt-get update && apt-get install -y curl unzip

ADD run.sh /usr/bin/run.sh

RUN chmod +x /usr/bin/run.sh

WORKDIR /usr/bin/

EXPOSE 8080

CMD /usr/bin/run.sh