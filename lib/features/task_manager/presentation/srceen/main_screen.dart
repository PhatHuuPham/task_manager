import 'package:flutter/material.dart';
import 'package:task_manager/features/task_manager/presentation/srceen/authetiation.dart';
import 'package:task_manager/features/task_manager/presentation/srceen/home.dart';
import 'package:task_manager/features/task_manager/presentation/srceen/setting.dart';
import 'package:task_manager/features/task_manager/presentation/srceen/task.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late PageController _pageController;
  // Danh sách các màn hình
  @override
  void initState() {
    super.initState();
    _pageController = PageController(); // Khởi tạo PageController
  }

  @override
  void dispose() {
    _pageController.dispose(); // Hủy PageController khi không dùng nữa
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: const [
          HomePage(),
          TaskPage(),
          AuthenticationPage(),
          SettingPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.jumpToPage(
            index,
          );
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'settings',
          ),
        ],
      ),
    );
  }
}
