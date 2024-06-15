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

### ios justbuildDevelopmentbuild

```sh
[bundle exec] fastlane ios justbuildDevelopmentbuild
```

Just build a dev build, no signing or upload

### ios fetchDistributionCertificatesAndProfiles

```sh
[bundle exec] fastlane ios fetchDistributionCertificatesAndProfiles
```

Fetch distribution certificates and profiles

### ios setup_xcode_version

```sh
[bundle exec] fastlane ios setup_xcode_version
```

setup xcode version

### ios app_store_connect_api_key_setup

```sh
[bundle exec] fastlane ios app_store_connect_api_key_setup
```

Setup App Store Connect connection

### ios build_prod_app

```sh
[bundle exec] fastlane ios build_prod_app
```

Build prod App

### ios beta

```sh
[bundle exec] fastlane ios beta
```

Build for App Store distribution and upload to TestFlight

### ios snapshotlane

```sh
[bundle exec] fastlane ios snapshotlane
```

run the screenshot code

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
