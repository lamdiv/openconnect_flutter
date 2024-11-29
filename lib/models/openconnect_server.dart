import 'package:openconnect_flutter/models/openconnect_ios_configuration.dart';

class OpenconnectServer {
  final String host;
  final int port;
  final String username;
  final String password;
  final OpenconnectIOSConfiguration iosConfiguration;

  OpenconnectServer({
    required this.host,
    this.port = 443,
    required this.username,
    required this.password,
    required this.iosConfiguration,
  });
}
