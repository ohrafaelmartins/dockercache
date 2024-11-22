#!/bin/bash
COMMIT_HASH=$1

docker build -t ohrafaelmartins/elixirdemo:$COMMIT_HASH .