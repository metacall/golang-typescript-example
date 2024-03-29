# MetaCall Golang TypeScript Example

This example shows how to embed TypeScript into Go using MetaCall. In other words, calling TypeScript functions from Go. The instructions are focused on Linux but it can be ported to other platforms easily.

## Dependencies

For building this example you need NodeJS to be installed in the system (12.x has been tested). For debian based distros:

```bash
sudo apt-get install -y --no-install-recommends build-essential cmake ca-certificates git nodejs npm unzip
```

Apart from this, you will need Go installed in order to build the main application. I have used Go 1.17.

## Build

Build MetaCall first, with NodeJS and TypeScript loaders enabled:

```bash
git clone --branch v0.5.2 https://github.com/metacall/core
mkdir core/build && cd core/build
cmake \
	-DNODEJS_CMAKE_DEBUG=On \
	-DOPTION_BUILD_LOADERS_NODE=On \
	-DOPTION_BUILD_LOADERS_TS=On \
	-DOPTION_BUILD_PORTS=On \
	-DOPTION_BUILD_PORTS_NODE=On \
	-DOPTION_BUILD_DETOURS=Off \
	-DOPTION_BUILD_SCRIPTS=Off \
	-DOPTION_BUILD_TESTS=Off \
	-DOPTION_BUILD_EXAMPLES=Off \
	..
cmake --build . --target install
ldconfig /usr/local/lib
```

Now clone the Go/TypeScript example and build it.

```sh
git clone https://github.com/metacall/golang-typescript-example.git
cd golang-typescript-example
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
docker build -t metacall/golang-typescript-example .
docker run --rm -it metacall/golang-typescript-example
```
