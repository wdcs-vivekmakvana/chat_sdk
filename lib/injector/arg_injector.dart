import 'package:chat_sdk/socket/models/arg_socket_manager.dart';

/// A class to handle argument injection for the chat SDK.
///
/// This class is responsible for providing the necessary arguments to various components
/// within the chat SDK. The provided arguments are used to configure the SDK's behavior.
class ArgInjector {
  /// Constructs an instance of [ArgInjector].
  ///
  /// The [aesSecretKey] parameter is required and represents the secret key used for
  /// AES encryption and decryption within the chat SDK.
  ArgInjector({required this.aesSecretKey, required this.argSocketManager});

  /// The secret key used for AES encryption and decryption within the chat SDK.
  final String aesSecretKey;

  /// Argument class for Socket Manager
  final ArgSocketManager argSocketManager;
}
