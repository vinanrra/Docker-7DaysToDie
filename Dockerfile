FROM steamcmd/steamcmd:ubuntu-18

STOPSIGNAL SIGTERM

##############BASE IMAGE##############

####Labels####
LABEL maintainer="vinanrra"
LABEL build_version="version: 0.5.1"

####Environments ####
ENV TimeZone=Europe/Madrid HOME=/home/sdtdserver LANG=en_US.utf8 TERM=xterm DEBIAN_FRONTEND=noninteractive

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
		libxml2-utils \
		telnet \
		expect \
		netcat \
		locales \
		libgdiplus \
		cron \
		tclsh \
		cpio \
		libsdl2-2.0-0:i386 \
		xz-utils \
		distro-info \
		git

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

# Create user and fix permissions - chown shouldn't be necessary check adduser command
RUN adduser --home /home/sdtdserver --disabled-password --shell /bin/bash --disabled-login --gecos "" sdtdserver \
	&& chown -R sdtdserver:sdtdserver /home/sdtdserver

##Need use xterm for LinuxGSM##
ENV PUID=1000 PGID=1000 \
	START_MODE=0 \
	TEST_ALERT=no MONITOR=no BACKUP=no\
	VERSION=stable \
	UPDATE_MODS=no \
	ALLOC_FIXES=no ALLOC_FIXES_UPDATE=no \
	UNDEAD_LEGACY=no UNDEAD_LEGACY_VERSION=stable UNDEAD_LEGACY_UPDATE=no UNDEAD_LEGACY_URL=False \
	ENZOMBIES=no ENZOMBIES_ADDON_SNUFKIN=no ENZOMBIES_ADDON_ROBELOTO=no ENZOMBIES_ADDON_NONUDES=no ENZOMBIES_UPDATE=no \
	CPM=no CPM_UPDATE=no \
	BEPINEX=no BEPINEX_UPDATE=no \
	CHANGE_CONFIG_DIR_OWNERSHIP=YES \
	DARKNESS_FALLS_URL=False DARKNESS_FALLS=no DARKNESS_FALLS_UPDATE=no

# Base dir
WORKDIR /home/sdtdserver

# Download LinuxGSM scripts
RUN wget -O linuxgsm.sh https://linuxgsm.sh && chmod +x linuxgsm.sh && su-exec sdtdserver bash linuxgsm.sh sdtdserver

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
