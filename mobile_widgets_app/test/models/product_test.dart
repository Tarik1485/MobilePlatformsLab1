import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_widgets_app/models/product.dart';

void main() {
  group('Product model tests', () {
    const product = Product(
      id: '1',
      name: 'Навушники',
      description: 'Навушники для музики',
      price: 1299.0,
      imageUrl: '',
      category: 'Електроніка',
    );

    test('Product stores the correct values', () {
      expect(product.id, '1');
      expect(product.name, 'Навушники');
      expect(product.price, 1299.0);
      expect(product.category, 'Електроніка');
    });

    test('copyWith changes selected values', () {
      final updated = product.copyWith(
        name: 'Клавіатура',
        price: 1499.0,
      );

      expect(updated.name, 'Клавіатура');
      expect(updated.price, 1499.0);
      expect(updated.id, product.id);
    });

    test('toJson converts product to a map', () {
      final json = product.toJson();

      expect(json['name'], 'Навушники');
      expect(json['price'], 1299.0);
      expect(json['category'], 'Електроніка');
    });

    test('fromJson restores a product', () {
      final restored = Product.fromJson(product.toJson());

      expect(restored.id, product.id);
      expect(restored.name, product.name);
      expect(restored.price, product.price);
      expect(restored.category, product.category);
    });
  });
}