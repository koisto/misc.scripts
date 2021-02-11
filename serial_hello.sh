#!/bin/bash

stty -F /dev/ttyAMA0 115200
echo -e "hello" > /dev/ttyAMA0

