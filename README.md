# Docker Elastic.co Metricbeat

- ```5.0.0-rc1```

[![Docker Pulls](https://img.shields.io/docker/pulls/athieriot/metricbeat.svg)]() [![](https://images.microbadger.com/badges/image/athieriot/metricbeat.svg)](https://microbadger.com/images/athieriot/metricbeat "Get your own image badge on microbadger.com")

Docker image for Elastic Metricbeat

## Simple usage

```sh
docker run -d \
  -e ELASTICSEARCH_URL=http://elasticsearch:9200 \
  --name=metricbeat \
  --pid=host \
  athieriot/metricbeat
```

## Custom config

Mount your custom `metricbeat.yml` under `/metricbeat/metricbeat.yml`

```sh
docker run -d \
  -e ELASTICSEARCH_URL=http://elasticsearch:9200 \
  -v ./metricbeat.yml:/metricbeat/metricbeat.yml \
  --name=metricbeat \
  --pid=host \
  athieriot/metricbeat
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

### Elasticsearch host inavailable within a container

Somehow, when Elasticsearch is launched inside a container it is inaccessible from another linked container.
A configuration has to be set for it to work properly. Change IP as needed.

      docker run --name=elasticsearch elasticsearch elasticsearch -Des.network.bind_host=0.0.0.0

## License

This program is licensed under an MIT license with an additional non-advertising clause. See [LICENSE](https://github.com/athieriot/docker-elastic-metricbeat/blob/master/LICENSE) for the full text.
