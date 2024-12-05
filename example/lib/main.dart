import 'package:flutter/material.dart';
import 'package:openconnect_flutter/openconnect_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final openconnectFlutterPlugin = OpenconnectFlutter();
  var connectionStatus = "disconnected";

  TextEditingController hostNameController = TextEditingController();
  TextEditingController sslPortController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
    setupVpn();
    onStatusChanged();
  }

  init() async {
    connectionStatus =
        await openconnectFlutterPlugin.lastStatus() ?? 'disconnected';
    setState(() {});
  }

  setupVpn() async {
    OpenconnectServer server = OpenconnectServer(
      host: hostNameController.text,
      port: int.parse(
          sslPortController.text.isEmpty ? '443' : sslPortController.text),
      username: userNameController.text,
      password: passController.text,
      iosConfiguration: OpenconnectIOSConfiguration(
        enableMSCHAP2: true,
        enableCHAP: false,
        enablePAP: false,
        enableTLS: false,
      ),
    );
    await openconnectFlutterPlugin.setup(server: server);
  }

  onStatusChanged() {
    openconnectFlutterPlugin.onStatusChanged(
      onConnectedResult: () {
        setState(() {
          connectionStatus = "connected";
        });
      },
      onConnectingResult: () {
        setState(() {
          connectionStatus = "connecting";
        });
      },
      onDisconnectedResult: () {
        setState(() {
          connectionStatus = "disconnected";
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter openconnect vpn example app'),
        ),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("connectionStatus : $connectionStatus"),
                ],
              ),
              TextField(
                controller: hostNameController,
                decoration: const InputDecoration(hintText: "host name"),
              ),
              TextField(
                controller: sslPortController,
                decoration: const InputDecoration(hintText: "ssl port"),
              ),
              TextField(
                controller: userNameController,
                decoration: const InputDecoration(hintText: "user name"),
              ),
              TextField(
                controller: passController,
                decoration: const InputDecoration(hintText: "password"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        await setupVpn();
                        try {
                          await openconnectFlutterPlugin.connect();
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                      },
                      child: const Text("Connect")),
                  ElevatedButton(
                      onPressed: () async {
                        await openconnectFlutterPlugin.disconnect();
                      },
                      child: const Text("Disconnect"))
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
