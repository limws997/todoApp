import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:technical_assessment/components/todobox.dart';
import '../../provider/provider.dart';
import '../todo/todo_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var todoList = ref.watch(todoRepositoryProvider).returnAllTodo();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.orange,
          centerTitle: false,
          title: const Text(
            
            'To-do List',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
        ),
        body: SingleChildScrollView(
            child: Container(
              height: screenHeight,
          child: todoList.isEmpty
              ?  Container(
                height: screenHeight*0.7,
                
                alignment: Alignment.center,
                child: const Text('Empty Todo List',style: TextStyle(fontSize: 20),),)
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: todoList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TodoBox(
                      remark: todoList[index].remark,
                      endDate: todoList[index].endDate,
                      iscomplete: todoList[index].iscomplete,
                      screenWidth: screenWidth,
                      startDate: todoList[index].startDate,
                      timeLeft: todoList[index].timeLeft,
                      index: index,
                    );
                  }),
        )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepOrange,
          onPressed: () {
            ref.read(todoRepositoryProvider).updateStartDate('Select a date');
            ref.read(todoRepositoryProvider).updateEndDate('Select a date');
            ref.read(todoRepositoryProvider).updateRemark('');
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) => Page2(isupdate: false)));
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
