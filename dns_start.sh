#!/bin/bash

docker run -d -p 53:53/tcp -p 53:53/udp -p 10000:10000 bind
