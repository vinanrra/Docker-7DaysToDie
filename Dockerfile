FROM ubuntu:18.04

##############BASE IMAGE##############
# Locale
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8
# Need use xterm for LinuxGSM
ENV TERM=xterm
ENV DEBIAN_FRONTEND noninteractive

#Dependencies
RUN dpkg --add-architecture i386 && \
	apt update -y && \
	apt install -y \
		nano \
		iproute2 \
		curl \
		wget \
		file \
		bzip2 \
		gzip \
		unzip \
		bsdmainutils \
		python3 \
		util-linux \
		ca-certificates \
		binutils \
		bc \
		jq \
		tmux \
		lib32gcc1 \
		libstdc++6 \
		libstdc++6:i386 \
		telnet \
		expect
# Clear unused files
RUN rm -rf /var/lib/apt/lists/*     
##############BASE IMAGE##############

##############USER##############
# Add the sdtdserver user
RUN adduser --uid 1001 --disabled-password --shell /bin/bash --disabled-login --gecos "" sdtdserver
RUN chown -R sdtdserver:sdtdserver /home/sdtdserver
WORKDIR /home/sdtdserver
##############USER##############

##############SERVER INSTALL AND CONFIGURATION##############

# Copy config for stable and latest_experimental builds
ADD sdtdserver.cfg sdtdserver.cfg
ADD sdtdserver.cfg.stable sdtdserver.cfg.stable
# Fix permissions
RUN chown sdtdserver:sdtdserver sdtdserver.cfg
RUN chown sdtdserver:sdtdserver sdtdserver.cfg.stable

#Change user
USER sdtdserver

# Script and install
RUN wget -O linuxgsm.sh https://linuxgsm.sh && chmod +x linuxgsm.sh && bash linuxgsm.sh sdtdserver
# Start to create default files
RUN ./sdtdserver
# Update to latest Experimental
ADD install.sh /home/sdtdserver/install.sh

##############EXTRA CONFIG##############
#Ports
EXPOSE 26900 26900/UDP 26901/UDP 26902/UDP 8082 8081
#Shared folders to host
VOLUME /home/sdtdserver/serverfiles/ /home/sdtdserver/.local/share/7DaysToDie/
# Environment
ENV START_MODE "0"
##############EXTRA CONFIG##############
ENTRYPOINT ["sh", "/home/sdtdserver/install.sh"]
