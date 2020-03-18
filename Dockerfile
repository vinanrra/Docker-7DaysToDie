FROM ubuntu:18.04

##############BASE IMAGE##############

####Environments####

ARG PUID=1000
ARG PGID=1000
ENV PUID=$PUID
ENV PGID=$PGID
ENV START_MODE "0"

##Need use xterm for LinuxGSM##
ENV TERM=xterm
ENV DEBIAN_FRONTEND noninteractive

####Environments####

# Locale
RUN apt-get update && apt-get install -y locales
RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

#Dependencies
RUN add-apt-repository multiverse && \
    dpkg --add-architecture i386 && \
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
		lib32stdc++6 \
		libstdc++6 \
		libstdc++6:i386 \
		telnet \
		expect \
		netcat \
		steamcmd

# Install latest su-exec
RUN  set -ex; \
     \
     curl -o /usr/local/bin/su-exec.c https://raw.githubusercontent.com/ncopa/su-exec/master/su-exec.c; \
     \
     fetch_deps='gcc libc-dev'; \
     apt-get install -y --no-install-recommends $fetch_deps; \
     rm -rf /var/lib/apt/lists/*; \
     gcc -Wall \
         /usr/local/bin/su-exec.c -o/usr/local/bin/su-exec; \
     chown root:root /usr/local/bin/su-exec; \
     chmod 0755 /usr/local/bin/su-exec; \
     rm /usr/local/bin/su-exec.c; \
     \
     apt-get purge -y --auto-remove $fetch_deps

# Clear unused files

RUN apt clean && \
    rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

RUN adduser --disabled-password --shell /bin/bash --disabled-login --gecos "" sdtdserver

##############BASE IMAGE##############

WORKDIR /home/sdtdserver
ADD user.sh /home/sdtdserver/user.sh
ADD install.sh /home/sdtdserver/install.sh
ADD sdtdserver.cfg.stable sdtdserver.cfg.stable
ADD sdtdserver.cfg sdtdserver.cfg
RUN chmod +x user.sh && chmod +x install.sh

##############EXTRA CONFIG##############
#Ports
EXPOSE 26900 26900/UDP 26901/UDP 26902/UDP 8082 8081 8080
#Shared folders to host
VOLUME /home/sdtdserver/serverfiles/ /home/sdtdserver/.local/share/7DaysToDie
##############EXTRA CONFIG##############
CMD ["/home/sdtdserver/user.sh", "/home/sdtdserver/install.sh"]
