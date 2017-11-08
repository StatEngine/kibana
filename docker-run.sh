#!/bin/bash

# Set theme
rm -rf /usr/src/kibana/build/$KIBANA_VERSION-linux-x86_64/src/ui/theme
ln -s /usr/src/kibana/build/$KIBANA_VERSION-linux-x86_64/src/ui/themes/$THEME/ /usr/src/kibana/build/$KIBANA_VERSION-linux-x86_64/src/ui/theme

# Run Kibana
/usr/src/kibana/build/$KIBANA_VERSION-linux-x86_64/bin/kibana \
  -e $ELASTICSEARCH_URI \
  --server.host=$SERVER_HOST \
  --server.basePath=$SERVER_BASEPATH \
  --elasticsearch.username=$KIBANA_USERNAME \
  --elasticsearch.password=$KIBANA_PASSWORD \
  --elasticsearch.requestHeadersWhitelist=authorization,X-Forwarded-User,x-statengine-department \
  --readonlyrest_kbn.proxy_auth_passthrough=true \
  --readonlyrest_kbn.proxy_auth_passthrough=$ROR_CUSTOM_LOGOUT_LINK
