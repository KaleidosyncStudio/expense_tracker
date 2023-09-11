import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Category {
  @Id()
  int id;

  String name;
  String color;

  Category({
    this.id = 0,
    required this.name,
    required this.color,
  });
}
