# Changelog
* **26/10/2021**
  * Fixed crontab not working
  * MAYBE fixed 7 Days To Die server not being when container stop
  * Added backup info in README
  * Removed unused LGSM files
  * Added Github Actions

* **26/10/2021**
  * Update readme
  * Added automatic backup
  * Added automatic monitorization (This will restart server if goes down)
  * Update LGSM version

* **22/01/2021**
  * Added clean stop when Docker stop signal its send
  * Fixed Changelog link
  
* **25/12/2020**
  * Updated LinuxGSM scripts
  * Added missing dependencies
  * Fixed SteamCMD updates

* **25/10/2020**
  * Added initial support for Alloc Fixes

* **24/09/2020**
  * Updated Linuxgsm scripts

* **28/08/2020**
  * Fixed space check

* **30/06/2020**
  * Fixed version install

* **23/06/2020**
  * Added check space
  * Installation file has been split

* **19/06/2020**
  * Added labels

* **18/05/2020**
  * Updated LinuxGSM scripts.
  * Fixed container start, switched to ENTRYPOINT.

* **12/05/2020**
  * Improved read, added information.

* **31/03/2020**
  * Added START_MODE 0, this mode will install server and exit

* **29/03/2020**
  * Improved updated method
  * Remove useless START_MODES because of new update method
  * Added alerts when server is down

* **27/03/2020**
  * Added TimeZone
  * Added back Support Info
  * Improved Dockerfile

* **24/03/2020**
  * Improved install script
  * Added new START_MODE (Backup)
  * Added log folder

* **18.03.2020:**
  * Improved install method
  * Change base image to SteamCMD
  * Fixed dependencies

* **08.02.2020:**
  * Improved messages they are now more precise and give better info.

* **01.02.2020:**
  * Fixed script path
  * Improved messages they are now more visual
  * Improved install script, now the server will detect if its installed or not
  * Cleanup Readme
  * Added WebAdmin port

* **31.01.2020:**
  * Cleaned and improved Dockerfile
  * Added notification for each stage
  * Fixed user creation and folder permissions

* **30.01.2020:**
  * Improved user creation with custom UID and GID
  * Updated readme (PGID and PUID, docker-compose and docker ENVs)

* **25.10.2019:**
  * Added ENV START_MODE
  * Fixed version config files path

* **24.10.2019:**
  * Initial Release.
