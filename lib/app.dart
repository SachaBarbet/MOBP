import 'package:mobp/services/local_storage_service.dart';
import 'package:stacked/stacked_annotations.dart';

@StackedApp(
  routes: [],
  dependencies: [
    LazySingleton(classType: LocalStorageService)
  ]
)
class AppSetup {}