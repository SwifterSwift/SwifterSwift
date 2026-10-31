#!/bin/bash
#
# Prints an xcodebuild destination for an available simulator of the newest runtime of a platform.
#
# Usage:
#
#     xcodebuild test -destination "$(scripts/simulator-destination.sh iOS)" …
#
# The platform is iOS, tvOS, watchOS or visionOS.
#
set -eu
platform=${1:?usage: simulator-destination.sh iOS|tvOS|watchOS|visionOS}

xcrun simctl list devices available --json | python3 -c '
import json, sys

platform = sys.argv[1]
runtimes = json.load(sys.stdin)["devices"]
prefix = f"com.apple.CoreSimulator.SimRuntime.{platform}-"
candidates = []
for runtime, devices in runtimes.items():
    if runtime.startswith(prefix) and devices:
        version = tuple(int(part) for part in runtime[len(prefix):].split("-") if part.isdigit())
        candidates.append((version, devices[0]["udid"]))
if not candidates:
    sys.exit(f"no available {platform} simulator")
print(f"id={max(candidates)[1]}")
' "$platform"
