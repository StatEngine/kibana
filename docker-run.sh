#!/bin/bash

# Set theme
rm -rf /usr/src/kibana/build/$KIBANA_VERSION-linux-x86_64/src/ui/theme
ln -s /usr/src/kibana/build/$KIBANA_VERSION-linux-x86_64/src/ui/themes/$THEME/ /usr/src/kibana/build/$KIBANA_VERSION-linux-x86_64/src/ui/theme

# Run Kibana
/usr/src/kibana/build/$KIBANA_VERSION-linux-x86_64/bin/kibana \
  -e $ELASTICSEARCH_URI \
  --server.host=$SERVER_HOST \
  --server.basePath=$SERVER_BASEPATH \
  --elasticsearch.username=$ELASTICSEARCH_KIBANA_USER \
  --elasticsearch.password=$ELASTICSEARCH_KIBANA_PASSWORD \
  --readonlyrest_kbn.custom_logout_link=$ROR_CUSTOM_LOGOUT_LINK \
  --verbose
