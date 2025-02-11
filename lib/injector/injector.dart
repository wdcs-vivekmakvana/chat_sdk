import 'package:chat_sdk/chat_sdk.dart';
import 'package:chat_sdk/injector/arg_injector.dart';
import 'package:chat_sdk/utils/encryption_manager.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:get_it/get_it.dart';

/// A class responsible for managing dependencies and providing instances of classes.
@immutable
abstract class Injector {
  const Injector._();

  static final _injector = GetIt.instance;

  /// Returns the singleton instance of GetIt.
  static GetIt get instance => _injector;

  /// Initializes the modules and registers dependencies.
  ///
  /// This method registers an instance of [EncryptionManager] with the provided aesSecretKey
  /// using the singleton registration method provided by GetIt.
  ///
  /// Parameters:
  /// - arg: An instance of [ArgInjector] containing the necessary arguments for initialization.
  static void initModules(ArgInjector arg) {
    instance
      ..registerSingleton(EncryptionManager(aesSecretKey: arg.aesSecretKey))
      ..registerSingleton(ServerDateTime.instance)
      ..registerSingleton(UniqueIdentityManager());
  }

  /// Initializes the injector with the provided instance of GetIt.
  void init(GetIt instance);
}
