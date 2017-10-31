FROM node:6

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

# Run
CMD [ "/usr/src/kibana/build/kibana-5.5.3-SNAPSHOT-linux-x86_64/bin/kibana" ]

EXPOSE 5601
