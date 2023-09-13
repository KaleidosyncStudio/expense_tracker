import 'package:expense_tracker/entities/category.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Expense {
  @Id()
  int id = 0;

  @Property(type: PropertyType.date)
  DateTime date;

  double value;
  final category = ToOne<Category>();

  Expense({
    this.id = 0,
    required this.date,
    required this.value,
    Category? category,
  }) {
    this.category.target = category;
  }
}
