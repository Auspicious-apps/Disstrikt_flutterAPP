// import 'package:socket_io_client/socket_io_client.dart';
// import '../../export.dart';
//
// class SocketIOManager extends GetxController {
//   Socket? socket;
//   late String token;
//   // late LocalStorage _localStorage;
//
//   @override
//   void onInit() async {
//     _initLocalStorage();
//     await socketConnection();
//     super.onInit();
//   }
//
//   void _initLocalStorage() {
//     if (Get.isRegistered<LocalStorage>()) {
//       _localStorage = Get.find<LocalStorage>();
//     } else {
//       _localStorage = Get.put(LocalStorage());
//     }
//   }
//
//   Future<void> socketConnection() async {
//     token = _localStorage.getAuthToken() ?? "";
//
//     socket = io(
//       baseUrl,
//       OptionBuilder()
//           .setTransports(['websocket'])
//           .setExtraHeaders({'token': 'Bearer $token'})
//           .disableAutoConnect()
//           .build(),
//     );
//
//     _addSocketConnectionEvents();
//
//     socket!.connect();
//   }
//
//   void _addSocketConnectionEvents() {
//     socket!
//       ..onConnect((_) {
//         debugPrint('Connected to socket');
//       })
//       ..onDisconnect((_) {
//         debugPrint('Disconnected from socket');
//         _attemptReconnect();
//       })
//       ..onConnectError((error) {
//         debugPrint('Connection error: $error');
//         _attemptReconnect();
//       })
//       ..onReconnectAttempt((attempt) {
//         debugPrint('Reconnection attempt: $attempt');
//       })
//       ..onReconnect((_) {
//         debugPrint('Reconnected to socket');
//       })
//       ..onError((error) {
//         debugPrint('Socket error: $error');
//       });
//   }
//
//   void _attemptReconnect() {
//     if (socket != null && !socket!.connected) {
//       debugPrint("Attempting to reconnect...");
//       socket!.connect();
//     }
//   }
//
//   Future<void> emitEvent({
//     required Map<String, dynamic>? dataBody,
//     required String eventName,
//   }) async {
//     if (dataBody == null) {
//       throw ArgumentError('dataBody must not be null');
//     }
//     if (socket != null && socket!.connected) {
//       debugPrint("Emitting event: $eventName");
//       socket!.emit(eventName, dataBody);
//     } else {
//       debugPrint("Socket is not connected. Cannot emit event: $eventName");
//     }
//   }
//
//   Future<void> listenEvent({
//     required String eventName,
//     required Function(dynamic) onDataReceived,
//   }) async {
//     if (socket != null && socket!.connected) {
//       debugPrint("Listening for event: $eventName");
//       socket!.on(eventName, (data) {
//         debugPrint("Event $eventName received with data: $data");
//         onDataReceived(data);
//       });
//     } else {
//       debugPrint("Socket is not connected. Cannot listen to event: $eventName");
//     }
//   }
//
//   Future<void> disconnectSocket() async {
//     socket?.disconnect();
//   }
//
//   @override
//   void dispose() {
//     disconnectSocket();
//     socket?.destroy();
//     super.dispose();
//   }
// }
