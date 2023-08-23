# mod-blackeye
modified blackeye phishing script, to add into some server catch credentials

# Previous to install blackeye. It was installed at CentoS Stream 8
- yum upgrade
- yum install yum-utils http://rpms.remirepo.net/enterprise/remi-release-8.rpm
- yum install php php-fpm
- just in case: yum install jq

# Some steps to launch process
- configure ngrok in this path: /usr/local/bin
- configure ngrok.yml at /root/.configure/ngrok/ngrok.yml
  - authtoken: <token>
  - web_addr: 0.0.0.0:4040
  - api_key: <token>
  - log: /var/log/ngrok.log
- systemclt stop firewalld

# Use sendemail cmd to send email across kali CLI
- sendemail -xu <email proxy> -xp <password> -s smtp-relay.sendinblue.com:587 -f "sender name <sender@domain.com.mx>" -t "inbox@domain.com.mx" -u "subject" -o message-content-type=html -o message-file=tmp-<name project>.html
