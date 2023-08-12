FROM kalilinux/kali-rolling:latest

EXPOSE 80 443

WORKDIR /app

RUN apt-get update && \
    apt-get install -y git php curl unzip wget jq sendemail && \
    wget -qO- https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz | tar xzv -C /usr/local/bin

#ENTRYPOINT ["tail", "-f", "/dev/null"]