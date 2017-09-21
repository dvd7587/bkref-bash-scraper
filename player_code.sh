#!/bin/bash

SURNAME=$1
NAME=$2

CODE="${SURNAME:0:5}${NAME:0:2}"
CODE="${CODE,,}"

echo $CODE

