import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/features/task_manager/presentation/srceen/task_create.dart';
import 'package:task_manager/features/task_manager/presentation/srceen/task_detail.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task"),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Thêm công việc
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TaskCreatePage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final tasks = snapshot.data?.docs ?? [];
            return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(
                    task['name'],
                    style: TextStyle(
                      decoration: task.data().containsKey('isDone')
                          ? task['isDone']
                              ? TextDecoration.lineThrough
                              : TextDecoration.none
                          : TextDecoration.none,
                    ),
                  ),
                  subtitle: Text(task['date']),
                  trailing: Checkbox(
                      value: task.data().containsKey('isDone')
                          ? task['isDone']
                          : false,
                      onChanged: (value) {
                        FirebaseFirestore.instance
                            .collection('tasks')
                            .doc(task.id)
                            .update({
                          'isDone': value,
                        });
                      }),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskDetailPage(taskId: task.id),
                      ),
                    );
                  },
                );
              },
            );
          }),
    );
  }
}
