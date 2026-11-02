#!/bin/bash
#
# Type-checks each extension file on its own, with no package and no other files, for every Apple platform. A file
# that passes compiles as is when it's copied into a project.
#
# Usage, from the repository root on macOS:
#
#     scripts/check-standalone.sh                          # every extension
#     scripts/check-standalone.sh Sources/…/A.swift …      # only the given files
#
# Set JOBS to change how many files are checked in parallel (default: 4).
#
set -u
JOBS=${JOBS:-4}

check_file() {
    local file=$1
    local features=(
        -enable-upcoming-feature ExistentialAny
        -enable-upcoming-feature MemberImportVisibility
        -enable-upcoming-feature NonisolatedNonsendingByDefault
        -enable-upcoming-feature InferIsolatedConformances
    )
    local configs=(
        "macosx arm64-apple-macos14.0"
        "iphonesimulator arm64-apple-ios17.0-simulator"
        "appletvsimulator arm64-apple-tvos17.0-simulator"
        "watchsimulator arm64-apple-watchos10.0-simulator"
        "watchos arm64_32-apple-watchos10.0"
        "xrsimulator arm64-apple-xros1.0-simulator"
        "macosx arm64-apple-ios17.0-macabi"
    )
    local line="$file:" failures="" config sdk target extra output result sdk_path
    for config in "${configs[@]}"; do
        read -r sdk target <<< "$config"
        extra=()
        if [[ $target == *-macabi ]]; then
            # Mac Catalyst needs the iOSSupport search paths; without them UIKit isn't visible and UIKit files would
            # compile as empty files.
            sdk_path=$(xcrun -sdk macosx --show-sdk-path)
            extra=(-Fsystem "$sdk_path/System/iOSSupport/System/Library/Frameworks" -I "$sdk_path/System/iOSSupport/usr/lib/swift")
        fi
        output=$(xcrun -sdk "$sdk" swiftc -typecheck -swift-version 6 -target "$target" "${features[@]}" ${extra[@]+"${extra[@]}"} "$file" 2>&1)
        result=$?
        if [ $result -eq 0 ] && [ -z "$output" ]; then
            line="$line ✓${target#arm64-apple-}"
        else
            line="$line ✗${target#arm64-apple-}"
            failures="$failures$(printf '%s\n' "$output" | head -5)"$'\n'
        fi
    done
    printf '%s\n%s' "$line" "$failures"
}
export -f check_file

if [ $# -gt 0 ]; then
    files=$(printf '%s\n' "$@" | grep -E '^Sources/.*\.swift$' | grep -v '^Sources/SwifterSwift/')
else
    files=$(find Sources -name '*.swift' -not -path 'Sources/SwifterSwift/*' | sort)
fi
if [ -z "$files" ]; then
    echo "standalone: no extension files to check"
    exit 0
fi

results=$(printf '%s\n' "$files" | xargs -P "$JOBS" -I{} bash -c 'check_file "$1"' _ {})
printf '%s\n' "$results"
passed=$(printf '%s\n' "$results" | grep -o '✓' | wc -l | tr -d ' ')
failed=$(printf '%s\n' "$results" | grep -o '✗' | wc -l | tr -d ' ')
echo "standalone: $(printf '%s\n' "$files" | wc -l | tr -d ' ') files, $passed checks passed, $failed failed"
[ "$failed" -eq 0 ]
