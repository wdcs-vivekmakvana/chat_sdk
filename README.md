
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
ServerDateTime.instance().initialize();
```

### 3. Retrieving the Server Timestamp
To obtain the accurate server timestamp (in UTC), use the `utcNow()` method:
```dart
final dateStamp = await ServerDateTime.instance().utcNow();
```
------
## Unique Identity Manager

This library provides a `UniqueIdentityManager` class for generating unique identifiers (IDs) using ULIDs (Universally Unique Lexicographically Sortable Identifiers). 
It leverages the `ulid4d` package for efficient ULID generation and manipulation.

### Retrieving the Message Id
```dart
final messageId = UniqueIdentityManager().messageId;
```
### To get Notification Id from Message id
```dart
final notificationId = UniqueIdentityManager().generateNotificationId(messageUlid);
```