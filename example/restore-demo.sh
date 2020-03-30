#!/bin/bash

set -e -u -o pipefail

# while (($#)); do
#     case "$1" in
#         -*|--*)
#             echo "unknown option."
#             exit 1
#         ;;
#         *)
#             SOURCE_IMAGE=$1
#             shift 1
#             break
#             ;;
#     esac
# done

# if [[ -z "$SOURCE_IMAGE" ]]; then
#     echo "Must specify source image"
# fi

declare -r SCRIPT_DIR=$(cd -P $(dirname $0) && pwd)

# Start with the ugly pet image to fix later on
$SCRIPT_DIR/change-pet-image.sh ugly-pet-2.png

# reset the welcome page
declare WELCOME_PAGE_PATH=$SCRIPT_DIR/../src/main/webapp/WEB-INF/jsp/welcome.jsp
echo "Reseting welcome page"
cp -f $SCRIPT_DIR/welcome-original.jsp $WELCOME_PAGE_PATH