import 'dart:async';

import 'package:flutter_kronos_plus/flutter_kronos_plus.dart';

/// A utility class for managing server date and time.
///
/// This class provides methods for initializing, checking the initialization status,
/// and retrieving the current UTC date and time from the server.
class ServerDateTime {
  /// A singleton instance of [ServerDateTime].
  factory ServerDateTime.instance() => _instance;

  ServerDateTime._();

  static final ServerDateTime _instance = ServerDateTime._();

  /// Initializes the server date and time.
  void initialize() {
    FlutterKronosPlus.sync();
  }

  /// Checks if the server date and time is initialized.
  ///
  /// Returns a [Future] that resolves to a [bool] indicating whether the server date and time is initialized.
  Future<bool> isInitialized() async {
    return (await FlutterKronosPlus.getNtpDateTime != null);
  }

  /// Retrieves the current UTC date and time from the server.
  ///
  /// Returns a [Future] that resolves to a [DateTime] representing the current UTC date and time.
  Future<DateTime> utcNow() async {
    final dateTime = (await FlutterKronosPlus.getNtpDateTime)!.toUtc();
    return dateTime;
  }
}
