FROM steamcmd/steamcmd:ubuntu-18

##############BASE IMAGE##############

####Environments####

ARG PUID=1000
ARG PGID=1000
ENV PUID=$PUID
ENV PGID=$PGID
ENV START_MODE=0
ENV TEST_ALERT=YES
ENV TimeZone=Europe/Madrid
ENV VERSION=stable

##Need use xterm for LinuxGSM##
ENV TERM=xterm
ENV DEBIAN_FRONTEND noninteractive

####Environments####

#####Dependencies####

RUN dpkg --add-architecture i386 && \
	apt update -y && \
	apt install -y --no-install-recommends \
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
		locales \
		cron

# Install latest su-exec
RUN  set -ex; \
     \
     curl -o /usr/local/bin/su-exec.c https://raw.githubusercontent.com/ncopa/su-exec/master/su-exec.c; \
     \
     fetch_deps='gcc libc-dev'; \
     apt-get install -y --no-install-recommends $fetch_deps; \
     gcc -Wall \
         /usr/local/bin/su-exec.c -o/usr/local/bin/su-exec; \
     chown root:root /usr/local/bin/su-exec; \
     chmod 0755 /usr/local/bin/su-exec; \
     rm /usr/local/bin/su-exec.c; \
     \
     apt-get purge -y --auto-remove $fetch_deps

# Crontab
COPY crontab/sdtdserver-monitor /etc/cron.d/sdtdserver-monitor

# Give execution rights on the cron job and apply cron job
RUN chmod 0644 /etc/cron.d/sdtdserver-monitor && crontab /etc/cron.d/sdtdserver-monitor

# Clear unused files
RUN apt clean && \
    rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*
		
#####Dependencies####

# Locale, Timezone and user
RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && \
    ln -snf /usr/share/zoneinfo/$TimeZone /etc/localtime && echo $TimeZone > /etc/timezone && \
    adduser --disabled-password --shell /bin/bash --disabled-login --gecos "" sdtdserver
ENV LANG en_US.utf8

##############BASE IMAGE##############

# Base dir
WORKDIR /home/sdtdserver

# Add files
ADD install.sh user.sh /home/sdtdserver/
ADD lgsm/config-lgsm/sdtdserver/common.cfg /home/sdtdserver/

# Apply permissions
RUN chmod +x user.sh && chmod +x install.sh

##############EXTRA CONFIG##############
#Ports
EXPOSE 26900 26900/UDP 26901/UDP 26902/UDP 8082 8081 8080
#Shared folders to host
VOLUME /home/sdtdserver/serverfiles/ /home/sdtdserver/.local/share/7DaysToDie /home/sdtdserver/log/ /home/sdtdserver/lgsm/backup/ /home/sdtdserver/lgsm/config-lgsm/sdtdserver/
##############EXTRA CONFIG##############
CMD ["/home/sdtdserver/user.sh", "/home/sdtdserver/install.sh"]
