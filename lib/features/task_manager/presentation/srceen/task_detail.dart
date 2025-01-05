import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskDetailPage extends StatefulWidget {
  final String taskId;

  const TaskDetailPage({super.key, required this.taskId});

  @override
  // ignore: library_private_types_in_public_api
  _TaskDetailPageState createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTaskData();
  }

  void _loadTaskData() async {
    DocumentSnapshot taskDoc =
        await _firestore.collection('tasks').doc(widget.taskId).get();
    if (taskDoc.exists) {
      setState(() {
        _titleController.text = taskDoc['name'];
        _descriptionController.text = taskDoc['description'];
        _dateController.text = taskDoc['date'];
        _timeController.text = taskDoc['time'];
      });
    }
  }

  void _updateTask() async {
    await _firestore.collection('tasks').doc(widget.taskId).update({
      'name': _titleController.text,
      'description': _descriptionController.text,
      'date': _dateController.text,
      'time': _timeController.text,
    });
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  void _deleteTask() async {
    await _firestore.collection('tasks').doc(widget.taskId).delete();
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Detail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: _deleteTask,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(labelText: 'date'),
            ),
            TextField(
              controller: _timeController,
              decoration: const InputDecoration(labelText: 'time'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateTask,
              child: const Text('Update Task'),
            ),
          ],
        ),
      ),
    );
  }
}
