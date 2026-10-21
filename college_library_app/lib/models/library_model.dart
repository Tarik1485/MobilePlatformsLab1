import 'package:flutter/foundation.dart';
import 'book.dart';

class LibraryModel extends ChangeNotifier {
  final Map<String, DateTime> _reservations = {};

  Map<String, DateTime> get reservations =>
      Map.unmodifiable(_reservations);

  bool isReserved(String bookId) => _reservations.containsKey(bookId);

  void reserveBook(String bookId, DateTime returnDate) {
    _reservations[bookId] = returnDate;
    notifyListeners();
  }

  void cancelReservation(String bookId) {
    _reservations.remove(bookId);
    notifyListeners();
  }

  List<Book> get reservedBooks => sampleBooks
      .where((book) => _reservations.containsKey(book.id))
      .toList();

  DateTime? returnDateFor(String bookId) => _reservations[bookId];
}