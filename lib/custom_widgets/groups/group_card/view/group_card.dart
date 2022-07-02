import 'package:flutter/material.dart';

class GroupCard extends StatelessWidget {
  final String title;
  const GroupCard({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          height: 100.0,
          width: 150.0,
          decoration: const BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          child: Center(child: Text(title))),
    );
  }
}
