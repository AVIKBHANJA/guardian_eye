import 'package:flutter/material.dart';
import 'package:guardian_eye/Emergencies/AmbulanceEmergency.dart';
import 'package:guardian_eye/Emergencies/FirebrigadeEmergency.dart';
import 'package:guardian_eye/Emergencies/MetroEmergency.dart';
import 'package:guardian_eye/Emergencies/PoliceEmergency.dart';
import 'package:guardian_eye/Emergencies/WomenDistress.dart';

class Emergency extends StatelessWidget {
  const Emergency({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 180,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: const [
          PoliceEmergency(),
          MetroEmergency(),
          AmbulanceEmergency(),
          WomenDistress(),
          FireEmergency()
        ],
      ),
    );
  }
}
