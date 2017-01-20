#!/bin/sh
# Builds all targets and runs tests.

DERIVED_DATA=${1:-/tmp/SwifterSwift}
echo "Derived data location: $DERIVED_DATA";

set -o pipefail &&
rm -rf $DERIVED_DATA &&
time xcodebuild clean test \
    -project SwifterSwift.xcodeproj \
    -scheme 'SwifterSwift macOS' \
    -sdk macosx10.12 \
    -derivedDataPath $DERIVED_DATA \
    OTHER_SWIFT_FLAGS='-Xfrontend -debug-time-function-bodies' \
    | tee build.log \
    | xcpretty &&
cat build.log | sh debug-time-function-bodies.sh &&
rm -rf $DERIVED_DATA &&
time xcodebuild clean test \
    -project SwifterSwift.xcodeproj \
    -scheme 'SwifterSwift tvOS' \
    -sdk appletvsimulator10.1 \
    -derivedDataPath $DERIVED_DATA \
    -destination 'platform=tvOS Simulator,name=Apple TV 1080p' \
    OTHER_SWIFT_FLAGS='-Xfrontend -debug-time-function-bodies' \
    | tee build.log \
    | xcpretty &&
cat build.log | sh debug-time-function-bodies.sh &&
rm -rf $DERIVED_DATA &&
time xcodebuild clean test \
    -project SwifterSwift.xcodeproj \
    -scheme 'SwifterSwift iOS' \
    -sdk iphonesimulator10.2 \
    -derivedDataPath $DERIVED_DATA \
    -destination 'platform=iOS Simulator,name=iPad Pro (12.9 inch),OS=10.2' \
    OTHER_SWIFT_FLAGS='-Xfrontend -debug-time-function-bodies' \
    | tee build.log \
    | xcpretty &&
cat build.log | sh debug-time-function-bodies.sh
