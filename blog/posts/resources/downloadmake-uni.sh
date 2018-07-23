#!/bin/bash

# Usage:
# ./downloadmake-uni.sh <release> <version/trunk>
#
# Ex: ./downloadmake-uni.sh x-crawl v1.2
# Ex: ./downloadmake-uni.sh crawl trunk
# Ex: ./downloadmake-uni.sh gooncrawl trunk
#
# <version> should match the git tag or branch of the release version

build=$(pwd);
release=$1;
version=$2;

if [ -d $version ]
then
	echo "Directory $version already exists";
	exit;
fi

mkdir $version
cd $version

url="https://github.com/crawl/crawl";
trunkbranch=master;
trunkver=trunk;
binary=crawl;
display=$version;
dir=crawl;

case $1 in
	yiufcrawl )
		url="https://github.com/yrmvgh/yiufcrawl";
		binary=yiufcrawl;
		dir=yiufcrawl;
		trunkver=yiufcrawl-trunk;
		;;
	x-crawl )
		url="https://github.com/Vajrapani/X-Crawl";
		display="X-Crawl-$version";
		dir="X-Crawl";
		trunkver=x-crawl-trunk;
		;;
	gnollcrawl )
		url="https://github.com/Dracunos/gnollcrawl";
		dir=gnollcrawl;
		trunkver=gnollcrawl-trunk;
		;;
	gooncrawl )
		url="https://github.com/Floodkiller/crawl";
		trunkbranch=gooncrawl;
		display="gooncrawl-$version";
		trunkver=gooncrawl-trunk;
		;;
	crawl )
		;;
esac

if [ $version == "trunk" ]
then
	version=$trunkver
	git clone $url --single-branch --branch $trunkbranch --depth 1
else
	git clone $url --branch $version --single-branch --depth 1
fi

cd $dir/crawl-ref/source || (echo "Git clone failed" && exit)
git submodule update --init

if [ $version == $trunkver ]
then
	echo 0.0-trunk0 > util/release_ver
else
	echo $version > util/release_ver
fi

# Running this on something like an ODROID with >4 cores? Crank -j up!
# A pi 3 B+ can run out of memory while compiling if -j is >2.
make WEBTILES=y -j 2

if [ ! -f ./$binary ]
then
	echo "Make failed. Exiting downloadmake-uni.sh"
	exit;
fi

cd $build

./copyover-uni.sh $version $binary $dir

./makeconfig-uni.sh $version $binary $display
