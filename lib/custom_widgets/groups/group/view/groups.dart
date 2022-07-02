import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_manager/custom_widgets/groups/group_card/view/group_card.dart';

class Groups extends StatelessWidget {
  final String groupTitle;
  final List<GroupCard> cards;
  const Groups({Key? key, required this.groupTitle, required this.cards})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(children: [
        Row(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                groupTitle,
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
              children: cards,
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
