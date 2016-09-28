FROM frolvlad/alpine-glibc
MAINTAINER Aurélien Thieriot <aurelien@scalar.is>

ENV METRICBEAT_VERSION=5.0.0-beta1

RUN apk add --no-cache \
      ca-certificates \
      curl

RUN curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-${METRICBEAT_VERSION}-linux-x86_64.tar.gz && \
    tar -xvvf metricbeat-${METRICBEAT_VERSION}-linux-x86_64.tar.gz && \
    mv metricbeat-${METRICBEAT_VERSION}-linux-x86_64/ /etc/metricbeat && \
    mv /etc/metricbeat/metricbeat.yml /etc/metricbeat/metricbeat.example.yml && \
    mv /etc/metricbeat/metricbeat /usr/sbin/metricbeat && \
    chmod +x /usr/sbin/metricbeat

RUN curl -L -O http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz && \
    mkdir -p /usr/share/GeoIP && \
    gunzip -c GeoLiteCity.dat.gz > /usr/share/GeoIP/GeoLiteCity.dat

WORKDIR /metricbeat

ADD files/ .

CMD /metricbeat/start.sh
