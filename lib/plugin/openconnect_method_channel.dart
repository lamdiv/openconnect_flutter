import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:openconnect_flutter/models/openconnect_server.dart';
import 'package:openconnect_flutter/plugin/openconnect_platform_interface.dart';

class MethodChannelopenconnectFlutter extends OpenconnectFlutterPlatform {
  final methodChannelCaller =
      const MethodChannel('com.navidshokoufeh.openconnect_flutter');

  @override
  Future<bool> connect() async {
    try {
      bool status = await methodChannelCaller.invokeMethod("connect");
      return status;
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<bool> disconnect() async {
    try {
      bool status = await methodChannelCaller.invokeMethod("disconnect");
      return status;
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<bool> setup({required OpenconnectServer server}) async {
    try {
      bool status = await methodChannelCaller.invokeMethod("setupVpn", {
        "hostName": server.host,
        "sslPort": server.port,
        "userName": server.username,
        "password": server.password,
        "enableCHAP": server.iosConfiguration.enableCHAP,
        "enablePAP": server.iosConfiguration.enablePAP,
        "enableTLS": server.iosConfiguration.enableTLS,
        "enableMSCHAP2": server.iosConfiguration.enableMSCHAP2,
      });
      return status;
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  @override
  Future<String> lastStatus() async {
    String status =
        await methodChannelCaller.invokeMethod("checkLastConnectionStatus");
    return status;
  }
}
