#!/bin/bash

set -e # Exit on error

BASEPATH="/home/sdtdserver"
SERVERFILES_FOLDER="${BASEPATH}/serverfiles"
CONFIG_FILE="${SERVERFILES_FOLDER}/7DaysToDieServer_Data/MonoBleedingEdge/etc/mono/config"
LSGMSDTDSERVERCFG="${BASEPATH}/lgsm/config-lgsm/sdtdserver/sdtdserver.cfg"
SERVER_CONFIG="${SERVERFILES_FOLDER}/sdtdserver.xml"
UNDEAD_LEGACY_VERSION="${UNDEAD_LEGACY_VERSION,,}"

determine_version_and_url() {
    if [ "${UNDEAD_LEGACY_URL}" != "False"  ]; then
        DL_LINK="${UNDEAD_LEGACY_URL}"
        echo "[Undead Legacy] Using custom provided url ${DL_LINK}"
    elif [ "${UNDEAD_LEGACY_VERSION}" == 'exp'  ] || [ "${UNDEAD_LEGACY_VERSION}" == 'stable'  ]; then
        echo "[Undead Legacy] Starting install of Undead Legacy ${UNDEAD_LEGACY_VERSION} version"
        MIRROR_EXT=zip
        DL_LINK="https://ul.subquake.com/dl?v=${UNDEAD_LEGACY_VERSION}"
    elif  [ "${UNDEAD_LEGACY_VERSION}" == 'stable2'  ]; then
        echo "[Undead Legacy] Starting install of Undead Legacy ${UNDEAD_LEGACY_VERSION} version from mirror"
        MIRROR_EXT=tar
        DL_LINK="https://ul.subquake.com/dl?v=${UNDEAD_LEGACY_VERSION}"
    else
        echo "[Undead Legacy] Error: wrong version selected -> ${UNDEAD_LEGACY_VERSION}. Select exp, stable or provide a custom URL."
        exit 1
    fi
    MIRROR_FILE="undeadlegacy.${MIRROR_EXT:-zip}"
}

download_and_extract() {
    echo "[Undead Legacy] Downloading release from $DL_LINK"
    curl "$DL_LINK" -SsL -o "${MIRROR_FILE}"
    
    echo "[Undead Legacy] Extracting files"
    mkdir -p undeadlegacy-temp
    if [[ "${MIRROR_FILE}" == *.tar ]]; then
        tar -xf "${MIRROR_FILE}" -C undeadlegacy-temp
    else
        unzip -q "${MIRROR_FILE}" -d undeadlegacy-temp
    fi
}

install_mod_files() {
    if [ -d "$SERVERFILES_FOLDER/BepInEx" ]; then
        echo "[Undead Legacy] Removing existing BepInEx (Undead Legacy includes its own version)"
        rm -rf "$SERVERFILES_FOLDER/BepInEx"
        rm -rf "$SERVERFILES_FOLDER/doorstop_libs"
    fi

    echo "[Undead Legacy] Installing mod files"
    if [ "${UNDEAD_LEGACY_VERSION}" == 'exp'  ]; then
        cp -a undeadlegacy-temp/UndeadLegacyExperimental-main/. "$SERVERFILES_FOLDER"
    else
        # Default for stable and stable2
        cp -a undeadlegacy-temp/UndeadLegacyStable-main/. "$SERVERFILES_FOLDER"
    fi
}

cleanup() {
    echo "[Undead Legacy] Cleanup"
    rm -f "${MIRROR_FILE}"
    rm -rf undeadlegacy-temp
}

patch_server_config() {
    if [ "${UNDEAD_LEGACY_URL}" == "False"  ]; then
        echo "[Undead Legacy] Adding Undead Legacy default options to server configuration"
        if ! grep -q "Undead Legacy specific options" "$SERVER_CONFIG"; then
            sed -i '$i\ '\\r\\t'<!-- Undead Legacy specific options -->'\\r\\t'<property name="RecipeFilter"\tvalue="0"/>'\\r\\t'<property name="StarterQuestEnabled"\tvalue="true"/>'\\r\\t'<property name="WanderingHordeFrequency"\tvalue="4"/>'\\r\\t'<property name="WanderingHordeRange"\tvalue="8"/>'\\r\\t'<property name="WanderingHordeEnemyCount"\tvalue="5"/>'\\r\\t'<property name="WanderingHordeEnemyRange"\tvalue="10"/>'\\r\\t'<property name="DeathPenalty" value="3"/>'\\r\\t'<property name="POITierLootScale" value="0"/>' "$SERVER_CONFIG"
        fi
    fi

    echo "[Undead Legacy] Disabling EAC"
    sed -i '/.*EACEnabled.*/ s/true/false/' "$SERVER_CONFIG"
}

patch_mono_config() {
    echo "[Undead Legacy] Adding missing dll to mono config"
    if ! grep -q "libdl.so.2" "$CONFIG_FILE"; then
        sed -i '$i\ '\\t'<dllmap dll="dl" target="libdl.so.2"\/>' "$CONFIG_FILE"
    fi
}

patch_startup_script() {
    echo "[Undead Legacy] Fixing permissions and startup script"
    chmod +x "$SERVERFILES_FOLDER/run_bepinex_server.sh"
    
    if ! grep -q "sdtdserver.xml" "$SERVERFILES_FOLDER/run_bepinex_server.sh"; then
        sed -i '/.*config_file="serverconfig.xml".*/ s/serverconfig.xml/sdtdserver.xml/' "$SERVERFILES_FOLDER/run_bepinex_server.sh"
    fi
}

patch_lgsm_config() {
    echo "[Undead Legacy] Patching LinuxGSM configuration"
    
    # Query Delay
    if grep -q "querydelay" "$LSGMSDTDSERVERCFG"; then
        sed -i 's/querydelay=.*/querydelay="10"/' "$LSGMSDTDSERVERCFG"
    else
        echo 'querydelay="10"' >> "$LSGMSDTDSERVERCFG"
    fi

    # Start Parameters
    if grep -q "startparameters" "$LSGMSDTDSERVERCFG"; then
        sed -i 's/startparameters=.*/startparameters=""/' "$LSGMSDTDSERVERCFG"
    else
        echo 'startparameters=""' >> "$LSGMSDTDSERVERCFG"
    fi

    # Executable
    if grep -q "executable" "$LSGMSDTDSERVERCFG"; then
        sed -i 's/executable=.*/executable=".\/run_bepinex_server.sh"/' "$LSGMSDTDSERVERCFG"
    else
        echo 'executable="./run_bepinex_server.sh"' >> "$LSGMSDTDSERVERCFG"
    fi
}

# --- Main Execution ---

# 1. Mod Installation Logic
determine_version_and_url
download_and_extract
install_mod_files
cleanup

# 2. Server Configuration Patching Logic
# These only run if the above succeeded due to 'set -e'
patch_server_config
patch_mono_config
patch_startup_script
patch_lgsm_config

echo "[Undead Legacy] Installed ヽ(´▽\`)/"
