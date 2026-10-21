class Book {
  final String id;
  final String title;
  final String author;
  final String genre;
  final String description;
  final int year;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.genre,
    required this.description,
    required this.year,
  });
}

const List<Book> sampleBooks = [
  Book(id: '1', title: 'Кобзар', author: 'Тарас Шевченко', genre: 'Класика', description: 'Збірка поетичних творів Тараса Шевченка.', year: 1840),
  Book(id: '2', title: 'Лісова пісня', author: 'Леся Українка', genre: 'Класика', description: 'Драма-феєрія про Мавку та Лукаша.', year: 1911),
  Book(id: '3', title: 'Тіні забутих предків', author: 'Михайло Коцюбинський', genre: 'Класика', description: 'Історія кохання Івана та Марічки в Карпатах.', year: 1911),
  Book(id: '4', title: 'Захар Беркут', author: 'Іван Франко', genre: 'Історія', description: 'Історична повість про боротьбу громади.', year: 1883),
  Book(id: '5', title: 'Місто', author: 'Валер’ян Підмогильний', genre: 'Роман', description: 'Роман про становлення молодої людини в місті.', year: 1928),
  Book(id: '6', title: 'Маруся Чурай', author: 'Ліна Костенко', genre: 'Роман', description: 'Історичний роман у віршах.', year: 1979),
  Book(id: '7', title: 'Чорна рада', author: 'Пантелеймон Куліш', genre: 'Історія', description: 'Історичний роман про Україну XVII століття.', year: 1857),
  Book(id: '8', title: 'Енеїда', author: 'Іван Котляревський', genre: 'Класика', description: 'Бурлескно-травестійна поема.', year: 1798),
  Book(id: '9', title: '451° за Фаренгейтом', author: 'Рей Бредбері', genre: 'Фантастика', description: 'Роман про суспільство, де заборонено книги.', year: 1953),
  Book(id: '10', title: 'Маленький принц', author: 'Антуан де Сент-Екзюпері', genre: 'Казка', description: 'Історія про дружбу та відповідальність.', year: 1943),
  Book(id: '11', title: 'Гаррі Поттер і філософський камінь', author: 'Дж. К. Ролінґ', genre: 'Фентезі', description: 'Перша історія про Гаррі Поттера.', year: 1997),
  Book(id: '12', title: 'Володар перснів', author: 'Дж. Р. Р. Толкін', genre: 'Фентезі', description: 'Епічна подорож заради знищення Персня.', year: 1954),
  Book(id: '13', title: 'Робінзон Крузо', author: 'Даніель Дефо', genre: 'Пригоди', description: 'Моряк опиняється на безлюдному острові.', year: 1719),
  Book(id: '14', title: 'Острів скарбів', author: 'Роберт Льюїс Стівенсон', genre: 'Пригоди', description: 'Пошуки піратського скарбу.', year: 1883),
  Book(id: '15', title: '1984', author: 'Джордж Орвелл', genre: 'Фантастика', description: 'Антиутопія про тотальний контроль.', year: 1949),
  Book(id: '16', title: 'Гордість і упередження', author: 'Джейн Остін', genre: 'Роман', description: 'Роман про кохання та суспільні упередження.', year: 1813),
  Book(id: '17', title: 'Пригоди Тома Соєра', author: 'Марк Твен', genre: 'Пригоди', description: 'Пригоди хлопчика Тома та його друзів.', year: 1876),
  Book(id: '18', title: 'Аліса в Країні див', author: 'Льюїс Керрол', genre: 'Казка', description: 'Фантастичні пригоди Аліси.', year: 1865),
];