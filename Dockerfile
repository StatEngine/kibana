FROM node:6

ARG KIBANA_VERSION=kibana-5.5.2-SNAPSHOT
ENV KIBANA_VERSION=${KIBANA_VERSION}

ARG ROR_VERSION=readonlyrest_kbn_enterprise-1.16.14_es5.5.2.zip
ENV ROR_VERSION=${ROR_VERSION}

ENV THEME=statengine
ENV SERVER_HOST=0.0.0.0
ENV SERVER_BASEPATH=/_plugin/kibana
ENV ELASTICSEARCH_URI=http://docker.for.mac.localhost:9200
ENV KIBANA_USERNAME=kibana
ENV KIBANA_PASSWORD=kibana
ENV ROR_CUSTOM_LOGOUT_LINK=https://statengine.io

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
RUN /usr/src/kibana/build/$KIBANA_VERSION-linux-x86_64/bin/kibana-plugin install file:///usr/src/kibana/$ROR_VERSION

# Run
CMD /usr/src/kibana/docker-run.sh

EXPOSE 5601
