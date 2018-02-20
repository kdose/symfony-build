#!/bin/bash

set -xe

docker build -t kdose/symfony-build:7.1 .
docker push kdose/symfony-build:7.1
docker build -t kdose/symfony-build:latest .
docker push kdose/symfony-build:latest