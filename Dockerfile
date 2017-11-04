FROM node:6

ARG READ_ONLY_REST_PLUGIN=readonlyrest_kbn_enterprise-1.16.12_es5.5.3.zip
ENV READ_ONLY_REST_PLUGIN=${READ_ONLY_REST_PLUGIN}

ENV THEME=statengine
ENV ELASTICSEARCH_URI=http://docker.for.mac.localhost:9200
ENV KIBANA_ELASTICSEARCH_USERNAME=kibana
ENV KIBANA_ELASTICSEARCH_PASSWORD=kibana

# Make src directory
RUN mkdir -p /usr/src/kibana
WORKDIR /usr/src/kibana

COPY .node-version /usr/src/kibana/

# Install NVM and correct version of node
ENV NVM_DIR /usr/local/nvm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash\
    && . $NVM_DIR/nvm.sh \
    && nvm install "$(cat .node-version)"

# Install kibana dependencies
COPY package.json /usr/src/kibana/
RUN npm install

# Copy rest of src over
COPY . /usr/src/kibana

# Build
RUN npm run build -- --skip-os-packages --skip-archives

# Setup Run script
RUN chmod +x /usr/src/kibana/docker-run.sh

# Install Read Only Rest Plugin
RUN /usr/src/kibana/build/kibana-5.5.3-SNAPSHOT-linux-x86_64/bin/kibana-plugin install file:///usr/src/kibana/$READ_ONLY_REST_PLUGIN

# Run
CMD /usr/src/kibana/docker-run.sh

EXPOSE 5601
