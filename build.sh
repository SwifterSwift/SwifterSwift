#!/bin/sh
# Builds all targets and runs tests.

DERIVED_DATA=${1:-/tmp/SwifterSwift}
echo "Derived data location: $DERIVED_DATA";

set -o pipefail &&
rm -rf $DERIVED_DATA &&
time xcodebuild clean test \
    -project SwifterSwift.xcodeproj \
    -scheme 'SwifterSwift macOS' \
    -sdk macosx10.11 \
    -derivedDataPath $DERIVED_DATA \
    | tee build.log \
    | xcpretty &&
cat build.log &&
rm -rf $DERIVED_DATA &&
time xcodebuild clean test \
    -project SwifterSwift.xcodeproj \
    -scheme 'SwifterSwift tvOS' \
    -sdk appletvsimulator9.2 \
    -derivedDataPath $DERIVED_DATA \
    -destination 'platform=tvOS Simulator,name=Apple TV 1080p' \
    | tee build.log \
    | xcpretty &&
cat build.log &&
rm -rf $DERIVED_DATA &&
time xcodebuild clean test \
    -project SwifterSwift.xcodeproj \
    -scheme 'SwifterSwift iOS' \
    -sdk iphonesimulator9.3 \
    -derivedDataPath $DERIVED_DATA \
    -destination 'platform=iOS Simulator,name=iPhone 7,OS=9.3' \
    | tee build.log \
    | xcpretty &&
cat build.log
