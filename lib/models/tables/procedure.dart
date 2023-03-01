import '../database_table.dart';

class Procedure extends DatabaseTable {
  final int id;
  String name;
  String description;
  String software;

  Procedure({
    required this.id,
    required this.name,
    this.description = '',
    this.software = ''}) :
        super('Procedures', {
          'id': id,
          'name': name,
          'description': description,
          'software': software
        });
}