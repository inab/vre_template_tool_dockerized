#!/bin/bash

###
### Test VRE tool execution (local)
###

######  EDIT IF REQUIRED ##########

# Adapt to your local installation

CWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEST_DATA_DIR=$CWD
TOOL_IMAGE=demo_vre_tool

###### DO NOT EDIT ##############

WORKING_DIR_HOST=$TEST_DATA_DIR/volumes/userdata/user_1/run000
WORKING_DIR_DOCKER=/shared_data/userdata/user_1/run000
TOOL_EXECUTABLE=/home/vre_template_tool/VRE_RUNNER


# Re-generate Tool working directory

if [ -d $WORKING_DIR_HOST ]; then
  echo "--- Cleaning old test execution. Deleting $WORKING_DIR_HOST"
  rm -r $WORKING_DIR_HOST
fi

mkdir -p $WORKING_DIR_HOST
cp data/* $WORKING_DIR_HOST 2>/dev/null
cp *json $WORKING_DIR_HOST
cd $WORKING_DIR

# Run containerized Tool

echo "--- Test execution: $WORKING_DIR_HOST"
echo "--- Start time: $(date)"

echo '# Start time:' $(date) > $WORKING_DIR_HOST/tool.log

cmd="docker run \
	-d --privileged --network=host \
	-e HOST_GID=$(id -g) \
	-e HOST_UID=$(id -u) \
	-v $TEST_DATA_DIR/volumes/public:/shared_data/public_tmp \
	-v $TEST_DATA_DIR/volumes/userdata:/shared_data/userdata_tmp \
	$TOOL_IMAGE \
	$TOOL_EXECUTABLE --config $WORKING_DIR_DOCKER/config.json --in_metadata $WORKING_DIR_DOCKER/in_metadata.json --out_metadata $WORKING_DIR_DOCKER/out_metadata.json --log_file $WORKING_DIR_DOCKER/tool.log
"

echo $cmd
$cmd >>  $WORKING_DIR_HOST/tool.log 2>&1
echo "--- End time: $(date)"
echo "--- Check $WORKING_DIR_HOST"
