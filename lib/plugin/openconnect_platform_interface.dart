import 'package:openconnect_flutter/models/openconnect_server.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'openconnect_method_channel.dart';

abstract class OpenconnectFlutterPlatform extends PlatformInterface {
  OpenconnectFlutterPlatform() : super(token: _token);

  static const String _token = '';
  static OpenconnectFlutterPlatform _instance =
      MethodChannelopenconnectFlutter();
  static OpenconnectFlutterPlatform get instance => _instance;

  static set instance(OpenconnectFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool?> connect();

  Future<bool?> disconnect();

  Future<bool?> setup({required OpenconnectServer server});

  Future<String?> lastStatus();
}
