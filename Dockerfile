FROM steamcmd/steamcmd:ubuntu-18

STOPSIGNAL SIGTERM

##############BASE IMAGE##############

####Labels####
LABEL maintainer="vinanrra"
LABEL build_version="version: 0.2.7"

####Environments####

ARG PUID=1000
ARG PGID=1000
ENV PUID=$PUID
ENV PGID=$PGID
ENV START_MODE=0
ENV TEST_ALERT=no
ENV TimeZone=Europe/Madrid
ENV VERSION=stable
ENV ALLOC_FIXES=no
ENV UNDEAD_LEGACY=no
ENV UNDEAD_LEGACY_VERSION=stable
ENV MONITOR=no
ENV BACKUP=no
ENV HOME=/home/sdtdserver
ENV LANG en_US.utf8
ENV BACKUP_TIMER="0 5 * * *"

##Need use xterm for LinuxGSM##
ENV TERM=xterm
ENV DEBIAN_FRONTEND noninteractive

####Environments####

#####Dependencies####

# LinuxGSM dependencies
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
		libgdiplus \
		cron \
		tclsh \
		cpio \
		libsdl2-2.0-0:i386 \
		xz-utils

# Install gamedig
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - ; \
	apt install -y nodejs && npm install -g gamedig

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

# Clear unused files
RUN apt clean && \
    rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*
		
#####Dependencies####

# Locale, Timezone and user
RUN adduser --home /home/sdtdserver --disabled-password --shell /bin/bash --disabled-login --gecos "" sdtdserver

##############BASE IMAGE##############

# Base dir
WORKDIR /home/sdtdserver

# Add files
ADD install.sh user.sh /home/sdtdserver/
ADD scripts /home/sdtdserver/scripts

# Apply permissions
RUN chown -R sdtdserver:sdtdserver /home/sdtdserver && chmod +x install.sh user.sh && find /home/sdtdserver/scripts/ -type f -exec chmod 744 {} \;

# Add LinuxGSM scripts
RUN wget -O linuxgsm.sh https://linuxgsm.sh && chmod +x linuxgsm.sh && su-exec sdtdserver bash linuxgsm.sh sdtdserver

##############EXTRA CONFIG##############
#Ports
EXPOSE 26900 26900/UDP 26901/UDP 26902/UDP 8082 8081 8080
#Shared folders to host
VOLUME /home/sdtdserver/serverfiles/ /home/sdtdserver/.local/share/7DaysToDie /home/sdtdserver/log/ /home/sdtdserver/lgsm/backup/ /home/sdtdserver/lgsm/config-lgsm/sdtdserver/
##############EXTRA CONFIG##############

ENTRYPOINT ["/home/sdtdserver/user.sh"]
