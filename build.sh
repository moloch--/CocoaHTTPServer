#!/bin/sh

SDK=$(ls -1d /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iP* | tail -n1)
echo $SDK

# remove object files to build nice n clean
echo '[+] Removing old object files ...'
rm *.o *.a

# compile the Objective-C stuff
echo '[+] Compiling Objective-C files ...'
clang -c *.m -arch armv7 -isysroot $SDK -Wno-arc-bridge-casts-disallowed-in-nonarc -Wno-trigraphs -fobjc-arc -I /usr/include/libxml2

# See Makefile.* in the parent directory.
echo '[+] Creating CocoaHTTPServer.a archive'
ar -r CocoaHTTPServer.a *.o >/dev/null 2>&1

if [ -d ../../libs ]; then
    echo '[+] Copying CocoaHTTPServer.a into libs/'
    cp CocoaHTTPServer.a ../../libs/
fi
echo '[+] The CocoaHTTPServer libraries were copied into into libs/ directory. My work is done.'
