import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:task_manager/screens/start/controller/start_controller.dart';
import 'package:task_manager/utils/screen_backgrounds.dart';

class StartPage extends GetView<StartPageController> {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
          backgroundColor: Colors.black,
          body: GetBuilder<StartPageController>(
            builder: (controller) => CustomPaint(
              size: Size(Get.mediaQuery.size.width, Get.mediaQuery.size.height),
              painter: GetStartedPagePainter(
                  paintSplashIndicator: controller.controller),
              child: SizedBox(
                height: Get.mediaQuery.size.height,
                width: Get.mediaQuery.size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Obx(
                        () => Align(
                          alignment: Alignment.center,
                          child: AnimatedOpacity(
                            opacity: controller.isVisible.value ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 500),
                            child: const Text(
                              "Timely",
                              style:
                                  TextStyle(fontSize: 70, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        "A new wave",
                        style: TextStyle(
                          fontSize: 50.0,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        "of ORGANISATION",
                        style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      Obx(
                        () => AnimatedOpacity(
                          opacity: controller.isVisible.value ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 500),
                          child: GestureDetector(
                            onTap: () {
                              controller.isVisible.value = false;
                              controller.playAnimationForward();
                            },
                            child: Container(
                              height: 70,
                              width: 200,
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Row(children: const [
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "Get started",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Spacer(),
                                Icon(
                                  FontAwesomeIcons.arrowRight,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                              ]),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
