#!/bin/bash

# Set theme
rm -rf /usr/src/kibana/build/kibana-5.5.3-SNAPSHOT-linux-x86_64/src/ui/theme
ln -s /usr/src/kibana/build/kibana-5.5.3-SNAPSHOT-linux-x86_64/src/ui/themes/$THEME/ /usr/src/kibana/build/kibana-5.5.3-SNAPSHOT-linux-x86_64/src/ui/theme

# Run Kibana
/usr/src/kibana/build/kibana-5.5.3-SNAPSHOT-linux-x86_64/bin/kibana -e $ELASTICSEARCH_URL --server.host="0.0.0.0"
