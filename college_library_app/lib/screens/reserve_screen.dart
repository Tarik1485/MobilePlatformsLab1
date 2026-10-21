import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../models/library_model.dart';

class ReserveScreen extends StatefulWidget {
  final String bookId;

  const ReserveScreen({super.key, required this.bookId});

  @override
  State<ReserveScreen> createState() => _ReserveScreenState();
}

class _ReserveScreenState extends State<ReserveScreen> {
  DateTime? returnDate;

  @override
  Widget build(BuildContext context) {
    final matches = sampleBooks.where((b) => b.id == widget.bookId);

    if (matches.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Бронювання')),
        body: const Center(child: Text('Книгу не знайдено')),
      );
    }

    final book = matches.first;

    return Scaffold(
      appBar: AppBar(title: const Text('Бронювання книги')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.bookmark_add, size: 72, color: Colors.indigo),
            const SizedBox(height: 20),
            Text(book.title,
                style: Theme.of(context).textTheme.headlineSmall),
            Text('Автор: ${book.author}'),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              onPressed: () async {
                final date = await context.push<DateTime>('/choose-date');
                if (date != null && mounted) {
                  setState(() => returnDate = date);
                }
              },
              icon: const Icon(Icons.calendar_month),
              label: Text(returnDate == null
                  ? 'Обрати дату повернення'
                  : 'Дата: ${returnDate!.day.toString().padLeft(2, '0')}.'
                    '${returnDate!.month.toString().padLeft(2, '0')}.'
                    '${returnDate!.year}'),
            ),
            const Spacer(),
            FilledButton(
              onPressed: returnDate == null
                  ? null
                  : () {
                      context.read<LibraryModel>().reserveBook(
                            book.id,
                            returnDate!,
                          );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Книгу заброньовано!')),
                      );
                      context.go('/my-books');
                    },
              child: const Text('Підтвердити бронювання'),
            ),
          ],
        ),
      ),
    );
  }
}