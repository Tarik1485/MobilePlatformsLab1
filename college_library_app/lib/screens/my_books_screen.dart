import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/auth_model.dart';
import '../models/library_model.dart';

class MyBooksScreen extends StatelessWidget {
  const MyBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthModel>();
    final library = context.watch<LibraryModel>();

    if (!auth.isLoggedIn) {
      return Scaffold(
        appBar: AppBar(title: const Text('Мої книги')),
        body: Center(
          child: FilledButton(
            onPressed: () => context.go('/login'),
            child: const Text('Увійти, щоб переглянути книги'),
          ),
        ),
      );
    }

    final books = library.reservedBooks;

    return Scaffold(
      appBar: AppBar(title: const Text('Мої книги')),
      body: books.isEmpty
          ? const Center(
              child: Text('У вас поки немає заброньованих книг.'),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                final date = library.returnDateFor(book.id)!;

                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.menu_book, color: Colors.indigo),
                    title: Text(book.title),
                    subtitle: Text(
                      'Повернути до: ${date.day.toString().padLeft(2, '0')}.'
                      '${date.month.toString().padLeft(2, '0')}.'
                      '${date.year}',
                    ),
                    trailing: IconButton(
                      tooltip: 'Скасувати бронювання',
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () =>
                          library.cancelReservation(book.id),
                    ),
                    onTap: () => context.push('/catalog/book/${book.id}'),
                  ),
                );
              },
            ),
    );
  }
}