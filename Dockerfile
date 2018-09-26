FROM ubuntu
MAINTAINER Joan Marc Carbo <jmcarbo@gmail.com>

RUN apt-get update && \
    apt-get install -y wget curl netcat cron postgresql-10
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main 9.6" >/etc/apt/sources.list.d/postgresql.list
RUN mkdir /backup

ENV CRON_TIME="0 0 * * *" \
    PG_DB="--all-databases"

ADD restic_app /usr/local/bin/restic
RUN chmod +x /usr/local/bin/restic

ADD run.sh /run.sh
RUN chmod +x /run.sh
VOLUME ["/backup"]

CMD ["/run.sh"]
