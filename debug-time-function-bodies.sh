#!/bin/sh

# Pipe the output of xcodebuild to this script to see the slowest 10 functions to compile.
# Use this flag with xcodebuild: OTHER_SWIFT_FLAGS='-Xfrontend -debug-time-function-bodies'

echo "\nSlowest functions to compile:\n"
grep '^[0-9]\+\.[0-9]\+' | sed 's/\(^[0-9]*.[0-9]*\)\([a-z]*\)/\1 \2/' | sort -k2,2r -k1,1nr | sed 's/\(^[0-9]*.[0-9]*\) \([a-z]*\)/\1\2/' | head -n 10 | sed 's/^/    /'
echo "\n"
