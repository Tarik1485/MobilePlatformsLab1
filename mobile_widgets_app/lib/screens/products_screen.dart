import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final List<Product> products = const [
    Product(
      id: '1',
      name: 'Навушники',
      description: 'Зручні навушники для музики та ігор.',
      price: 1299.00,
      imageUrl: '',
      category: 'Електроніка',
    ),
    Product(
      id: '2',
      name: 'Комп’ютерна миша',
      description: 'Миша для щоденної роботи та ігор.',
      price: 799.00,
      imageUrl: '',
      category: 'Аксесуари',
    ),
    Product(
      id: '3',
      name: 'Клавіатура',
      description: 'Зручна клавіатура для навчання.',
      price: 1499.00,
      imageUrl: '',
      category: 'Аксесуари',
    ),
    Product(
      id: '4',
      name: 'Рюкзак',
      description: 'Місткий рюкзак для ноутбука.',
      price: 1899.00,
      imageUrl: '',
      category: 'Одяг та аксесуари',
    ),
  ];

  final Set<String> cart = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Каталог товарів'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Badge(
                label: Text('${cart.length}'),
                child: const Icon(Icons.shopping_cart_outlined),
              ),
            ),
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate:
            const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 320,
          mainAxisExtent: 365,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return ProductCard(
            product: product,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Обрано: ${product.name}'),
                ),
              );
            },
            onAddToCart: () {
              setState(() {
                cart.add(product.id);
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${product.name} додано до кошика'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}