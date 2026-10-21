import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DatePickerScreen extends StatefulWidget {
  const DatePickerScreen({super.key});

  @override
  State<DatePickerScreen> createState() => _DatePickerScreenState();
}

class _DatePickerScreenState extends State<DatePickerScreen> {
  DateTime selectedDate = DateTime.now().add(const Duration(days: 14));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Дата повернення')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(Icons.calendar_month, size: 80, color: Colors.indigo),
            const SizedBox(height: 20),
            const Text('Оберіть дату повернення книги'),
            const SizedBox(height: 16),
            Text(
              '${selectedDate.day.toString().padLeft(2, '0')}.'
              '${selectedDate.month.toString().padLeft(2, '0')}.'
              '${selectedDate.year}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime.now().add(const Duration(days: 1)),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (date != null && mounted) {
                  setState(() => selectedDate = date);
                }
              },
              child: const Text('Обрати дату'),
            ),
            const Spacer(),
            FilledButton.icon(
              onPressed: () => context.pop(selectedDate),
              icon: const Icon(Icons.check),
              label: const Text('Підтвердити дату'),
            ),
          ],
        ),
      ),
    );
  }
}