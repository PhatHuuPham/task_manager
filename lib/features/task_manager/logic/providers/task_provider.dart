import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String date = '';
  String time = '';
  bool isSaved = false;

  @override
  TaskProvider() {
    taskNameController.addListener(_saveTask);
  }
  @override
  TaskProvider.withId(String id) {
    loadTask(id);
  }

  @override
  void dispose() {
    taskNameController.dispose();
    taskDescriptionController.dispose();
    selectedDate = null;
    selectedTime = null;
    date = '';
    time = '';
    super.dispose();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    selectedDate = picked;
    date = DateFormat('yyyy-MM-dd').format(selectedDate!);
    _saveTask();
    notifyListeners();
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    selectedTime = picked;
    // ignore: use_build_context_synchronously
    time = selectedTime!.format(context);
    _saveTask();
    notifyListeners();
  }

  void _saveTask() {
    final taskName = taskNameController.text;
    final taskDate = selectedDate;
    final taskTime = selectedTime;
    isSaved = taskName.isNotEmpty && taskDate != null && taskTime != null;
    notifyListeners();
  }

  // C R U D

  void addTask(
      String name, String description, String date, String time) async {
    await FirebaseFirestore.instance.collection('tasks').add({
      'name': name,
      'description': description,
      'date': date, // Lưu định dạng yyyy-MM-dd
      'time': time, // Lưu định dạng HH:mm
      'createdAt':
          FieldValue.serverTimestamp(), // Ngày giờ tạo tự động từ server
      'isDone': false, // Mặc định chưa hoàn thành
    });
  }

  void loadTask(String id) async {
    DocumentSnapshot taskDoc =
        await _firestore.collection('tasks').doc(id).get();
    if (taskDoc.exists) {
      taskNameController.text = taskDoc['name'];
      taskDescriptionController.text = taskDoc['description'];
      date = taskDoc['date'];
      time = taskDoc['time'];
    }
    notifyListeners();
  }

  void updateTask(String id, String name, String description, String date,
      String time) async {
    await FirebaseFirestore.instance.collection('tasks').doc(id).update({
      'name': name,
      'description': description,
      'date': date,
      'time': time,
    });
  }

  void deleteTask(String id) async {
    if (id.isNotEmpty) await _firestore.collection('tasks').doc(id).delete();
  }
}
