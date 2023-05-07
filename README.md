# Flutter Pokedex

This application is developed with Flutter, it consumed the API RESTful [PokeApi](https://pokeapi.co/). This application is intended to be an example of Clean Architecture, Unit Test, Widget Test and Integration test.

## Packages

- [bloc](https://pub.dev/packages/bloc) - The goal of this package is to make it easy to implement the BLoC Design Pattern (Business Logic Component).
- [fpdart](https://pub.dev/packages/fpdart) - Functional programming in Dart and Flutter.
- [dio](https://pub.dev/packages/dio) - A powerful HTTP client for Dart/Flutter, which supports global configuration, interceptors, FormData, request cancellation, file uploading/downloading, timeout, and custom adapters etc.
- [equatable](https://pub.dev/packages/equatable) - Simplify Equality Comparisons
- [flutter_bloc](https://pub.dev/packages/flutter_bloc) - Widgets that make it easy to integrate blocs and cubits into Flutter. Built to work with package: bloc.
- [get_it](https://pub.dev/packages/get_it) - This is a simple Service Locator for Dart and Flutter projects with some additional goodies highly inspired by Splat. It can be used instead of InheritedWidget or Provider to access objects e.g. from your UI.
- [marquee](https://pub.dev/packages/marquee) - A Flutter widget that scrolls text infinitely.
- [path](https://pub.dev/packages/path) - A comprehensive, cross-platform path manipulation library for Dart.
- [sliver_tools](https://pub.dev/packages/sliver_tools) - A set of useful sliver tools that are missing from the flutter framework.
- [transparent_image](https://pub.dev/packages/transparent_image) - A simple transparent image. Represented as a Uint8List, which was originally extracted from the Flutter codebase.

## Development Dependencies

- [bloc_test](https://pub.dev/packages/bloc_test) - A Dart package that makes testing blocs and cubits easy. Built to work with bloc and mocktail.
- [integration_test](https://github.com/flutter/flutter/tree/main/packages/integration_test) - This package enables self-driving testing of Flutter code on devices and emulators.
- [mocktail](https://pub.dev/packages/mocktail) - Mocktail focuses on providing a familiar, simple API for creating mocks in Dart (with null-safety) without the need for manual mocks or code generation.
- [network_image_mock](https://pub.dev/packages/network_image_mock) - A utility for providing mocked response to Image.network in Flutter widget tests.

## Features

- **Home**: Shows a grid of pokémon segmented by pages.
- **Pokemon Detail**: Shows basic information about the selected pokemon.
- **Search Pokemon**: Allows the query of pokémon by name or id.