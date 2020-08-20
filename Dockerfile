#
#	MetaCall Embedding NodeJS Example by Parra Studios
#	An example of embedding NodeJS into C/C++.
#
#	Copyright (C) 2016 - 2020 Vicente Eduardo Ferrer Garcia <vic798@gmail.com>
#
#	Licensed under the Apache License, Version 2.0 (the "License");
#	you may not use this file except in compliance with the License.
#	You may obtain a copy of the License at
#
#		http://www.apache.org/licenses/LICENSE-2.0
#
#	Unless required by applicable law or agreed to in writing, software
#	distributed under the License is distributed on an "AS IS" BASIS,
#	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#	See the License for the specific language governing permissions and
#	limitations under the License.
#

FROM golang:1.15.0-buster

# Image descriptor
LABEL copyright.name="Vicente Eduardo Ferrer Garcia" \
	copyright.address="vic798@gmail.com" \
	maintainer.name="Vicente Eduardo Ferrer Garcia" \
	maintainer.address="vic798@gmail.com" \
	vendor="MetaCall Inc." \
	version="0.1"

# Install dependencies
RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
		build-essential \
		cmake \
		ca-certificates \
		git \
		nodejs \
		npm \
		python2.7 \
		node-gyp \
		unzip \
	&& npm install -g npm@latest

# Set working directory to home
WORKDIR /root

# Force rebuild for latest version
ARG DISABLE_CACHE=0

# Clone and build the project
RUN git clone --branch v0.2.22 https://github.com/metacall/core \
	&& mkdir core/build && cd core/build \
	&& cmake \
		-DNODEJS_CMAKE_DEBUG=On \
		-DOPTION_BUILD_LOADERS_NODE=On \
		-DOPTION_BUILD_LOADERS_TS=On \
		-DOPTION_BUILD_DETOURS=Off \
		-DOPTION_BUILD_SCRIPTS=Off \
		-DOPTION_BUILD_TESTS=Off \
		-DOPTION_BUILD_EXAMPLES=Off \
		.. \
	&& cmake --build . --target install

# Copy source files
COPY main.go go.mod go.sum /root/
COPY script.ts /home/scripts/script.ts

# Set up enviroment variables
ENV LOADER_LIBRARY_PATH=/usr/local/lib \
	LOADER_SCRIPT_PATH=/home/scripts

# Build the go source (and run the executable for testing)
RUN go build main.go \
	&& ./main

CMD [ "/root/main" ]
