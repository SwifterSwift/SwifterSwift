#!/bin/bash
#
# Prints an xcodebuild destination for a standard simulator of the newest runtime of a platform that has one, such as
# the newest iPhone or iPhone Pro. Standard devices keep the tests on familiar hardware when a runtime brings a new
# kind of device; without one, it falls back to any device of the newest runtime.
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
import json, re, sys

platform = sys.argv[1]
runtimes = json.load(sys.stdin)["devices"]
# Simulator runtimes still call visionOS by its old name, xrOS.
runtime_name = "xrOS" if platform == "visionOS" else platform
prefix = f"com.apple.CoreSimulator.SimRuntime.{runtime_name}-"
standard = {
    "iOS": r"iPhone \d+( Pro)?",
    "tvOS": r"Apple TV 4K \(\d+\w+ generation\)",
    "watchOS": r"Apple Watch Series \d+ \(\d+mm\)",
    "visionOS": r"Apple Vision Pro",
}.get(platform, r"$^")
candidates = []
for runtime, devices in runtimes.items():
    if not runtime.startswith(prefix):
        continue
    version = tuple(int(part) for part in runtime[len(prefix):].split("-") if part.isdigit())
    for device in devices:
        model = re.search(r"\d+", device["name"])
        is_standard = re.fullmatch(standard, device["name"]) is not None
        candidates.append((is_standard, version, int(model.group()) if model else 0, device["name"], device["udid"]))
if not candidates:
    sys.exit(f"no available {platform} simulator")
print(f"id={max(candidates)[-1]}")
' "$platform"
