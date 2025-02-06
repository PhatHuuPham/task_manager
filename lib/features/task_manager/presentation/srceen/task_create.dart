import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/features/task_manager/logic/providers/task_provider.dart';

class TaskCreatePage extends StatefulWidget {
  const TaskCreatePage({super.key});

  @override
  State<TaskCreatePage> createState() => _TaskCreatePageState();
}

class _TaskCreatePageState extends State<TaskCreatePage> {
  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      // ignore: use_build_context_synchronously
      Provider.of<TaskProvider>(context, listen: false)
          .updateSelectDate(pickedDate);
    });
  }

  void _showTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((pickedTime) {
      if (pickedTime == null) {
        return;
      }
      // ignore: use_build_context_synchronously
      Provider.of<TaskProvider>(context, listen: false)
          .updateSelectTime(pickedTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Task Create"),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                // Thêm công việc
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: value.taskNameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Task name',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: value.taskDescriptionController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Task description',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              value.selectedDate == null
                                  ? 'No Date Chosen!'
                                  : ' ${DateFormat.yMd().format(value.selectedDate!)}',
                            ),
                          ),
                          TextButton(
                            onPressed: _showDatePicker,
                            child: const Text('Choose Date'),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              value.selectedTime == null
                                  ? 'No Time Chosen!'
                                  : ' ${value.selectedTime!.format(context)}',
                            ),
                          ),
                          TextButton(
                            onPressed: _showTimePicker,
                            child: const Text('Choose Time'),
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   padding: const EdgeInsets.all(10),
                    //   child: TextButton(
                    //     onPressed: () => {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => const FolderListPage(),
                    //         ),
                    //       ),
                    //     },
                    //     child: const Text('Choose Folder'),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            Container(
              // padding: EdgeInsets.only(
              //   bottom: MediaQuery.of(context).viewInsets.bottom + 10,
              // ),
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: value.isSaved
                        ? () {
                            value.addTask(
                              value.taskNameController.text,
                              value.taskDescriptionController.text,
                              DateFormat('yyyy-MM-dd')
                                  .format(value.selectedDate!),
                              value.selectedTime!.format(context),
                            );
                            Navigator.pop(context);
                          }
                        : null,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60, vertical: 25),
                    ),
                    child: Text(
                      'Lưu',
                      style: TextStyle(
                        color: value.isSaved ? Colors.black : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
