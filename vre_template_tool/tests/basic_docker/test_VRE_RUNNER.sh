#!/bin/bash

###
### Testing example in a local installation
###

# Local installation - EDIT IF REQUIRED

CWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

TEST_DATA_DIR=$CWD
WORKING_DIR=$TEST_DATA_DIR/shared_data/userdata/user_1/run000
TOOL_EXECUTABLE=/home/vre_template_tool/VRE_RUNNER


# Running wrapper tool

if [ -d $WORKING_DIR ]; then
  # shellcheck disable=SC2115
  rm -r $WORKING_DIR/
  mkdir -p $WORKING_DIR
else mkdir -p $WORKING_DIR; fi
cd $WORKING_DIR || exit

echo "--- Test execution: $WORKING_DIR"
echo "--- Start time: $(date)"

time $TOOL_EXECUTABLE --config $TEST_DATA_DIR/config.json --in_metadata $TEST_DATA_DIR/in_metadata.json --out_metadata $WORKING_DIR/out_metadata.json > $WORKING_DIR/tool.log

