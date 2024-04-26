fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## iOS

### ios justbuild

```sh
[bundle exec] fastlane ios justbuild
```

Just build, no signing or upload

### ios beta

```sh
[bundle exec] fastlane ios beta
```

Build for App Store distribution and upload to TestFlight

### ios incrementBuildNumberDynamically

```sh
[bundle exec] fastlane ios incrementBuildNumberDynamically
```

increment build number +1 based on test flight latest number

### ios fixbuildnumbertocurrentversion

```sh
[bundle exec] fastlane ios fixbuildnumbertocurrentversion
```

reset my build number to current version

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
