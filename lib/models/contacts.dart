import 'package:hive/hive.dart';
part 'contacts.g.dart';

@HiveType(typeId: 0)
class Contacts {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int age;

  Contacts(this.name, this.age);
}
