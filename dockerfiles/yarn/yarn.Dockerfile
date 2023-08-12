FROM kalilinux/kali-rolling:latest

EXPOSE 80 443

WORKDIR /app

RUN apt-get update && \
    apt-get install -y git php curl unzip wget jq

#ENTRYPOINT ["tail", "-f", "/dev/null"]