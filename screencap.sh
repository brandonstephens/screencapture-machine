#!/bin/bash
#set -o nounset
#set -o errexit

# LOCAL_ROOT=`.`
CAPTURE_DIR='./captures'

# make dir if it doesn't exist
if [ ! -d "$CAPTURE_DIR" ]; then
  mkdir "$CAPTURE_DIR"
fi

START=$(date +"%s")
START_DIR=$CAPTURE_DIR/`date '+%Y-%m-%d_%H.%M.%S'`

# append a line return to make sure last line is processed
sed -i '' -e '$a\' urls.txt

mkdir $START_DIR
# cd $START_DIR

while read in; do 
    phantomjs ./lib/responsive-screenshot.js "$in" png false "$START_DIR/"; 
done < ./urls.txt

# cd $LOCAL_ROOT

mv ./urls.txt $START_DIR

END=$(date +"%s")
DIFF=$(($END-$START))

echo -e "Capture took $(($DIFF / 60))min $(($DIFF % 60))sec"