#!/bin/bash

# Set theme
rm -rf /usr/src/kibana/build/kibana-5.5.3-SNAPSHOT-linux-x86_64/src/ui/theme
ln -s /usr/src/kibana/build/kibana-5.5.3-SNAPSHOT-linux-x86_64/src/ui/themes/$THEME/ /usr/src/kibana/build/kibana-5.5.3-SNAPSHOT-linux-x86_64/src/ui/theme

# Run Kibana
/usr/src/kibana/build/kibana-5.5.3-SNAPSHOT-linux-x86_64/bin/kibana \
  -e $ELASTICSEARCH_URI \
  --server.host=$SERVER_HOST \
  --server.basePath=$SERVER_BASEPATH \
  --elasticsearch.username=$KIBANA_ELASTICSEARCH_USERNAME \
  --elasticsearch.password=$KIBANA_ELASTICSEARCH_PASSWORD \
  --elasticsearch.requestHeadersWhitelist=authorization,X-Forwarded-User \
  --readonlyrest_kbn.proxy_auth_passthrough=true
