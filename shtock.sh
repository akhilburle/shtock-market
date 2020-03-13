#!/bin/bash

clear
BLUE='\033[0;34m'
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
PINK='\033[0;95m'
ansi()          { echo -e "\e[${1}m${*:2}\e[0m"; }
bold()          { ansi 1 "$@"; }

# while getopts ":p" opt; do
  case $1 in
    -s|-\?|--show)
      printf "\n${BLUE}$(bold Your Portfolio:)\n"
      touch portfolio.txt
      cat portfolio.txt
      ;;
    -d|--data)
      . ./data.sh

      ;;
  esac
