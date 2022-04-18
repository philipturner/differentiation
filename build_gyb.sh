#!/bin/bash

gyb_sources="$(pwd)/Sources/gyb-sources"
swift_sources="$(pwd)/Sources/Differentiation/"
cd ./gyb-scripts

for file in $(ls "$gyb_sources")
do
  new_length=$(expr ${#file} - 4)
  new_name=${file:0:new_length}
  new_path="${swift_sources}/${new_name}"
  
  old_path="${gyb_sources}/${file}"
  line_directive_path="../gyb-sources/${file}"
  
  echo $new_path
  echo $old_path
  python3 gyb.py "$old_path" -o "$new_path" --line-directive \
    "#sourceLocation(file: \"${line_directive_path}\", line: %(line)d)"
  
  echo $new_name
done
