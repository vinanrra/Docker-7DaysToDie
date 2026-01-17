#!/bin/bash
set -e
if [ "${VERSION,,}" == 'stable'  ] || [ "${VERSION,,}" == 'public'  ]
    then
        if grep -R "branch" "$LSGMSDTDSERVERCFG"
            then
                sed -i "s/branch=.*/branch=\"\"/" "$LSGMSDTDSERVERCFG"
                echo "[INFO] Version changed to ${VERSION,,}"
            else
                echo "[INFO] Selecting 7 days to die ${VERSION,,} version"
        fi
    else
        if grep -R "branch" "$LSGMSDTDSERVERCFG"
            then
                sed -i "s/branch=".*"/branch=\"${VERSION,,}"\"/" "$LSGMSDTDSERVERCFG"
            else
                echo branch=\""${VERSION}"\" >> "$LSGMSDTDSERVERCFG"
                echo "[INFO] Selecting 7 days to die ${VERSION,,} version"
        fi
fi