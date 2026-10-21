import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/book.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  String genre = 'Усі';

  @override
  Widget build(BuildContext context) {
    final genres = ['Усі', ...sampleBooks.map((b) => b.genre).toSet()];
    final books = sampleBooks
        .where((b) => genre == 'Усі' || b.genre == genre)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Бібліотека коледжу'),
        actions: [
          IconButton(
            tooltip: 'Пошук',
            onPressed: () => context.go('/catalog?genre=$genre'),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 58,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              children: genres.map((g) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(g),
                  selected: genre == g,
                  onSelected: (_) => setState(() => genre = g),
                ),
              )).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: books.length,
              itemBuilder: (context, index) {
                final book = books[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(book.id),
                    ),
                    title: Text(book.title),
                    subtitle: Text('${book.author}\n${book.genre} • ${book.year}'),
                    isThreeLine: true,
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => context.push('/catalog/book/${book.id}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}