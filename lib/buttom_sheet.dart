import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/view_model.dart';

import 'ads/ad_unit.dart';
import 'colors.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final ViewModel viewModel = ViewModel();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return IntrinsicHeight(
      child: Container(
        color: AppColors.darkblue,
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(
              top: 20,
              left: 15,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: viewModel.formKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.55,
                        child: TextFormField(
                          onChanged: (text) {
                            viewModel.taskTitle.text = text;
                          },
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Please, enter the task you want to do';
                            }
                            return null;
                          },
                          controller: viewModel
                              .taskTitle, // Use the ViewModel's TextEditingController
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          decoration: InputDecoration(
                            hintText: "What are you up to?",
                          ),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          // Use Provider to add the task
                          viewModel.enterTask(context);
                        },
                        child: Icon(Icons.arrow_upward_rounded),
                          color: Colors.white,
                        shape: CircleBorder()
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.03),
                TextButton(
                    onPressed: () {
                      showCalender();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("set due date ",
                            style: TextStyle(
                                color: AppColors.sky,
                                fontSize: 23,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.sky)),
                        Padding(
                          padding: const EdgeInsets.only(right: 18),
                          child: Icon(
                            Icons.calendar_month_outlined,
                            color: AppColors.sky,
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showCalender() async {
    var choosenDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 1825)),
    );

    if (choosenDate != null) {
      var choosenTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (choosenTime != null) {
        setState(() {
          viewModel.dateTime = DateTime(
            choosenDate.year,
            choosenDate.month,
            choosenDate.day,
            choosenTime.hour,
            choosenTime.minute,
          );
        });
      }
    }
  }
}