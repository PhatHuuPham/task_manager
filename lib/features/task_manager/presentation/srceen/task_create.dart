import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskCreatePage extends StatefulWidget {
  const TaskCreatePage({super.key});

  @override
  State<TaskCreatePage> createState() => _TaskCreatePageState();
}

class _TaskCreatePageState extends State<TaskCreatePage> {
  final TextEditingController _taskNameController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _taskNameController.addListener(_saveTask);
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    super.dispose();
  }

  void addTask() async {
    await FirebaseFirestore.instance.collection('tasks').add({
      'taskName': _taskNameController.text,
      'taskDate': _selectedDate,
      'taskTime': _selectedTime,
    });
  }

  void _saveTask() {
    final taskName = _taskNameController.text;
    final taskDate = _selectedDate;
    final taskTime = _selectedTime;
    setState(() {
      _isSaved = taskName.isNotEmpty && taskDate != null && taskTime != null;
    });
  }

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
      setState(() {
        _selectedDate = pickedDate;
        _saveTask();
      });
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
      setState(() {
        _selectedTime = pickedTime;
        _saveTask();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      controller: _taskNameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Task name',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: const TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Task folder',
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _selectedDate == null
                                ? 'No Date Chosen!'
                                : ' ${DateFormat.yMd().format(_selectedDate!)}',
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
                            _selectedTime == null
                                ? 'No Time Chosen!'
                                : ' ${_selectedTime!.format(context)}',
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
                  onPressed: _isSaved ? () {} : null,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 25),
                  ),
                  child: Text(
                    'Lưu',
                    style: TextStyle(
                      color: _isSaved ? Colors.black : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
