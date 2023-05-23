# All you need for integration

## Add the following to Pubspec.yaml

```
dependencies:
  flutter:
    sdk: flutter

  geolocator: ^9.0.2
  geocoding: ^2.1.0
  get: ^4.6.5
  bloc: ^8.1.1

  cupertino_icons: ^1.0.2
  google_fonts: ^4.0.4
  intl: ^0.18.1

  icalendar_parser: any

  http: ^0.13.6
  shared_preferences: any
  expandable: ^5.0.1
```

## Add the following to lib/ or other folder

After creating a flutter project, put replace `/lib` with our `/lib`

## If the iCal doesn't work

Run it in chrome, download a CORS extension and run it.

## macOS SocketException:

Connection failed (OS Error: Operation not permitted, errno = 1) with flutter app

### Solution:

macOS needs you to request a specific entitlement in order to access the network. To do that open macos/_Runner/DebugProfile.entitlements_ and add the following key-value pair.

```
<key>com.apple.security.network.client</key>
<true/>
```

Then do the same thing in _macos/Runner/Release.entitlements_.

## We are done!
