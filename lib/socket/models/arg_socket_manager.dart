import 'package:web_socket_client/web_socket_client.dart';

/// A class to manage WebSocket connections and handle events and actions.
class ArgSocketManager {
  ArgSocketManager._({
    this.webSocket,
    this.eventHandler,
    this.actionHandlers,
  });

  /// Creates an instance of ArgSocketManager using an existing WebSocket connection.
  factory ArgSocketManager.client({
    required WebSocket socket,
    Map<String, ActionHandler>? actionHandlers,
    EventHandler? eventHandler,
  }) {
    return ArgSocketManager._(
      webSocket: socket,
      actionHandlers: actionHandlers,
      eventHandler: eventHandler,
    );
  }

  /// Creates an instance of ArgSocketManager using a custom WebSocket URL.
  factory ArgSocketManager.custom({
    required String socketUrl,
    Map<String, dynamic>? headers,
    Map<String, ActionHandler>? actionHandlers,
    EventHandler? eventHandler,
  }) {
    return ArgSocketManager._(
      webSocket: WebSocket(
        Uri.parse(socketUrl),
        headers: headers,
      ),
      actionHandlers: actionHandlers,
      eventHandler: eventHandler,
    );
  }

  /// The WebSocket connection associated with this ArgSocketManager instance.
  final WebSocket? webSocket;

  /// A map of action handlers, where the key is the action name and the value is the corresponding handler function.
  final Map<String, ActionHandler>? actionHandlers;

  /// An event handler function that will be called when a new event is received.
  final EventHandler? eventHandler;
}

/// A function type representing an action handler.
typedef ActionHandler = dynamic Function(Map<String, dynamic> event);

/// A function type representing an event handler.
typedef EventHandler = void Function(dynamic message);
