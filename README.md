

## Injector :  Dependency Management
The `Injector` class is a central component for managing dependencies and providing
instances of classes within your application. It utilizes the `GetIt` package for dependency injection and service location.

### Initialize Modules
Initialize the modules and register dependencies at the start of your application (e.g., in your `main()` function):
```dart
void main() { 
  // Initialize the injector with the necessary arguments 
  Injector.initModules(ArgInjector(aesSecretKey: 'your_aes_secret_key')) ; 
  runApp(MyApp()); 
}
```

### Custom Dependency Injection Module
Custom dependency injection module that extends the base `Injector` class. It's designed to register specific dependencies within your application using the `GetIt` package.
```dart
class AppInjector extends Injector {
  @override
  void init(GetIt instance) {
    instance.registerSingleton(Dependency());
  }
}
```

## Server Date Time
This application requires accurate server time for displaying message creation times. 
To achieve this, we utilize the `flutter_kronos_plus` plugin to synchronize with a
Network Time Protocol (NTP) server.

## Implementation Details

### 1. Android Permissions
Ensure you have the `INTERNET` permission declared in your `AndroidManifest.xml` file:
```dart
<uses-permission android:name="android.permission.INTERNET"/>
```

### 2. Initialization
To ensure accurate time synchronization, initialize the `ServerDateTime` 
instance at the start of your application. Add the following line within your `runApp()` function:

```dart
Injector.instance<ServerDateTime>().initialize();
```

### 3. Retrieving the Server Timestamp
To obtain the accurate server timestamp (in UTC), use the `utcNow()` method:
```dart
final dateStamp = await Injector.instance<ServerDateTime>().utcNow();
```
------
## Unique Identity Manager

This library provides a `UniqueIdentityManager` class for generating unique identifiers (IDs) using ULIDs (Universally Unique Lexicographically Sortable Identifiers). 
It leverages the `ulid4d` package for efficient ULID generation and manipulation.

### Retrieving the Message Id
```dart
final messageId = Injector.instance<UniqueIdentityManager>().messageId;
```
### To get Notification Id from Message id
```dart
final notificationId = Injector.instance<UniqueIdentityManager>().generateNotificationId(messageUlid);
```

## Socket Manager : WebSocket Connection Management

The `SocketManager` class is a crucial component for managing WebSocket 
connections in chat applications. It handles establishing, maintaining, 
and closing connections, as well as sending and receiving messages. 
This class is designed to be used with the `web_socket_client` package for
WebSocket communication.

SocketManager is already register in Injector, User need to pass `ArgSocketManager`.

### Send Messages
```dart
Injector.instance<SocketManageer>().sendMessage(MESSAGE);
```

### Custom Action & Event Handler
For handle action & event,pass `actionHandlers` & `eventHandler` in Argument
```dart
ArgSocketManager.client(
  socket: ...,
    actionHandlers: {
        'directMessage' : (event){
            MessagePayload.fromJson(event);
        }
    },
    eventHandler: (message) {
        if (message is MessagePayload) {
          'Received DM OR Community OR acknowledge: $message'.logI;
        }
    },
);
```

### Dispose of the Connection
```dart
Injector.instance<SocketManageer>().socketManagerDispose();
```