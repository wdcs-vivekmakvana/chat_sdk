import 'dart:async';
import 'dart:convert';

import 'package:chat_sdk/chat_sdk.dart';
import 'package:web_socket_client/web_socket_client.dart';

/// Manages WebSocket connections for chat applications.
class SocketManager {
  /// Constructor for the SocketManager class.
  ///
  /// Initializes a new instance of the SocketManager class with the provided [arg].
  SocketManager({required this.arg}) {
    _initListener();
  }

  /// The argument for the SocketManager.
  final ArgSocketManager arg;

  StreamSubscription<dynamic>? _messagesStream;

  /// Disposes of the WebSocket connection and cancels any active listeners.
  void socketManagerDispose() {
    _messagesStream?.cancel();
    arg.webSocket?.close();
    'Socket closed'.logI;
  }

  /// Initializes a listener for incoming WebSocket messages and handles errors.
  void _initListener() {
    _messagesStream?.cancel();
    _messagesStream = arg.webSocket?.messages.map((event) => jsonDecode(event as String) as Map<String, dynamic>).map(
      (event) {
        final action = event['action'] as String;
        if (arg.actionHandlers != null) {
          final handler = arg.actionHandlers![action];
          if (handler != null) {
            return handler(event);
          }
        }
        'unhandled message type or socket validation error: $event'.logI;
        return event; // Return the original event if no handler is found
      },
    ).listen(
      (message) {
        if (arg.eventHandler != null) {
          arg.eventHandler?.call(message);
        }
      },
      onError: (dynamic error) {
        'Error occurred while connecting the socket : $error'.logE;
      },
      onDone: () => 'Socket closed'.logD,
    );
  }

  /// Sends a message payload over the WebSocket connection.
  ///
  /// If the WebSocket connection is not in a [Reconnected] or [Connected] state,
  /// the message send will fail and an error message will be logged.
  void sendMessage(dynamic messagePayload) {
    if (arg.webSocket?.connection.state is Reconnected || arg.webSocket?.connection.state is Connected) {
      final payload = messagePayload;
      'Send messagePayload: $payload'.logI;
      arg.webSocket?.send(jsonEncode(payload));
    } else {
      'Socket Disconnected send failed $messagePayload'.logE;
    }
  }
}
