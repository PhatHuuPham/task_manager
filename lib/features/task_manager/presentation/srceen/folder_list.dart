import 'package:flutter/material.dart';

class FolderListPage extends StatefulWidget {
  const FolderListPage({super.key});

  @override
  State<FolderListPage> createState() => _FolderListPageState();
}

class _FolderListPageState extends State<FolderListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Folder List"),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Thêm công việc
            },
          ),
        ],
      ),
      body: const Column(
        children: [
          ListTile(
            title: Text("Folder 1"),
          ),
          ListTile(
            title: Text("Folder 2"),
          ),
          ListTile(
            title: Text("Folder 3"),
          ),
        ],
      ),
    );
  }
}
