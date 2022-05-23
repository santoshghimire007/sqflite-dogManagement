import 'package:dog_management/screens/display_screen.dart';
import 'package:dog_management/screens/update_screen.dart';
// import 'package:dog_management/screens/update_screen.dart';
import 'package:flutter/material.dart';
import 'screens/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      // initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dog Management System'),
          bottom: TabBar(
            controller: _controller,
            tabs: const [
              Tab(
                text: 'Home',
                icon: Icon(Icons.home),
              ),
              Tab(
                text: 'Display',
                icon: Icon(Icons.display_settings),
              )
              // Tab(
              //   text: 'Update',
              // ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            const HomePage(),
            DisplayScreen(),

            // UpdateScreen(age: 2, title: ''),
          ],
        ),
      ),
    );
  }
}
