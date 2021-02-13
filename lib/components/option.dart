import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../controllers/questions.dart';

class Option extends StatelessWidget {
  const Option({
    Key key,
    this.text,
    this.index,
    this.press,
  }) : super(key: key);
  final String text;
  final int index;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
        init: QuestionController(),
        builder: (qnController) {
          Color getColor() {
            if (qnController.isAnswered) {
              if (index == qnController.trueIndex) {
                return Colors.blue;
              } else if (index == qnController.selectedAnswer &&
                  qnController.selectedAnswer != qnController.trueIndex) {
                return Colors.blue;
              }
            }
            return Colors.grey;
          }

          IconData getTheRightIcon() {
            return qnController.isAnswered ? Icons.done : null;
          }

          return InkWell(
            onTap: press,
            child: Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                border: Border.all(color: getColor()),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$text",
                    style: TextStyle(color: getColor(), fontSize: 16),
                  ),
                  Container(
                    height: 26,
                    width: 26,
                    decoration: BoxDecoration(
                      color: getColor() == Colors.grey
                          ? Colors.transparent
                          : getColor(),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: getColor()),
                    ),
                    child: getColor() == Colors.grey
                        ? null
                        : Icon(getTheRightIcon(), size: 16),
                  )
                ],
              ),
            ),
          );
        });
  }
}
