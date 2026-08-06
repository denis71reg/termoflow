import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

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
          brightness: Brightness.dark,
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
  int _selectedIndex = 0; 

  static const List<Widget> _screens = <Widget>[
    InventoryScreen(), 
    RecipesScreen(), 
    GrillScreen(), 
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      child: Scaffold(
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
      ),
    );
  }
}

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        
        Color daysColor = Colors.greenAccent;
        if (days <= 2) {
          daysColor = Colors.redAccent;
        } else if (days <= 6) {
          daysColor = Colors.orangeAccent;
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

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> recipes = [
      {
        'title': 'Стейк Рибай (Ribeye)',
        'temp': '54°C - 58°C (Medium Rare)',
        'time': '15-20 мин',
        'description': 'Классический мраморный отруб. Обжарка на прямом жаре до корочки, затем доведение до целевой температуры в зоне косвенного жара.',
      },
      {
        'title': 'Техасский Брискет (Brisket)',
        'temp': '93°C - 96°C',
        'time': '12-16 часов',
        'description': 'Говяжья грудинка низкотемпературного копчения (Low & Slow). Требует стабильного поддержания температуры в камере около 110-120°C.',
      },
      {
        'title': 'Свиные ребрышки 3-2-1',
        'temp': 'До отделения от кости',
        'time': '6 часов',
        'description': 'Легендарный метод BBQ: 3 часа копчения на решетке, 2 часа в фольге с соком/маслом и 1 час досушивания с глазурью.',
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: recipes.length,
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        recipe['title'],
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Chip(
                      label: Text(recipe['time'], style: const TextStyle(color: Colors.white, fontSize: 12)),
                      backgroundColor: Colors.deepOrange,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.local_fire_department, size: 16, color: Colors.orangeAccent),
                    const SizedBox(width: 6),
                    Text(
                      'Цель: ${recipe['temp']}',
                      style: const TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  recipe['description'],
                  style: const TextStyle(color: Colors.grey, height: 1.4),
                ),
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
        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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