#!/bin/bash
# clear

RED="\e[31m"
GREEN="\e[32m"
BLUE="\e[34m"
YELLOW="\e[33m"
ENDCOLOR="\e[0m"


# prereqs
apt_update_count=0
# python3-pip python3-venv
(python3 -m pip) >/dev/null 2>&1
if [[ "$?" -eq 1 ]]; then
    echo -e "${YELLOW}Missing required python module${ENDCOLOR}: ${BLUE}pip${ENDCOLOR}. Installing..."
    echo "apt update ..."
    apt-get update >/dev/null 2>&1
    echo "apt install python3-pip -y ..."
    apt-get install python3-pip -y  >/dev/null 2>&1
    ((apt_update_count++))
fi
# verify
(python3 -m pip) >/dev/null 2>&1
if [[ "$?" -eq 1 ]]; then
    echo -e "${RED}ERROR${ENDCOLOR}: Python module failed to install: ${BLUE}pip${ENDCOLOR}"
    exit 1
fi

(python3 -m venv) >/dev/null 2>&1
if [[ "$?" -eq 1 ]]; then
    echo -e "${YELLOW}Missing required python module${ENDCOLOR}: ${BLUE}venv${ENDCOLOR}. Installing..."
    
    if [ $apt_update_count -gt 0 ]; then
        # do not need to re-run apt update...
        a=1
    else
        echo "apt update ..."
        apt-get update >/dev/null 2>&1
    fi
    
    echo "apt install python3-venv -y ..."
    apt-get install python3-venv -y  >/dev/null 2>&1
fi
(python3 -m venv) >/dev/null 2>&1
if [[ "$?" -eq 1 ]]; then
    echo -e "${RED}ERROR${ENDCOLOR}: Python module failed to install: ${BLUE}venv${ENDCOLOR}"
    exit 1
fi


rm -rf venv
python3 -m venv venv
source venv/bin/activate

python3 -m pip install -r requirements.txt --force-reinstall

deactivate

chmod +x *.sh