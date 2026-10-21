import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'State Management',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      home: const CounterPage(),
    );
  }
}

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int counter = 0;
  final List<int> history = [];

  void increment() {
    setState(() {
      counter++;
      history.add(counter);
    });
  }

  void decrement() {
    if (counter > 0) {
      setState(() {
        counter--;
        history.add(counter);
      });
    }
  }

  void reset() {
    setState(() {
      counter = 0;
      history.add(counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('State Management'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.touch_app,
                size: 70,
                color: Colors.indigo,
              ),
              const SizedBox(height: 16),
              const Text(
                'Поточне значення лічильника:',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 12),
              Text(
                '$counter',
                style: const TextStyle(
                  fontSize: 56,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 12,
                children: [
                  ElevatedButton.icon(
                    onPressed: decrement,
                    icon: const Icon(Icons.remove),
                    label: const Text('Зменшити'),
                  ),
                  ElevatedButton.icon(
                    onPressed: increment,
                    icon: const Icon(Icons.add),
                    label: const Text('Збільшити'),
                  ),
                  OutlinedButton.icon(
                    onPressed: reset,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Скинути'),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              const Text(
                'Історія змін',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: history.isEmpty
                    ? const Center(
                        child: Text('Історія поки порожня'),
                      )
                    : ListView.builder(
                        itemCount: history.length,
                        reverse: true,
                        itemBuilder: (context, index) {
                          final value =
                              history[history.length - 1 - index];

                          return ListTile(
                            leading: const Icon(Icons.history),
                            title: Text('Значення: $value'),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}