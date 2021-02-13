# google_maps

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Lo Added Google API Steps

Add Google Maps Flutter plugin as a dependency
- Look for added line in pubspec.yaml
- Run flutter pub get after / save instant run

Add API key for Android app
- android/app/src/main/AndroidManifest.xml

Add API key for Google app
- import GoogleMaps
- ios/Runner/AppDelegate.swift

Add more dependencies to the pubspec.yaml file

Add file called analysis_options.yaml to root

Parse JSON w/code generation
- lib/src directory
- create a locations.dart file