import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/book.dart';

class BookScreen extends StatelessWidget {
  final String bookId;

  const BookScreen({super.key, required this.bookId});

  @override
  Widget build(BuildContext context) {
    final matches = sampleBooks.where((b) => b.id == bookId);

    if (matches.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Книгу не знайдено')),
        body: const Center(child: Text('Такої книги немає в каталозі.')),
      );
    }

    final book = matches.first;

    return Scaffold(
      appBar: AppBar(title: const Text('Інформація про книгу')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Icon(Icons.menu_book, size: 100, color: Colors.indigo),
          const SizedBox(height: 20),
          Text(book.title,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center),
          const SizedBox(height: 12),
          Text('Автор: ${book.author}', textAlign: TextAlign.center),
          Text('Жанр: ${book.genre}', textAlign: TextAlign.center),
          Text('Рік видання: ${book.year}', textAlign: TextAlign.center),
          const SizedBox(height: 24),
          Text(book.description,
              style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => context.push('/catalog/book/${book.id}/reserve'),
            icon: const Icon(Icons.bookmark_add),
            label: const Text('Забронювати книгу'),
          ),
        ],
      ),
    );
  }
}