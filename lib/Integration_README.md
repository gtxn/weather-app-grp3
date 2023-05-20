# All you need for integration
## Add the following to Pubspec.yaml
dependencies:
  flutter:
    sdk: flutter
  icalendar_parser: any
  cupertino_icons: ^1.0.2
  intl: ^0.18.1
  http: ^0.13.6

## Add the following to lib/ or other folder
lib/
fetch_ical.dart
main.dart

## macOS SocketException: 
Connection failed (OS Error: Operation not permitted, errno = 1) with flutter app
### Solution:
macOS needs you to request a specific entitlement in order to access the network. To do that open macos/*Runner/DebugProfile.entitlements* and add the following key-value pair.
```
<key>com.apple.security.network.client</key>
<true/>
```
Then do the same thing in *macos/Runner/Release.entitlements*.
## We are done!