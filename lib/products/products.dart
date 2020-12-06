import 'package:flutter/foundation.dart';

enum Category { all, }

class Product {
  const Product({
    @required this.category,
    @required this.id,
    @required this.isFeatured,
    @required this.name,
    @required this.price,

  }) : assert(category != null),
       assert(id != null),
       assert(isFeatured != null),
       assert(name != null),
       assert(price != null);

  final Category category;
  final int id;
  final bool isFeatured;
  final String name;
  final int price;

  String get assetName => 'salade_1.png';
  String get assetPackage => 'lib/images/';

  @override
  String toString() => "$name (id=$id)";

}