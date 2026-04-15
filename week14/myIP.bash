#!/bin/bash

# Get Interfaces not lo
addresses=$(ip a | grep 'scope global' | awk '{print $2}' | sed 's/\/24//')

echo $addresses

