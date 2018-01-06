# Changelog Guidelines

Here you can find the general guidelines for maintaining the Changelog (or adding new entries). We follow the guidelines from [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) with few additions.

## Guiding Principles
- Changelogs are for humans, not machines.
- There should be an entry for every single version.
- The same types of changes should be grouped.
- Versions and sections should be linkable.
- The latest version comes first.
- The release date of each versions is displayed.
- Mention whether you follow Semantic Versioning.

... with the following **SwifterSwift** specific additions:
- Keep an unreleased section at the top.
- Each release title should link to release's page.
- Add PR number and a GitHub tag at the end of each entry.
- Each breaking change entry should have **Breaking Change** label at the beginning of this entry.
- **Breaking Change** entries should be placed at the top of the section it's in.
- Entries under each category should be grouped by the type they extend.

## Types of changes
- **Added** for new features.
- **Changed** for changes in existing functionality.
- **Deprecated** for soon-to-be removed features.
- **Removed** for now removed features.
- **Fixed** for any bug fixes.
- **Security** in case of vulnerabilities.

---

## Example:


# [v4.1.0](https://github.com/SwifterSwift/SwifterSwift/releases/tag/4.1.0)

### Added

- **UIDatePicker**
    - Added `textColor` property to set and get text color of UIDatePicker. [#335](https://github.com/SwifterSwift/SwifterSwift/pull/335) by [@omaralbeik](https://github.com/omaralbeik).
- **Continuous Integration**
    - Added **Danger** to continuous integration. [#252](https://github.com/SwifterSwift/SwifterSwift/pull/252) by [SD10](https://github.com/SD10).


### Changed

- **Date**
    - **Breaking Change**  The property `weekday` is now a get-only property. [#313](https://github.com/SwifterSwift/SwifterSwift/pull/313) by [kaphacius](https://github.com/kaphacius).

- **Array**
    - `shuffle` and `shuffled` are no more constrained to Equatable. [#327](https://github.com/SwifterSwift/SwifterSwift/pull/327) by [LucianoPAlmeida](https://github.com/LucianoPAlmeida).


### Deprecated

- **String**
    - `reversed() -> String` is deprecated in favor of Swift 4 new `reversed() -> ReversedCollection<String>`. [#305](https://github.com/SwifterSwift/SwifterSwift/pull/305) by [LucianoPAlmeida](https://github.com/LucianoPAlmeida).
- **Date**
    - `isInThisWeek` has been renamed to `isInCurrentWeek`.


### Removed

- **UIViewController**
    - **Breaking Change** Removed `navigationBar` that was causing iOS apps to crash, thanks to drewpitchford for reporting in [#243](https://github.com/SwifterSwift/SwifterSwift/issues/243). by [drewpitchford](https://github.com/drewpitchford)


### Fixed

- **Tests**
    - Fixed a bug where `XCTAssertNotNil` could not handle optionals. [#188](https://github.com/SwifterSwift/SwifterSwift/pull/188). by [omaralbeik](https://github.com/omaralbeik)
