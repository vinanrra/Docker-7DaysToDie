FROM ubuntu:18.04

##############BASE IMAGE##############
# Locale
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

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
RUN useradd -ms /bin/bash sdtdserver
WORKDIR /home/sdtdserver
##############USER##############

##############SERVER INSTALL AND CONFIGURATION##############
#Change user
USER sdtdserver

#Script and install
RUN wget -O linuxgsm.sh https://linuxgsm.sh && chmod +x linuxgsm.sh && bash linuxgsm.sh sdtdserver
RUN ./sdtdserver auto-install

# Update to latest Experimental
RUN echo 'branch="-beta latest_experimental"' >> /home/sdtdserver/lgsm/config-lgsm/sdtdserver/sdtdserver.cfg
# Update server
RUN ./sdtdserver update
# Update serverconfig
RUN cp serverfiles/serverconfig.xml serverfiles/sdtdserver.xml
##############SERVER INSTALL AND CONFIGURATION##############

##############EXTRA CONFIG##############
# Need use xterm for LinuxGSM
ENV TERM=xterm
#Ports
EXPOSE 26900 26900/UDP 26901/UDP 26902/UDP 8082
#Shared folders to host
############NEED TO CHECK (FIX PERMISSIONS)############
#VOLUME /home/sdtdserver/serverfiles/ /home/sdtdserver/.local/share/7DaysToDie/
############NEED TO CHECK (FIX PERMISSIONS)############
##############EXTRA CONFIG##############
