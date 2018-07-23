#!/bin/bash
# Called by downloadmake-uni.sh

main=$(pwd)/crawl-server;
version=$1;
binary=$2;
display=$3;

printf "    (\"dcss-web-$version\", dict(\n        name = \"$display\",\n        crawl_binary = \"$main/$version/source/$binary\",\n        rcfile_path = \"$main/$version/source/rcs/\",\n        macro_path = \"$main/$version/source/rcs/\",\n        morgue_path = \"$main/morgue/%n/$version\",\n        inprogress_path = \"$main/$version/source/rcs/running\",\n        ttyrec_path = \"$main/$version/source/rcs/ttyrecs/%n\",\n        socket_path = \"$main/$version/source/rcs\",\n        client_path = \"$main/$version/source/webserver/game_data/\",\n        morgue_url = None,\n        send_json_options = True)),\n    (\"sprint-web-$version\", dict(\n        name = \"Sprint $display\",\n        crawl_binary = \"$main/$version/source/$binary\",\n        rcfile_path = \"$main/$version/source/rcs/\",\n        macro_path = \"$main/$version/source/rcs/\",\n        morgue_path = \"$main/morgue/%n/$version\",\n        inprogress_path = \"$main/$version/source/rcs/running\",\n        ttyrec_path = \"$main/$version/source/rcs/ttyrecs/%n\",\n        socket_path = \"$main/$version/source/rcs\",\n        client_path = \"$main/$version/source/webserver/game_data/\",\n        morgue_url = None,\n        send_json_options = True,\n        options = [\"-sprint\"])),\n\n" >> $main/gamesdict.txt
