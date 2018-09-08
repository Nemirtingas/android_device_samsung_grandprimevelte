#!/bin/sh

VENDOR=samsung
DEVICE=grandprimevelte

BASE=../../../vendor/$VENDOR/$DEVICE/proprietary

echo "Pulling device files..."
for FILE in `cat proprietary-files.txt | grep -v ^# | grep -v ^$`; do
    DIR=`dirname $FILE`
    if [ ! -d $BASE/$DIR ]; then
        mkdir -p $BASE/$DIR
    fi
    cp ~/system/$FILE $BASE/$FILE
done

./setup-makefiles.sh
