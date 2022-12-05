import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../components/failtoast.dart';
import '../../components/mydatepicker.dart';
import '../../components/timesleftchecker.dart';
import '../../models/todo_model.dart';
import '../../provider/provider.dart';

// ignore: must_be_immutable
class Page2 extends ConsumerWidget {
  Page2({super.key, required this.isupdate, this.index});
  final bool isupdate;
  final int? index;
  TextEditingController _todotitleController = TextEditingController();
  DateTime? selectedTime, selectedTime2;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var todoList = ref.read(todoRepositoryProvider).returnAllTodo();
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var formatterD = DateFormat('dd MMM yyyy  hh:mm:a');

    if (isupdate) {
      _todotitleController.text =
          ref.watch(todoRepositoryProvider).returnDisplayRemark();
    
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          centerTitle: false,
          title: Text(
            isupdate ? 'Update To-Do List' : 'Add new To-Do List',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'To-do Title',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5, bottom: 5),
                alignment: Alignment.centerLeft,
                child: TextFormField(
                  controller: _todotitleController,
                  maxLines: 5,
                  autofocus: false,
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(fontWeight: FontWeight.w300),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: 'Please key in your To-Do title here',
                    // contentPadding:
                    //     EdgeInsets.only(bottom: 80, left: 10, right: 10),
                    focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red)),
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87)),
                    filled: true,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Start Date',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                  onTap: () async {
                    selectedTime =
                        (await myDateTimePicker(context)) ?? DateTime.now();
                    ref
                        .watch(todoRepositoryProvider)
                        .updateStartDate(formatterD.format(selectedTime!));

                    
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 5, bottom: 10),
                    padding: const EdgeInsets.only(left: 10, right: 8),
                    height: 50,
                    width: screenWidth,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black87)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ref
                              .watch(todoRepositoryProvider)
                              .returnDisplayStartDate(),
                          style: TextStyle(color: Colors.black54),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Colors.black45,
                        )
                      ],
                    ),
                  )),
              Text(
                'End Date',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                  onTap: () async {
                    selectedTime2 =
                        (await myDateTimePicker(context)) ?? DateTime.now();

                    await ref
                        .read(todoRepositoryProvider)
                        .updateEndDate(formatterD.format(selectedTime2!));
                    
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 5, bottom: 5),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 10, right: 8),
                    height: 50,
                    width: screenWidth,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black87)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ref
                              .read(todoRepositoryProvider)
                              .returnDisplayEndDate(),
                          style: const TextStyle(color: Colors.black54),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Colors.black45,
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: ElevatedButton(
          onPressed: () {
            var startdate =
                ref.read(todoRepositoryProvider).returnDisplayStartDate();
            var enddate =
                ref.read(todoRepositoryProvider).returnDisplayEndDate();
            if (_todotitleController.text.isNotEmpty &&
                startdate != 'Select a date' &&
                enddate != 'Select a date') {
              //  to count time dif of two datetime

              if (isupdate) {
                var timeleft = timesleftchecker(
                    selectedTime ?? todoList[index].startDate,
                    selectedTime2 ?? todoList[index].endDate);
                if (timeleft < 0) {
                  failToast('End Date unable earlier than Start Date');
                  return;
                }
                //  convert timelft to String format, to display at homescreen

                var timeleftstring = timeleftstringchecker(timeleft);

                ref.read(todoRepositoryProvider).updateTodo(
                    TodoModel(
                        remark: _todotitleController.text.toString(),
                        startDate: selectedTime ?? todoList[index].startDate,
                        endDate: selectedTime2 ?? todoList[index].endDate,
                        timeLeft: timeleftstring,
                        iscomplete: todoList[index].iscomplete),
                    index!);
              } else {
                var timeleft = timesleftchecker(selectedTime!, selectedTime2!);
                //  convert timelft to String format, to display at homescreen
                if (timeleft < 0) {
                  failToast('End Date unable earlier than Start Date');
                  return;
                }
                var timeleftstring = timeleftstringchecker(timeleft);
                ref.read(todoRepositoryProvider).addTodo(TodoModel(
                    remark: _todotitleController.text.toString(),
                    startDate: selectedTime!,
                    endDate: selectedTime2!,
                    timeLeft: timeleftstring,
                    iscomplete: false));
              }
            } else {
              failToast('Please fill up all');
              return;
            }

            Navigator.pop(context);
          },
          child: Text(isupdate ? 'Update' : 'Create Now'),
          style: ElevatedButton.styleFrom(
              fixedSize: Size(screenWidth, 50), backgroundColor: Colors.black),
        ),
      ),
    );
  }
}
