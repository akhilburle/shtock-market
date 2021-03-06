printf "\n\t\t${BLUE}$(bold WELCOME TO SHTOCK MARKET - A COMMAND LINE TOOL TO INSTANLY ACCESS YOUR SHTOCK DATA.)"



    touch portfolio.txt






    echo -e "\n${YELLOW}Enter Ticker Symbol: ${CYAN}"
    read ticker

    echo "$ticker" >> portfolio.txt

    get_price()
    {
      curl -s https://finance.yahoo.com/quote/$ticker | html2text > tmp.txt
      price=$(sed -n '19,19p' tmp.txt)

      if [[ ${price:0:1} == "S" ]] ; then echo -e "${RED}Wrong Ticker Symbol! Exiting ... ${NC}"; exit 0; fi

      posorneg=$(sed -n '20,1p' tmp.txt)

      if [[ ${posorneg:0:1} == "-" ]] ; then echo -e "${NC}\nCurrent Price: ${RED}\$${price//\"}  [${posorneg}]${NC}"; else echo -e "${NC}\nCurrent Price: ${GREEN}\$${price//\"}  [${posorneg}]${NC}"; fi

      # echo "${posorneg}"
      # echo -e "\nCurrent Price: \$${price//\"}${NC}"

      # cat tmp.txt

      # python3 chart.py ${ticker}
      # open pic.png
      # rm pic.png
      rm tmp.txt
    }


    spin()
    {
      spinner="/|\-/|\-"
      while :
      do
        for i in `seq 0 7`
        do
          echo -n "${spinner:$i:1}"
          echo -en "\010"
          sleep 0.5
        done
      done
    }

    # spin &
    # SPIN_PID=$!
    # trap "kill $SPIN_PID" `seq 0 15`
    get_price
    # trap "kill $SPIN_PID; echo -e "\b"" `seq 0 15`
    # kill $SPIN_PID
    # echo -e "\b"

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
    data1=$(curl --silent 'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY_ADJUSTED&symbol='$ticker'&outputsize=full&apikey=KD4V1YVMGPG21B9G' | jq '."Time Series (Daily)".'$now'')
    string=${data1#"{"}
    string=${string%"}"}
    data=$string
    if [ "$data1" = "$data_compare" ]
    then
      echo -e "\n${RED}Market Data Unavailable. Market was closed that day.${NC}"

    else
      echo -e "\n${PINK}${data//\"}${NC}"
    fi
