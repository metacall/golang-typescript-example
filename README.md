# MetaCall Golang TypeScript Example

This example shows how to embed TypeScript into Go using MetaCall. In other words, calling TypeScript functions from Go. The instructions are focused on Linux but it can be ported to other platforms easily.

## Dependencies

For building this example you need NodeJS to be installed in the system (10.x has been tested) and Python 2.7 available as `python` command (due to NodeJS build system dependency). For debian based distros:

```bash
sudo apt-get install -y --no-install-recommends build-essential cmake ca-certificates git nodejs npm python2.7 node-gyp unzip
sudo npm install -g npm@latest
alias python=/usr/bin/python2.7
```

Apart from this, you will need Go installed in order to build the main application. I have used Go 1.14 and 1.15.

## Build

Build MetaCall first, with NodeJS and TypeScript loaders enabled:

```bash
git clone --branch v0.2.22 https://github.com/metacall/core
mkdir core/build && cd core/build
cmake \
	-DNODEJS_CMAKE_DEBUG=On \
	-DOPTION_BUILD_LOADERS_NODE=On \
	-DOPTION_BUILD_LOADERS_TS=On \
	-DOPTION_BUILD_DETOURS=Off \
	-DOPTION_BUILD_SCRIPTS=Off \
	-DOPTION_BUILD_TESTS=Off \
	-DOPTION_BUILD_EXAMPLES=Off \
	..
cmake --build . --target install
```

Now clone the Go/TypeScript example and build it.

```sh
git clone https://github.com/metacall/golang-typescript-example.git
cd golang-typescript-example
export CGO_CFLAGS="-I/usr/local/include"
export CGO_LDFLAGS="-L/usr/local/lib"
go get -u github.com/metacall/core/source/ports/go_port/source
go build main.go
```

## Run

From repository root directory, run the following commands:

```bash
export LOADER_LIBRARY_PATH="/usr/local/lib"
export LOADER_SCRIPT_PATH="`pwd`"
./main
```

## Docker

Building and running with Docker:

```bash
docker build --build-arg DISABLE_CACHE=`date +%s` -t metacall/golang-typescript-example .
docker run --rm -it metacall/golang-typescript-example
```
