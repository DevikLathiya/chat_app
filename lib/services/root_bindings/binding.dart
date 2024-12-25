import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../app_controller/app_controller.dart';
import '../../core/constant/enums.dart';
import '../../core/utils/storage/storage_service.dart';
import '../api/api_endpoints.dart';
import '../api/api_repository.dart';

class AppInitialize {
  AppInitialize._();

  static Future initApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    await StorageService.initialize();
  }
}

class RootBinding implements Bindings {
  @override
  Future<void> dependencies() async {
    ApiEndPoints();
    Get.put<ApiRepository>(ApiRepository());
    Get.put<AppController>(AppController());
  }
}
