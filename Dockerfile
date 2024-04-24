FROM golang:latest

RUN apt-get update && apt-get install -y p7zip-full
# Install Taskfile
RUN sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin
# Install grpcurl
RUN wget --output-document grpcurl.deb "https://github.com/fullstorydev/grpcurl/releases/download/v1.9.1/grpcurl_1.9.1_linux_amd64.deb" && dpkg -i grpcurl.deb && rm grpcurl.deb
# Install buf
RUN BIN="/usr/local/bin" && VERSION="1.31.0" && curl -sSL "https://github.com/bufbuild/buf/releases/download/v${VERSION}/buf-$(uname -s)-$(uname -m)" -o "${BIN}/buf" && chmod +x "${BIN}/buf"

# Install npm
RUN curl -fsSL https://deb.nodesource.com/setup_21.x | bash - && apt-get install -y nodejs && \
    npm install --global webpack-cli webpack ts-loader