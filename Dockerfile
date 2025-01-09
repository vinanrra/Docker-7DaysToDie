FROM steamcmd/steamcmd:ubuntu-24

STOPSIGNAL SIGTERM

##############BASE IMAGE##############

####Labels####
LABEL maintainer="vinanrra"
LABEL build_version="version: 0.7.8"

####Environments ####
##Need use xterm for LinuxGSM##
ENV DEBIAN_FRONTEND=noninteractive \
	HOME=/home/sdtdserver \
	LANG=en_US.utf8 \
	TERM=xterm \
	TimeZone=Europe/Madrid

#####Dependencies####

# LinuxGSM dependencies
RUN dpkg --add-architecture i386 && \
	apt update -y && \
	apt install -y --no-install-recommends \
		bc \
		binutils \
		bsdmainutils \
		bzip2 \
		ca-certificates \
		cpio \
		cron \
		curl \
		distro-info \
		expect \
		file \
		git \
		gzip \
		iproute2 \
		jq \
		lib32gcc-s1 \
		lib32stdc++6 \
		libgdiplus \
		libsdl2-2.0-0:i386 \
		libstdc++6 \
		libstdc++6:i386 \
		libxml2-utils \
		locales \
		nano \
		netcat-openbsd \
		python3 \
		tclsh \
		telnet \
		tmux \
		unrar \
		unzip \
		util-linux \
		uuid-runtime \
		wget \
		xz-utils \
    pigz

# Install NodeJS
RUN curl -SLO https://deb.nodesource.com/nsolid_setup_deb.sh; \
		chmod 500 nsolid_setup_deb.sh; \
		./nsolid_setup_deb.sh 22; \
		apt-get install nodejs -y

# Install gamedig
RUN  npm install -g gamedig

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

ENV ALLOC_FIXES=no ALLOC_FIXES_UPDATE=no \
	BACKUP=no BACKUP_HOUR=5 BACKUP_MAX=7 \
	BEPINEX=no BEPINEX_UPDATE=no \
	CHANGE_CONFIG_DIR_OWNERSHIP=YES \
	CPM=no CPM_UPDATE=no \
	DARKNESS_FALLS_URL=False DARKNESS_FALLS=no DARKNESS_FALLS_UPDATE=no \
	LINUXGSM_VERSION=v24.3.4 \
	PUID=1000 PGID=1000 \
	START_MODE=0 \
	TEST_ALERT=no MONITOR=no \
	UNDEAD_LEGACY=no UNDEAD_LEGACY_VERSION=stable UNDEAD_LEGACY_UPDATE=no UNDEAD_LEGACY_URL=False \
	UPDATE_MODS=no \
	VERSION=stable

# Remove default user ubuntu
RUN deluser --remove-home ubuntu

# Create user and fix permissions - chown shouldn't be necessary check adduser command
RUN adduser --home /home/sdtdserver --disabled-password --shell /bin/bash --disabled-login --gecos "" sdtdserver \
	&& chown -R sdtdserver:sdtdserver /home/sdtdserver

#Set ulimit as recommended by the game.
RUN  echo 'sdtdserver soft nofile 10240' >> /etc/security/limits.conf

# Base dir
WORKDIR /home/sdtdserver

# Download LinuxGSM scripts
RUN git clone --depth 1 --branch $LINUXGSM_VERSION https://github.com/GameServerManagers/LinuxGSM.git
RUN cp LinuxGSM/linuxgsm.sh linuxgsm.sh && chmod +x linuxgsm.sh && su-exec sdtdserver bash linuxgsm.sh sdtdserver

##############BASE IMAGE##############

# Add files
COPY --chmod=755 install.sh user.sh /home/sdtdserver/
COPY --chmod=755 scripts/ /home/sdtdserver/scripts

##############EXTRA CONFIG##############
#Ports
EXPOSE 26900 26900/UDP 26901/UDP 26902/UDP 8082 8081 8080

#Shared folders to host
VOLUME /home/sdtdserver/serverfiles/ /home/sdtdserver/.local/share/7DaysToDie /home/sdtdserver/log/ /home/sdtdserver/lgsm/backup/ /home/sdtdserver/lgsm/config-lgsm/sdtdserver/
##############EXTRA CONFIG##############

ENTRYPOINT ["/home/sdtdserver/user.sh"]
