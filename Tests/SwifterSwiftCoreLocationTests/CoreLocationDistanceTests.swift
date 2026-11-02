// CoreLocationDistanceTests.swift - Copyright 2026 SwifterSwift

#if canImport(CoreLocation)
import Testing

/// Runs the suites that measure distances one test at a time.
///
/// On the iOS and tvOS simulators, `CLLocation.distance(from:)` isn't safe to call from several threads at once:
/// distances between different pairs of locations measured at the same time can be tens of kilometers off. Measuring
/// one distance at a time, or the same pair from many threads, gives exact results.
@Suite(.serialized)
struct CoreLocationDistanceTests {}
#endif
