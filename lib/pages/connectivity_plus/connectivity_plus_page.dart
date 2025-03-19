import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ConnectivityPlusPage extends StatefulWidget {
  const ConnectivityPlusPage({super.key});

  @override
  State<ConnectivityPlusPage> createState() => _ConnectivityPlusPageState();
}

class _ConnectivityPlusPageState extends State<ConnectivityPlusPage> {

  late StreamSubscription<List<ConnectivityResult>> subscription;

  @override
initState() {
  super.initState();

  subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
    // Received changes in available connectivity types!
    print(result);
  });
}

@override
dispose() {
  subscription.cancel();
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("CONNECTIVITY_TITLE_PAGE".tr()),
      ),
      body: Column(
        children: [
          Container(),
          TextButton(
              onPressed: () async {
                final List<ConnectivityResult> connectivityResult =
                    await (Connectivity().checkConnectivity());

// This condition is for demo purposes only to explain every connection type.
// Use conditions which work for your requirements.
                if (connectivityResult.contains(ConnectivityResult.mobile)) {
                  // Mobile network available.
                } else if (connectivityResult
                    .contains(ConnectivityResult.wifi)) {
                  // Wi-fi is available.
                  // Note for Android:
                  // When both mobile and Wi-Fi are turned on system will return Wi-Fi only as active network type
                } else if (connectivityResult
                    .contains(ConnectivityResult.ethernet)) {
                  // Ethernet connection available.
                } else if (connectivityResult
                    .contains(ConnectivityResult.vpn)) {
                  // Vpn connection active.
                  // Note for iOS and macOS:
                  // There is no separate network interface type for [vpn].
                  // It returns [other] on any device (also simulator)
                } else if (connectivityResult
                    .contains(ConnectivityResult.bluetooth)) {
                  // Bluetooth connection available.
                } else if (connectivityResult
                    .contains(ConnectivityResult.other)) {
                  // Connected to a network which is not in the above mentioned networks.
                } else if (connectivityResult
                    .contains(ConnectivityResult.none)) {
                  // No available network types
                }
                print(connectivityResult);
              },
              child: Text("VERIFICAR_CONEXAO_BUTTON".tr()))
        ],
      ),
    ));
  }
}
