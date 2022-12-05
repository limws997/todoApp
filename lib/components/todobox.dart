// Todo List Widgets
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../provider/provider.dart';
import '../screens/todo/todo_screen.dart';

class TodoBox extends ConsumerWidget {
  TodoBox({
    Key? key,
    required this.index,
    required this.remark,
    required this.screenWidth,
    required this.iscomplete,
    required this.startDate,
    required this.endDate,
    required this.timeLeft,
  }) : super(key: key);

  final int index;
  final double screenWidth;
  final String remark;
  final bool iscomplete;
  final DateTime startDate;
  final DateTime endDate;
  final String timeLeft;

  var formatDate1 = DateFormat('dd MMM yyyy');
  var formatDate2 = DateFormat('dd MMM yyyy  hh:mm:a');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var repoRead = ref.read(todoRepositoryProvider);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              repoRead.updateStartDate(formatDate2.format(startDate));
              repoRead.updateEndDate(formatDate2.format(endDate));
              repoRead.updateRemark(remark);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Page2(
                            isupdate: true,
                            index: index,
                          )));
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              width: screenWidth * 0.95,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    remark,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Start Date'),
                            Text(
                              formatDate1.format(startDate),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('End Date'),
                            Text(
                              formatDate1.format(endDate),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Time left'),
                            Text(
                              timeLeft,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 8, right: 8),
            decoration: BoxDecoration(
              color: Colors.blueGrey[100],
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Status  ',
                  style: TextStyle(color: Colors.black54),
                ),
                Text(
                  iscomplete ? 'Complete' : 'Incomplete',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                const Text(
                  'Tick if completed',
                  style: TextStyle(color: Colors.black87),
                ),
                Checkbox(
                    value: iscomplete,
                    onChanged: (value) {
                      ref
                          .read(todoRepositoryProvider)
                          .updateTodoCheckbox(!iscomplete, index);
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
