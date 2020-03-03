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

printf "\n\t\t${BLUE}$(bold WELCOME TO SHTOCK MARKET - A COMMAND LINE TOOL TO INSTANLY ACCESS YOUR SHTOCK DATA.)"










echo -e "\n${YELLOW}Enter Ticker Symbol: ${CYAN}"
read ticker



curl -s https://finance.yahoo.com/quote/$ticker | html2text > tmp.txt
price=$(sed -n '19,19p' tmp.txt)

posorneg=$(sed -n '20,1p' tmp.txt)

if [[ ${posorneg:0:1} == "-" ]] ; then echo -e "${NC}\nCurrent Price: ${RED}\$${price//\"}${NC}"; else echo -e "${NC}\nCurrent Price: ${GREEN}\$${price//\"}${NC}"; fi

# echo "${posorneg}"
# echo -e "\nCurrent Price: \$${price//\"}${NC}"

rm tmp.txt




echo -e "\n${YELLOW}Enter Year: \nYYYY${CYAN}"
read now_year
echo -e "\n${YELLOW}Enter Month: \nMM${CYAN}"
read now_month
echo -e "\n${YELLOW}Enter Day: \nDD${CYAN}"
read now_day
now="\"${now_year}-${now_month}-${now_day}\""
# echo "$now"
# now=$(date "+%Y-%m-%d")
# now="\"2020-03-02\""

data_compare=$(curl --silent 'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY_ADJUSTED&symbol='$ticker'&outputsize=full&apikey=KD4V1YVMGPG21B9G' | jq '.bla')
data=$(curl --silent 'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY_ADJUSTED&symbol='$ticker'&outputsize=full&apikey=KD4V1YVMGPG21B9G' | jq '."Time Series (Daily)".'$now'."1. open"')
# echo $data
if [ "$data" = "$data_compare" ]
then
  echo -e "\n\n${RED}Market Data Unavailable. Market was closed that day.${NC}"

else
  echo -e "\n\n${PINK}Open Value: \$${data//\"}${NC}"
fi
