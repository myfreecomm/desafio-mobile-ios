fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios lint_code
```
fastlane ios lint_code
```
Check code style
### ios coverage
```
fastlane ios coverage
```
Create coverage report
### ios check_code
```
fastlane ios check_code
```
Used by Development to keep code quality. Use command: 'fastlane check_code dev:true'

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
