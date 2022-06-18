import 'package:flutter/material.dart';
import 'package:task_manager/screens/start.dart';

import 'package:task_manager/utils/constants.dart';
import 'package:task_manager/utils/database_service.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Task Manager"),
        backgroundColor: Colors.blue.shade900,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonBar(
              alignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () async {
                      int i = await DatabaseService.instance.insert({
                        DatabaseService.columnUser: "tanmay_choudhary",
                        DatabaseService.columnDay: 0,
                        DatabaseService.columnHeading: "Commiting github repo",
                        DatabaseService.columnDescription:
                            "Commit task manager app",
                        DatabaseService.columnDeadlineDate: 11,
                        DatabaseService.columnDeadlineMonth: 10,
                        DatabaseService.columnDeadlineYear: 22,
                        DatabaseService.columnPriority: 2
                      });

                      print("Entry created with id: $i");
                    },
                    child: const Text(
                      "Insert",
                      style: TextStyle(fontSize: 20.0),
                    )),
                TextButton(
                    onPressed: () async {
                      List<Map<String, dynamic>> queryRows =
                          await DatabaseService.instance.queryAll();
                      print(queryRows);
                    },
                    child: const Text(
                      "Query",
                      style: TextStyle(fontSize: 20.0),
                    )),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Update",
                      style: TextStyle(fontSize: 20.0),
                    )),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Delete",
                      style: TextStyle(fontSize: 20.0),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
