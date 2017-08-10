#!/bin/bash

# Build
rm -rf target
docker rm -vf elastic-flatjson-ci
mvn verify -Pdocker

# Run tests
src/test/test.sh

