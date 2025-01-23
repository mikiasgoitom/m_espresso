import 'package:m_espresso_v1/entities/introduction.dart';

import '../entities/coffee.dart';

class DataTmp {
  static const chips = <String>[
    'Coffee',
    'Tea',
    'Juice',
    'Smoothie',
    'Pastry',
  ];

  // Introduction
  static final List<Introduction> introductionList = [
    Introduction(
      title: 'Streamline Your Coffee Shop',
      subtitle: 'Digitally manage orders and payments with ease.',
      imageUrl: 'assets/images/pic1.jpg',
    ),
    Introduction(
      title: 'Prevent Financial Discrepancies',
      subtitle: 'Keep records safe and secure, reducing errors and losses.',
      imageUrl: 'assets/images/pic2.jpg',
    ),
    Introduction(
      title: 'Track Sales and Revenue',
      subtitle: 'Monitor daily performance with detailed insights.',
      imageUrl: 'assets/images/pic3.jpg',
    ),
  ];

  // Coffee List Items
  static final List<Coffee> coffeeList = [
    Coffee(
      id: 1,
      name: 'Americano',
      imageUrl: 'https://i.imgur.com/y6Fj8tu.jpg',
      price: 3.8,
    ),
    Coffee(
      id: 2,
      name: 'Latte',
      imageUrl: 'https://i.imgur.com/tEf7zGq.jpg',
      price: 3.5,
    ),
    Coffee(
      id: 3,
      name: 'Cappuccino',
      imageUrl: 'https://i.imgur.com/2aBjCR7.jpg',
      price: 4.2,
    ),
    Coffee(
      id: 4,
      name: 'Espresso',
      imageUrl: 'https://i.imgur.com/HOU9gZO.jpg',
      price: 4.2,
    ),
    Coffee(
      id: 5,
      name: 'Mocha',
      imageUrl: 'https://i.imgur.com/M73FiE2.jpg',
      price: 4.4,
    ),
  ];
}
