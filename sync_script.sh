#!/bin/bash

source_dir="/tmp/gamedir/"
target_dir="/home/hlds_user/hlds/valve/"

echo "Sync game files started..."
rsync -aAX --chown=hlds_user:hlds_user "$source_dir" "$target_dir"
echo "Sync game files completed."
