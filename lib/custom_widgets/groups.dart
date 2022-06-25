import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Groups extends StatefulWidget {
  final String groupTitle;
  const Groups({Key? key, required this.groupTitle}) : super(key: key);

  @override
  State<Groups> createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  List<Widget> clones(Widget w) {
    List<Widget> res = [];

    for (int i = 0; i < 20; i++) {
      res.add(w);
      res.add(const SizedBox(
        width: 10.0,
      ));
    }

    return res;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(children: [
        Row(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.groupTitle,
                style: const TextStyle(color: Colors.white, fontSize: 25.0),
              ),
            ),
            const Spacer(),
            const Icon(
              FontAwesomeIcons.ellipsisVertical,
              color: Colors.white,
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
        const SizedBox(
          height: 20.0,
        ),
        SizedBox(
          height: 160.0,
          child: Theme(
            data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.fromSwatch(accentColor: Colors.white)),
            child: ListView(
              padding: const EdgeInsets.only(left: 20.0),
              scrollDirection: Axis.horizontal,
              children: clones(const GroupCard(
                title: "Team / Project",
              )),
            ),
          ),
        ),
        const SizedBox(
          height: 30.0,
        )
      ]),
    );
  }
}

class GroupCard extends StatefulWidget {
  final String title;
  const GroupCard({Key? key, required this.title}) : super(key: key);

  @override
  State<GroupCard> createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100.0,
        width: 150.0,
        decoration: const BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        child: Center(child: Text(widget.title)));
  }
}
