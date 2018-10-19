#!/bin/bash

# Clear the MacOS DNS client cache - will require password

sudo killall -HUP mDNSResponder
