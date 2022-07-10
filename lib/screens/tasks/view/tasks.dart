import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:task_manager/screens/home/binding/home_binding.dart';
import 'package:task_manager/screens/home/view/home.dart';
import 'package:task_manager/screens/tasks/controller/tasks_controller.dart';
import 'package:task_manager/screens/tasks/view/dialog.dart';

class TasksPage extends GetView<TasksPageController> {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: SafeArea(
          child: Stack(children: [
            Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.fromSwatch(
                accentColor: Colors.white,
              )),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(
                        () => SizedBox(
                          width: 250,
                          child: Text(
                            controller.projectName.value,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(20.0)),
                        height: Get.mediaQuery.size.height / 1.4,
                        child: GetBuilder<TasksPageController>(
                          builder: (controller) => ListView.builder(
                            padding: const EdgeInsets.only(bottom: 100.0),
                            itemCount: controller.taskCardsList.value.length,
                            itemBuilder: (context, idx) {
                              return controller.taskCardsList.value[idx];
                            },
                          ),
                        ),
                      )
                    ]),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.0),
                    topRight: Radius.circular(50.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(FontAwesomeIcons.calendarDays),
                      color: Colors.white,
                      iconSize: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          Get.dialog(const TaskCreatorDialog());
                        },
                        child: Container(
                          height: 60.0,
                          width: 60.0,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Icon(
                            FontAwesomeIcons.plus,
                            color: Colors.black,
                            size: 50.0,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.off(() => const HomePage(), binding: HomeBinding());
                      },
                      icon: const Icon(FontAwesomeIcons.house),
                      color: Colors.white,
                      iconSize: 30.0,
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final String id;
  final bool completed;
  final String title;
  final String description;
  final String priority;
  const TaskCard(
      {Key? key,
      required this.id,
      required this.completed,
      required this.title,
      required this.description,
      required this.priority})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<TasksPageController>();

    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              height: 170,
              width: 250,
              decoration: BoxDecoration(
                border: Border.all(
                    color: completed ? Colors.green : Colors.pink, width: 5.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(0, 5),
                    blurRadius: 10.0,
                  )
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        description,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 13.0,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 170),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50.0,
              width: 230.0,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(0, 5),
                    blurRadius: 10.0,
                  )
                ],
                color: completed ? Colors.green : Colors.pink,
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        priority,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          controller.updateTaskCompletion(
                              id, !completed, title, description, priority);
                        },
                        icon: completed
                            ? const Icon(FontAwesomeIcons.x)
                            : const Icon(FontAwesomeIcons.check),
                        color: completed ? Colors.red : Colors.green,
                      ),
                      IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          controller.deleteTask(id);
                        },
                        icon: const Icon(FontAwesomeIcons.trash),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
