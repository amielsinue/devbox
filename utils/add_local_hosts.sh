#!/bin/bash
declare profiles_path="../*/"
declare hosts_file="/etc/hosts"
declare hosts_content=$( cat "${hosts_file}" )

for dir in ${profiles_path}
do
    dir=${dir%*/}
	dir=${dir##*/}
	host=`echo "$dir" | sed -e "s/\.com/.net/g"`
    row="10.10.10.10\t${host}"
    regex="${host}"
    echo $regex
	if [[ " $hosts_content " =~ $regex ]]
      then
        echo "Already in hosts: $host"
      else
        sudo echo "10.10.10.10    ${host}" >> $hosts_file
  fi
done
