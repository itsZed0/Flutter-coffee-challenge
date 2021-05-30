import 'dart:math';

final coffeeList = List.generate(
  _names.length,
  (index) => Coffee(
    name: _names[index],
    image: '/${index + 1}.png',
    price: 5 + new Random().nextDouble() * (10 - 5 + 1),
  ),
);

class Coffee {
  final String name;
  final String image;
  final double price;
  Coffee({required this.name, required this.image, required this.price});
}

final _names = [
  'Name1',
  'Name2',
  'Name3',
  'Name4',
  'Name5',
  'Name6',
  'Name7',
  'Name8',
  'Name9',
  'Name10',
  'Name11',
  'Name12',
];
