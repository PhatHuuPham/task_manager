import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/features/task_manager/logic/providers/task_provider.dart';
import 'package:task_manager/features/task_manager/presentation/srceen/task_create.dart';
import 'package:task_manager/features/task_manager/presentation/srceen/task_detail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: Consumer<TaskProvider>(
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.list_task),
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
              stream:
                  FirebaseFirestore.instance.collection('tasks').snapshots(),
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
                      leading: InkWell(
                        onTap: () {
                          FirebaseFirestore.instance
                              .collection('tasks')
                              .doc(task.id)
                              .update({
                            'isDone': !task['isDone'],
                          });
                        },
                        child: SizedBox(
                          width: 40,
                          height: 60,
                          child: Checkbox(
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
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TaskDetailPage(taskId: task.id),
                          ),
                        );
                      },
                    );
                  },
                );
              }),
        ),
      ),
    );
  }
}
