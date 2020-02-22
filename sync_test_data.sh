#!/bin/bash

LOCAL_COPY_DIR="local"

INSTRUCTIONS_URL="https://github.com/Unidata/thredds-test-data"

RSYNC_SERVER="rsync://sync.unidata.ucar.edu/thredds-test-data/"

#
# Get directory this script
# Taken from https://gist.github.com/TheMengzor/968e5ea87e99d9c41782
#
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
###

TOP_LEVEL_DATA_DIR="${DIR}/${LOCAL_COPY_DIR}"
FULL_TEST_DATA_PATH="${TOP_LEVEL_DATA_DIR}/thredds-test-data"

echo ""
if [ ! -d ${LOCAL_COPY_DIR} ]; 
then
  BANNER="###################################################"
  HASHCHAR="#"
  for (( i=0; i<${#LOCAL_COPY_DIR}; i++ )); do  
    BANNER=${BANNER}$HASHCHAR
  done
  echo "$BANNER"
  echo "# Starting initial sync of THREDDS test data to $LOCAL_COPY_DIR/ #"
  echo "$BANNER"
else
  echo "###############################################"
  echo "# Syncing local copy of the THREDDS test data #"
  echo "###############################################"
fi

rsync --archive --verbose --delete $RSYNC_SERVER $LOCAL_COPY_DIR

echo ""
echo "#############"
echo "# Finished! #"
echo "#############"
echo ""
echo "To ensure the netcdf-java or TDS tests know where the test data live, do one of the following:"
echo "1. Set the location in ~/.gradle/gradle.properties:"
echo ""
echo "  # For tests annotated with NeedsCdmUnitTest"
echo "  systemProp.unidata.testdata.path=${FULL_TEST_DATA_PATH}"
echo ""
echo "2. Set the location from the command line when running gradle for a single test:"
echo ""
echo "  ./gradlew -D\"unidata.testdata.path\"=${FULL_TEST_DATA_PATH} :cdm-test:test --tests ucar.nc2.ft.coverage.TestCoverageCurvilinear"
echo ""
echo "Happy Testing!"
echo ""

