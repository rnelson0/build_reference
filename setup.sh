#!/bin/bash
DEST=$1

if [ ! -d "${DEST}" ]; then
  echo "Destination directory '$DEST' does not exist or is not readable to you. Exiting."
  exit 1
fi

if [ ! -w "${DEST}" ]; then
  echo "Destination directory '$DEST' is not writeable to you. Exiting."
  exit 2
fi

cp build Gemfile Makefile version .gitignore $DEST
