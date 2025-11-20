import 'package:flutter/material.dart';
import 'pages/home_screen.dart';
import 'pages/login_screen.dart';
import 'pages/calendar_screen.dart';
import 'pages/compass_screen.dart';
import 'pages/settings_screen.dart';

void main() {
  // Pastikan Anda memanggil runApp dengan layar awal (LoginScreen/MainAppScreen)
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Sholat Cerdas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Skema warna hijau sesuai desain Figma
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.green.shade700,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green.shade700,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        // Tema untuk Bottom Navigation Bar
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
        ),
        useMaterial3: true,
      ),
      // Kita asumsikan alur dimulai dari Login, seperti yang ada di desain Anda
      home: const LoginScreen(),
      routes: {
        '/home': (context) => const MainAppScreen(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _selectedIndex = 0;

  // Daftar widget untuk Bottom Navigation Bar
  late final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(), // 1. Home (Waktu Sholat)
    const CalendarScreen(), // 2. Calendar
    const CompassScreen(), // 3. Compass
    const SettingsScreen(), // 4. Settings
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Waktu Sholat Cerdas',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Compass'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Setting'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}