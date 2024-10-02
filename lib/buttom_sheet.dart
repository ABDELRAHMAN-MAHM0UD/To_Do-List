import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_release/task_widget/task_widget.dart';
import 'package:to_do_release/view_model.dart';
import 'package:to_do_release/colors.dart';
import 'package:provider/provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final ViewModel viewModel = ViewModel(); // Create an instance of ViewModel

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      color: AppColors.darkblue,
      height: double.infinity,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 20, left: 15),
        child: Column(
          children: [
            Form(
              key: viewModel.formKey,
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
                controller: viewModel.taskTitle, // Use the ViewModel's TextEditingController
                style: TextStyle(color: Colors.white, fontSize: 20),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: AppColors.sky, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    borderSide: BorderSide(color: AppColors.grey, width: 2),
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            Text(
              "What are you up to?",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            SizedBox(height: height * 0.27),
            Container(
              width: width * 0.7,
              child: ElevatedButton(
                onPressed: () {
                  // Use Provider to add the task
                  viewModel.enterTask(context);
                },
                child: Text("Enter"),
                style: ButtonStyle(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
