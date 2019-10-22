FROM cm2network/steamcmd:root

# Locale
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

ENV DEBIAN_FRONTEND noninteractive

#Dependencies
RUN dpkg --add-architecture i386; apt update; apt install -y nano iproute curl wget file bzip2 gzip unzip bsdmainutils python3 util-linux ca-certificates binutils bc jq tmux lib32gcc1 libstdc++6 libstdc++6:i386 telnet expect

#USER
RUN useradd -ms /bin/bash sdtdserver
WORKDIR /home/sdtdserver
#Directory
RUN mkdir -p /home/sdtdserver/serverfiles/ && mkdir -p /home/sdtdserver/.local/share/7DaysToDie/

USER sdtdserver

#Get Script and install 7 days to die server
RUN wget -O linuxgsm.sh https://linuxgsm.sh && chmod +x linuxgsm.sh && bash linuxgsm.sh sdtdserver
RUN ./sdtdserver auto-install

#Ports
EXPOSE 26900 26900/UDP 26901/UDP 26902/UDP 8082

#Server files and maps
VOLUME /home/sdtdserver/serverfiles/ /home/sdtdserver/.local/share/7DaysToDie/