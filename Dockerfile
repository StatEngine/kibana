FROM node:6

ENV THEME=statengine
ENV ELASTICSEARCH_URI=http://docker.for.mac.localhost:9200

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

# Run
CMD /usr/src/kibana/docker-run.sh

EXPOSE 5601
