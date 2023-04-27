import 'component.dart';

class AppProcess {
  late String id;
  late String name;
  late String description;
  late String folderID;
  late List<ProcessComponent> components;

  AppProcess({required this.id, required this.name, required this.description, required this.folderID});
}