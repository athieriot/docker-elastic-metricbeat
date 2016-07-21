# Docker Elastic.co Metricbeat

[![Docker Pulls](https://img.shields.io/docker/pulls/athieriot/metricbeat.svg)]() [![](https://badge.imagelayers.io/athieriot/metricbeat:latest.svg)](https://imagelayers.io/?images=athieriot/metricbeat:latest 'Get your own badge on imagelayers.io')

Docker image for Elastic Metricbeat

# Usage

### Elasticsearch

      docker run -d \
        --link=elasticsearch:elasticsearch \
        --name=metricbeat \
        --pid=host \
        athieriot/metricbeat
      
### Logstash

      docker run -d \
        -e PROFILE=logstash \
        --link=logstash:logstash \
        --name=metricbeat \
        --pid=host \
        athieriot/metricbeat

### File

      docker run -d \
        -e PROFILE=file \
        -v /path/to/data/:/metricbeat/data/ \
        --name=metricbeat \
        --pid=host \
        athieriot/metricbeat

### Console

      docker run -d \
        -e PROFILE=console \
        --name=metricbeat \
        --pid=host \
        athieriot/metricbeat

### Custom configuration file

      docker run -d \
        -e PROFILE=custom \
        -v /path/to/config/metricbeat.yml:/metricbeat/config/metricbeat.yml \
        --name=metricbeat \
        --pid=host \
        athieriot/metricbeat

# More variables

### General

      docker run -d \
        -e HOST=elasticsearch.in.aws.com \
        -e PORT=80 \
        -e CPU_PER_CORE=false \
        -e INDEX=metricbeat \
        -e PROCS=.* \
        -e PERIOD=10s \
        -e SHIPPER_NAME=super-app \
        -e SHIPPER_TAGS="qa", "db" \
        --name=metricbeat \
        --pid=host \
        athieriot/metricbeat

### Elasticsearch template configuration

In the event you are usage a custom configuration or logstash but want to add metricbeat templates to your own Elasticsearch instance:

      docker run -d \
        -e PROFILE=logstash \
        -e EXTERNAL_ELASTIC_HOST=my.elasticsearch.com \
        -e EXTERNAL_ELASTIC_PORT=9200 \
        --link=logstash:logstash \
        --name=metricbeat \
        --pid=host \
        athieriot/metricbeat

# Troubleshouting

### Elasticsearch host inavailable within a container

Somehow, when Elasticsearch is launched inside a container it is inaccessible from another linked container.
A configuration has to be set for it to work properly. Change IP as needed.

      docker run --name=elasticsearch elasticsearch elasticsearch -Des.network.bind_host=0.0.0.0
