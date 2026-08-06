import 'package:flutter/material.dart';

void main() {
  runApp(const TermoFlowApp());
}

class TermoFlowApp extends StatelessWidget {
  const TermoFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TermoFlow',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange, 
          brightness: Brightness.dark, // Темная тема
        ),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Начинаем со вкладки "Гриль" (индекс 2)
  int _selectedIndex = 2; 

  // Заглушки для наших будущих экранов
  static const List<Widget> _screens = <Widget>[
    Center(child: Text('Холодильники и запасы', style: TextStyle(fontSize: 24))),
    Center(child: Text('Рецепты', style: TextStyle(fontSize: 24))),
    Center(child: Text('Термометры и готовка', style: TextStyle(fontSize: 24))),
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
        title: const Text('TermoFlow', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: _screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.kitchen),
            label: 'Запасы',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Рецепты',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.thermostat),
            label: 'Гриль',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepOrange,
        onTap: _onItemTapped,
      ),
    );
  }
}