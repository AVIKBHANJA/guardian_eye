import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:url_launcher/url_launcher.dart';

class UberCard extends StatelessWidget {
  const UberCard({super.key});

  Future<void> _openUber() async {
    const String packageName = 'com.ubercab';
    const String playStoreUrl =
        'https://play.google.com/store/apps/details?id=$packageName';

    try {
      bool isInstalled = await DeviceApps.isAppInstalled(packageName);
      if (isInstalled) {
        await DeviceApps.openApp(packageName);
      } else {
        if (await canLaunch(playStoreUrl)) {
          await launch(playStoreUrl);
        } else {
          throw 'Could not launch $playStoreUrl';
        }
      }
    } catch (e) {
      print('Error: $e');
      // Optionally show a dialog or toast to inform the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          Card(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: InkWell(
              onTap: _openUber,
              child: SizedBox(
                height: 50,
                width: 50,
                child: Center(
                  child: Image.asset(
                    "assets/icon/uber.jpg",
                    height: 32,
                  ),
                ),
              ),
            ),
          ),
          const Text("Uber")
        ],
      ),
    );
  }
}
