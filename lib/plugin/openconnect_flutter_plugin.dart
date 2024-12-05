import 'package:flutter/services.dart';
import 'package:openconnect_flutter/models/openconnect_server.dart';
import 'package:openconnect_flutter/models/status.dart';
import 'package:openconnect_flutter/plugin/openconnect_platform_interface.dart';

typedef OnConnected = Function();
typedef OnConnecting = void Function();
typedef OnDisconnected = void Function();
typedef OnError = Function();

class OpenconnectFlutter {
  MethodChannel channel = const MethodChannel("responseReceiver");

  /// Starts connection between client and provided [OpenconnectServer]
  /// Before try to connect , make sure you have called [setup] metthod
  Future<bool?> connect() {
    return OpenconnectFlutterPlatform.instance.connect();
  }

  /// Disconnects current running openconnect connection
  Future<bool?> disconnect() {
    return OpenconnectFlutterPlatform.instance.disconnect();
  }

  /// Sets provided [OpenconnectServer] and registers your application as vpn in user's phone settings
  Future<bool?> setup({required OpenconnectServer server}) {
    return OpenconnectFlutterPlatform.instance.setup(server: server);
  }

  /// Returns last connection status
  Future<String?> lastStatus() {
    return OpenconnectFlutterPlatform.instance.lastStatus();
  }

  /// As the status changed , it gets called
  Future onStatusChanged({
    OnConnected? onConnectedResult,
    OnConnecting? onConnectingResult,
    OnDisconnected? onDisconnectedResult,
    OnError? onError,
  }) async {
    Future methodCallReceiver(MethodCall call) async {
      var arg = call.arguments;

      if (call.method == 'connectResponse') {
        if (arg["status"] == OpenconnectConnectionStatusKeys.CONNECTED) {
          onConnectedResult!();
        } else if (arg["status"] ==
            OpenconnectConnectionStatusKeys.CONNECTING) {
          onConnectingResult!();
        } else if (arg["status"] ==
            OpenconnectConnectionStatusKeys.DISCONNECTED) {
          onDisconnectedResult!();
          bool? error = arg["error"];
          if (error != null && error) onError!();
        }
      }
    }

    channel.setMethodCallHandler(methodCallReceiver);
  }
}
