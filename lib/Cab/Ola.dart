import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OlaCard extends StatelessWidget {
  const OlaCard({super.key});

  Future<void> _openOla() async {
    String packageName = 'com.olacabs.customer';
    String playStoreUrl =
        'https://play.google.com/store/apps/details?id=$packageName&gl=US';

    bool isInstalled = await DeviceApps.isAppInstalled(packageName);

    if (isInstalled) {
      try {
        AndroidIntent intent = AndroidIntent(
          action: 'android.intent.action.VIEW',
          package: packageName,
          componentName: '$packageName/.MainActivity',
          data: playStoreUrl,
          //packageName: packageName,
          // componentName: '$packageName/.MainActivity',
          flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
        );
        await intent.launch();
      } catch (e) {
        // Fallback to opening the URL in a browser
        if (await canLaunch(playStoreUrl)) {
          await launch(playStoreUrl);
        } else {
          throw 'Could not open the app or URL';
        }
      }
    } else {
      // Open Play Store URL if the app is not installed
      if (await canLaunch(playStoreUrl)) {
        await launch(playStoreUrl);
      } else {
        throw 'Could not launch $playStoreUrl';
      }
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
              onTap: () {
                _openOla();
                // Uncomment the following line if you want to navigate to another page
                // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Detection()));
              },
              child: SizedBox(
                height: 50,
                width: 50,
                child: Center(
                  child: Image.asset(
                    "assets/icon/ola.jpg",
                    height: 32,
                  ),
                ),
              ),
            ),
          ),
          const Text("Ola")
        ],
      ),
    );
  }
}
