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
  // Начинаем со вкладки "Запасы" (индекс 0)
  int _selectedIndex = 0; 

  // Подключаем наши экраны
  static const List<Widget> _screens = <Widget>[
    InventoryScreen(), 
    Center(child: Text('Рецепты', style: TextStyle(fontSize: 24))),
    GrillScreen(), 
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

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Временные данные для проверки интерфейса
    final List<Map<String, dynamic>> items = [
      {'name': 'Стейк Рибай (PrimeFoods)', 'package': 'Вакуум', 'daysLeft': 14},
      {'name': 'Брискет', 'package': 'Вакуум', 'daysLeft': 5},
      {'name': 'Говяжья вырезка', 'package': 'Обычный пакет', 'daysLeft': 1},
    ];

    return ListView.builder(
      padding: const EdgeInsets.only(top: 16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final int days = item['daysLeft'];
        
        // Логика цветовой индикации сроков
        Color daysColor = Colors.greenAccent; // Всё отлично
        if (days <= 2) {
          daysColor = Colors.redAccent; // Срочно готовить
        } else if (days <= 6) {
          daysColor = Colors.orangeAccent; // Скоро истекает
        }

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: CircleAvatar(
              backgroundColor: Colors.deepOrange.withOpacity(0.2),
              child: const Icon(Icons.kitchen, color: Colors.deepOrange),
            ),
            title: Text(
              item['name'], 
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  Icon(
                    item['package'] == 'Вакуум' ? Icons.check_circle : Icons.inventory_2, 
                    size: 16, 
                    color: Colors.grey
                  ),
                  const SizedBox(width: 6),
                  Text(item['package']),
                ],
              ),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$days дн.', 
                  style: TextStyle(color: daysColor, fontWeight: FontWeight.bold, fontSize: 20)
                ),
                const Text('осталось', style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        );
      },
    );
  }
}

class GrillScreen extends StatelessWidget {
  const GrillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Карточка активного процесса
        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.between,
                  children: const [
                    Text(
                      '🔥 Рибай на решетке',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Chip(
                      label: Text('Готовится', style: TextStyle(color: Colors.white)),
                      backgroundColor: Colors.deepOrange,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Зонд 1: Мясо
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Зонд 1 (Центр стейка):', style: TextStyle(color: Colors.grey)),
                    Text('54°C / 58°C', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orangeAccent)),
                  ],
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: 54 / 58,
                  backgroundColor: Colors.grey.shade800,
                  color: Colors.deepOrange,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
                const SizedBox(height: 16),
                // Зонд 2: Гриль / Камера
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Температура в камере:', style: TextStyle(color: Colors.grey)),
                    Text('135°C', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}