#!/bin/bash


while read line
do
	
	email=$(echo $line | cut -d',' -f1);
	echo "victim email: " $email
	
	sed -i -E "s/[a-z0-9]+@[a-z]+\.[a-z]{2,3}.mx/$email/g" tmp-netsuite.html	
	
	emailC=$(grep -E "[a-z0-9]+@[a-z]+\.[a-z]{2,3}" tmp-netsuite.html);
	echo "Email Changed:"$emailC;

	sendemail -xu "email-register-smtp" -xp "${SMTP_TOKEN}" -s smtp.gmail.com:587 -f "NetSuite Notification <email-attacker>" -t "$email" -u "NetSuite Password Expiration Warning" -o message-content-type=html -o message-file=tmp-netsuite.html


done < email-netsuite.csv
