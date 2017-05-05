# Docker Elastic.co Metricbeat

- ```5.3.0```, ```5.3.1```, ```5.3.2```
- ```5.2.0```, ```5.2.1```, ```5.2.2```
- ```5.1.1```, ```5.1.2```
- ```5.0.0-rc1```, ```5.0.1```, ```5.0.2```

[![Docker Pulls](https://img.shields.io/docker/pulls/athieriot/metricbeat.svg)]() [![](https://images.microbadger.com/badges/image/athieriot/metricbeat.svg)](https://microbadger.com/images/athieriot/metricbeat "Get your own image badge on microbadger.com")

Docker image for Elastic Metricbeat

## Simple usage

Providing your custom `metricbeat.yml` under `/metricbeat/metricbeat.yml`

```sh
docker run -d \
  -e ELASTICSEARCH_URL=http://elasticsearch:9200 \
  -v /home/username/metricbeat.yml:/metricbeat/metricbeat.yml \
  --name=metricbeat \
  --pid=host \
  athieriot/metricbeat
```

## Official recommendations

More details: https://www.elastic.co/guide/en/beats/metricbeat/5.x/running-in-container.html

```sh
docker run -d \
     -v=/proc:/hostfs/proc:ro \
     -v=/sys/fs/cgroup:/hostfs/sys/fs/cgroup:ro \
     -volume=/:/hostfs:ro \
     -v /home/username/metricbeat.yml:/metricbeat/metricbeat.yml \
     athieriot/metricbeat -system.hostfs=/hostfs
```

## Docker compose

For docker-compose example  [docker-compose-elasticsearch.yml](https://github.com/athieriot/docker-elastic-metricbeat/blob/master/docker-compose-elasticsearch.yml)

```sh
cp docker-compose-elasticsearch.yml docker-compose.yml
docker-compose up
```

Open kibana dashboard in your favorite browser `http://localhost:5601/`

## Loading Sample Kibana Dashboards

```sh
docker-compose exec metricbeat sh -c './scripts/import_dashboards -es $ELASTICSEARCH_URL'
```

## Troubleshouting

### Config file permissions

Since Metricbeat 5.3, permissions needs to comply to certain constraint in order for the service to start.

By default, this Docker Image will automatically change the permissions on your config file to make it compliant.

This behaviour can be disabled using:

      -e SKIP_CHOWN_CONFIG=true

### Elasticsearch host inavailable within a container

When Elasticsearch is launched inside a container it is inaccessible from another linked container.
A configuration has to be set for it to work properly. Change IP as needed.

      docker run --name=elasticsearch elasticsearch elasticsearch -Etransport.host=0.0.0.0

In order to pass the bootstrap checks you will also need to run that command on the host machine:

      sysctl -q -w vm.max_map_count=262144

## License

This program is licensed under an MIT license with an additional non-advertising clause. See [LICENSE](https://github.com/athieriot/docker-elastic-metricbeat/blob/master/LICENSE) for the full text.
