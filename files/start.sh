#!/usr/bin/env ash

mkdir -p /metricbeat/config && mkdir -p /metricbeat/data

if [ "$PROFILE" != "custom" ]; then
  cp /metricbeat/metricbeat.${PROFILE:-elasticsearch}.yml /metricbeat/config/metricbeat.yml
fi

if [ "$PROFILE" != "elasticsearch" ] && [ $EXTERNAL_ELASTIC_HOST ]; then
  if [ -z $DRY_RUN ]; then
    # wait for elasticsearch to start up
    ELASTIC_PATH=${EXTERNAL_ELASTIC_HOST:-${HOST:-elasticsearch}}:${EXTERNAL_ELASTIC_PORT:-${PORT:-9200}}
    echo "Configure ${ELASTIC_PATH}"

    counter=0
    while [ ! "$(curl $ELASTIC_PATH 2> /dev/null)" -a $counter -lt 30  ]; do
      sleep 1
      ((counter++))
      echo "waiting for Elasticsearch to be up ($counter/30)"
    done

    curl -XPUT "http://$ELASTIC_PATH/_template/metricbeat" -d@/metricbeat/metricbeat.template.json
  fi
fi

if [ -z $DRY_RUN ]; then
  metricbeat -e -v -c /metricbeat/config/metricbeat.yml
fi
