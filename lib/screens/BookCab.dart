import 'package:flutter/material.dart';
import 'package:guardian_eye/Cab/Ola.dart';
import 'package:guardian_eye/Cab/Rapido.dart';
import 'package:guardian_eye/Cab/Uber.dart';

class BookCab extends StatelessWidget {
  const BookCab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book a Cab'),
      ),
      body: SizedBox(
        height: 90,
        width: MediaQuery.of(context).size.width,
        child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: const [UberCard(), OlaCard(), RadpidoCard()]),
      ),
    );
  }
}
