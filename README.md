# OpenConnect Flutter Plugin (iOS Only)

A Flutter plugin for managing OpenConnect VPN connections on **iOS**. This plugin provides methods to set up, connect, disconnect, and check the status of VPN connections using OpenConnect.

---

## Features

- **Setup VPN**: Configure VPN with hostname, credentials, and protocol settings.
- **Connect to VPN**: Establish a VPN connection.
- **Disconnect VPN**: Terminate an active VPN session.
- **Retrieve Connection Status**: Get the last known status of the VPN connection.

**Note**: This plugin currently supports **iOS only**.

---

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  openconnect_flutter: ^latest_version
```

Run the command:
```dart
flutter pub get
```

Import the package in your Dart code:
```dart
import 'package:openconnect_flutter/openconnect_flutter.dart';
```

# iOS Setup

### <b>1. Add Capabillity</b>
Add <b>Network Extensions</b> capabillity on Runner's Target and enable <b>Packet Tunnel</b>

<img src ='https://github.com/NavidShokoufeh/openconnect_flutter/blob/main/example/sc/1.png?raw=true'>

### <b>2. Add New Target</b>
Click + button on bottom left, Choose <b>NETWORK EXTENSION</b>. And set <b>Language</b> and <b>Provider  Type</b> to <b>Objective-C</b> and <b>Packet Tunnel</b> as image below.

<img src ='https://github.com/NavidShokoufeh/openconnect_flutter/blob/main/example/sc/2.png?raw=true'>

### <b>3. Add Capabillity to openconnect_extension</b>

Repeat the step 1 for new target you created on previous step (openconnect_extension)

### <b>4. Add Pod dependency</b>

Open your Podfile , and add the following lines:

```
target 'openconnect_extension' do
  pod 'vpn_adapter_ios', :git => 'https://github.com/NavidShokoufeh/vpn_adapter_ios.git', :tag => '1.0.0'
end
```

And in your runner target do the same :

```
target 'Runner' do
pod 'vpn_adapter_ios', :git => 'https://github.com/NavidShokoufeh/vpn_adapter_ios.git', :tag => '1.0.0' <-- Add this line
  flutter_install_all_ios_pods File.dirname(File.realpath(__FILE__))
  target 'RunnerTests' do
    inherit! :search_paths
  end
end
```

### <b>5. Copy Paste</b>

Open openconnect_extension > PacketTunnelProvider.m and copy paste this script <a href="https://raw.githubusercontent.com/NavidShokoufeh/openconnect_flutter/refs/heads/main/example/ios/openconnect_extension/PacketTunnelProvider.m">PacketTunnelProvider.m</a>

# Usage

## Setting up the VPN

To configure the VPN connection, use the setup method and pass an OpenconnectServer instance with the required configuration:

```dart
import 'package:openconnect_flutter/openconnect_flutter.dart';

final openconnectFlutterPlugin = OpenconnectFlutter();

final server = OpenconnectServer(
  host: 'vpn.example.com',
  port: 443,
  username: 'yourUsername',
  password: 'yourPassword',
  iosConfiguration: OpenconnectIOSConfiguration(
    enableCHAP: true,
    enablePAP: false,
    enableTLS: true,
    enableMSCHAP2: true,
  ),
);

bool setupSuccess = await openconnectFlutterPlugin.setup(server: server);
if (setupSuccess) {
  print('VPN setup successful!');
}
```

## Connecting to VPN

To connect to the VPN:
```dart
bool connectionSuccess = await openconnectFlutterPlugin.connect();
if (connectionSuccess) {
  print('Connected to VPN successfully!');
}
```

## Disconnecting from VPN

To disconnect from the VPN:
```dart
bool disconnectionSuccess = await openconnectFlutterPlugin.disconnect();
if (disconnectionSuccess) {
  print('Disconnected from VPN.');
}
```

## Checking Connection Status

To get the last known VPN connection status:
```dart
String status = await openconnectFlutterPlugin.lastStatus();
print('Last VPN status: $status');
```

# Limitations

- **Platform:** This plugin is only supported on iOS. Android support is not currently available.
- **Dependencies:** Ensure your iOS project is properly configured for VPN usage.

## Contributions and Issues

Feel free to contribute to this project by submitting pull requests or reporting issues on the [GitHub repository](https://github.com/NavidShokoufeh/openconnect_flutter).

This addition emphasizes that the purpose of the plugin is to provide a secure means for web surfing using openconnect VPN connections. Adjustments can be made based on your specific requirements.

## Support this Project

If you find this project helpful, consider supporting it by making a donation. Major of Your contribution will spend on charity every month.

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/navidshokoufeh)

[!["زرین پال"](https://cdn.zarinpal.com/badges/trustLogo/1.png)](https://zarinp.al/navid_shokoufeh)

- **Bitcoin (BTC):** `bc1qgwfqm5e3fhyw879ycy23zljcxl2pvs575c3j7w`
- **USDT (TRC20):** `TJc5v4ktoFaG3WamjY5rvSZy7v2F6tFuuE` 

Thank you for your support! 🚀

# License

```vbnet

Copyright 2024 Navid Shokoufeh

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions, and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions, and the following disclaimer in the documentation and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

```