#! /bin/bash

mkdir github/errored

for file in github/*
do
  echo "$file"
  if ! lkml "$file" > /dev/null; then
    cp "$file" github/errored
  fi
done
