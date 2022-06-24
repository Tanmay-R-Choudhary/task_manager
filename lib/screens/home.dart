import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_manager/screens/notifications.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool notificationsAvailable = false;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Theme(
              data: Theme.of(context).copyWith(
                  colorScheme:
                      ColorScheme.fromSwatch(accentColor: Colors.white)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Column(children: [
                    Row(
                      children: [
                        const Text("Hello, Tanmay!",
                            style:
                                TextStyle(color: Colors.white, fontSize: 30.0)),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const NotificationPage()));
                            });
                          },
                          child: Icon(
                            FontAwesomeIcons.bell,
                            color: notificationsAvailable
                                ? Colors.pink
                                : Colors.white,
                            size: 30,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        height: 50.0,
                        width: 300.0,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: const TextField(
                          cursorColor: Colors.pink,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search groups",
                              hintStyle: TextStyle(color: Colors.black54)),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            notificationsAvailable = !notificationsAvailable;
                          });
                        },
                        child: Container(
                          height: 50.0,
                          width: 50.0,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: const Center(
                            child: Icon(
                              FontAwesomeIcons.plus,
                              color: Colors.black,
                              size: 40.0,
                            ),
                          ),
                        ),
                      )
                    ]),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Groups(groupTitle: "Your teams"),
                    const Groups(groupTitle: "Your teams"),
                    const Groups(groupTitle: "Your teams"),
                    const Groups(groupTitle: "Your teams"),
                    const Groups(groupTitle: "Your teams"),
                  ]),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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
