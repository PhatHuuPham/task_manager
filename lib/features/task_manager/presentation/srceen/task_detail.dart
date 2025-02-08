import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/features/task_manager/logic/providers/task_provider.dart';

class TaskDetailPage extends StatefulWidget {
  final String taskId;

  const TaskDetailPage({super.key, required this.taskId});

  @override
  // ignore: library_private_types_in_public_api
  _TaskDetailPageState createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider.withId(widget.taskId),
      child: Consumer<TaskProvider>(
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: const Text('Task Detail'),
            actions: [
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  value.deleteTask(widget.taskId);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: value.taskNameController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: value.taskDescriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          value.selectedDate == null
                              ? value.date
                              : ' ${DateFormat.yMd().format(value.selectedDate!)}',
                        ),
                      ),
                      TextButton(
                        onPressed: () =>
                            Provider.of<TaskProvider>(context, listen: false)
                                .selectDate(context),
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
                              ? value.time
                              : ' ${value.selectedTime!.format(context)}',
                        ),
                      ),
                      TextButton(
                        onPressed: () =>
                            Provider.of<TaskProvider>(context, listen: false)
                                .selectTime(context),
                        child: const Text('Choose Time'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => {
                    value.updateTask(
                        widget.taskId,
                        value.taskNameController.text,
                        value.taskDescriptionController.text,
                        value.date,
                        value.time),
                    Navigator.pop(context)
                  },
                  child: const Text('Update Task'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
