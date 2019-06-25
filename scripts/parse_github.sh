#! /bin/bash

for file in github/*
do
  echo "$file"
  lkml "$file" > /dev/null
done
