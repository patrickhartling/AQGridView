#!/bin/bash

set -o errexit

ROOT_DIR=`dirname $0`
cd $ROOT_DIR
ROOT_DIR=`pwd`

[ -e libzxing.a ] && rm -f libzxing.a
[ -e libzxingmm.a ] && rm -f libzxingmm.a

cd $ROOT_DIR
rm -rf build

xcodebuild -arch i386 -target AQGridView -configuration Debug \
   -sdk iphonesimulator5.1 -project AQGridView.xcodeproj
xcodebuild -arch armv6 -arch armv7 -target AQGridView \
   -sdk iphoneos5.1 -project AQGridView.xcodeproj

libtool -static -o $ROOT_DIR/libAQGridView.a \
   ./build/Release-iphoneos/libAQGridView.a \
   ./build/Debug-iphonesimulator/libAQGridView.a
