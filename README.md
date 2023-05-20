# weather_app
A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Implement Calender sync
Functionality Done
1. Calender sync info 
2. Input text box
3. Submit and Go back buttons.
4. Transition between pages
5. Retrieve input iCal

final myController = TextEditingController();

## Parser of iCal
iCal parsing HAS BEEN ALREADY integrated in Submit button!
1. After Clicking the submit button a list of sorted and filtered Calendar objects will be generated for future used.
1. Add several util functions
2. Current Time stamp done! 20230518T225557Z 
3. Read from str to json
4. String filter and time sorting
 
## Reference
switch between the page https://docs.flutter.dev/cookbook/navigation/navigation-basics

Text input box https://docs.flutter.dev/cookbook/forms/text-input

Retrieve the input https://docs.flutter.dev/cookbook/forms/retrieve-input

icalendar parser
https://pub.dev/packages/icalendar_parser


https://dart.dev/language/records#record-fields

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

## Trouble Shooting
Double check your calendar event time.