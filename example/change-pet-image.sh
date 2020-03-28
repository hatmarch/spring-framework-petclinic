#!/bin/bash

set -e -u -o pipefail

declare SOURCE_IMAGE="PetClinic"

while (($#)); do
    case "$1" in
        -*|--*)
            echo "unknown option."
            exit 1
        ;;
        *)
            SOURCE_IMAGE=$1
            shift 1
            break
            ;;
    esac
done

if [[ -z "$SOURCE_IMAGE" ]]; then
    echo "Must specify source image"
fi

declare -r SCRIPT_DIR=$(cd -P $(dirname $0) && pwd)
declare TARGET_IMAGE=$SCRIPT_DIR/../src/main/webapp/resources/images/pets.png

echo "Replacing $TARGET_IMAGE with $SOURCE_IMAGE."
cp -f $SCRIPT_DIR/$SOURCE_IMAGE $TARGET_IMAGE 
