#!/bin/bash

set -xe

docker build -t kdose/symfony-build:7.1 7.1
docker push kdose/symfony-build:7.1
docker build -t kdose/symfony-build:latest -t kdose/symfony-build:7.2 7.2
docker push kdose/symfony-build:latest
docker push kdose/symfony-build:7.2