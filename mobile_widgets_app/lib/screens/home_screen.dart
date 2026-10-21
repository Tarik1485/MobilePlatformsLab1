import 'package:flutter/material.dart';
import '../utils/themes.dart';
import '../widgets/custom_button.dart';
import '../widgets/animated_counter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mobile Widgets')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.widgets_rounded,
                  size: 90,
                  color: AppThemes.primaryColor,
                ),
                const SizedBox(height: 20),
                Text(
                  'ібліотека віджетів',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 12),
                const Text(
                  'рактична робота 5\nозробка віджетів у Flutter',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
Row(
  children: const [
    Expanded(
      child: AnimatedCounter(
        value: 4,
        label: 'Товари в каталозі',
      ),
    ),
    SizedBox(width: 12),
    Expanded(
      child: AnimatedCounter(
        value: 3,
        label: 'Стилі кнопок',
      ),
    ),
  ],
),
const SizedBox(height: 20),
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          size: 48,
                          color: Colors.green,
                        ),
                        SizedBox(height: 12),
                        Text('астосунок працює!'),
                        SizedBox(height: 8),
                        Text(
                          'емонстрація власних віджетів, '
                          'анімацій та інтерактивних карток.',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                CustomButton(
                  text: 'еревірити кнопку',
                  icon: const Icon(Icons.touch_app),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('ласна кнопка працює!'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                CustomButton(
                  text: 'руга кнопка',
                  style: CustomButtonStyle.secondary,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('ругий стиль працює!'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                CustomButton(
                  text: 'онтурна кнопка',
                  style: CustomButtonStyle.outline,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('онтурний стиль працює!'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
