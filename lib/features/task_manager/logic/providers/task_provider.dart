import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskProvider extends ChangeNotifier {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  bool isSaved = false;

  @override
  TaskProvider() {
    taskNameController.addListener(_saveTask);
  }

  @override
  void dispose() {
    taskNameController.dispose();
    taskDescriptionController.dispose();
    selectedDate = null;
    selectedTime = null;
    super.dispose();
  }

  void updateSelectDate(DateTime date) {
    selectedDate = date;
    _saveTask();
    notifyListeners();
  }

  void updateSelectTime(TimeOfDay time) {
    selectedTime = time;
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
}
