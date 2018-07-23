#!/bin/bash
# Called by downloadmake-uni.sh

version=$1;
binary=$2;
dir=$3;

if [ -d crawl-server/$version ]
then
	echo "Copyover failed.";
	exit;
fi

mkdir crawl-server/$version
mkdir crawl-server/$version/source

cp -r $version/$dir/crawl-ref/source/webserver crawl-server/$version/source
cp -r $version/$dir/crawl-ref/source/dat crawl-server/$version/source
cp -r $version/$dir/crawl-ref/source/util crawl-server/$version/source
cp -r $version/$dir/crawl-ref/settings crawl-server/$version/
cp  $version/$dir/crawl-ref/source/$binary crawl-server/$version/source
mkdir crawl-server/$version/source/rcs
mkdir crawl-server/$version/source/rcs/running
mkdir crawl-server/$version/source/rcs/ttyrecs
touch crawl-server/$version/source/rcs/status
rm -rf $version
