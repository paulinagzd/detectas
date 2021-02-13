import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

import '../controllers/questions.dart';

// import 'package:websafe_svg/websafe_svg.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF3F4768), width: 3),
        borderRadius: BorderRadius.circular(50),
      ),
      child: GetBuilder<QuestionController>(
        init: QuestionController(),
        builder: (controller) {
          return Center(
              child: FAProgressBar(
                  borderRadius: 40,
                  direction: Axis.horizontal,
                  maxValue: 100,
                  currentValue:
                      (controller.questionNumber.value * 100 / 6).round(),
                  progressColor: Colors.blue,
                  border: Border.all(
                    color: Colors.grey,
                    width: 0.1,
                  )));
        },
      ),
    );
  }
}
