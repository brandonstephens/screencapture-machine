#!/bin/bash
#set -o nounset
#set -o errexit

LOCAL_ROOT=`pwd`
CAPTURE_DIR=captures

# make dir if it doesn't exist
if [ ! -d "$LOCAL_ROOT/$CAPTURE_DIR" ]; then
  mkdir "$LOCAL_ROOT/$CAPTURE_DIR"
fi

START=$(date +"%s")
START_DIR=$CAPTURE_DIR/`date '+%Y-%m-%d_%H.%M.%S'`

mkdir $START_DIR
cd $START_DIR

while read in; do phantomjs $LOCAL_ROOT/lib/responsive-screenshot.js "$in" png false; done < $LOCAL_ROOT/urls.txt

cd $LOCAL_ROOT

mv $LOCAL_ROOT/urls.txt $START_DIR

END=$(date +"%s")
DIFF=$(($END-$START))

echo -e "Capture took $(($DIFF / 60))min $(($DIFF % 60))sec"