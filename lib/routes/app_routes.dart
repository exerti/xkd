import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:xkd/pages/example/example_page.dart';
import 'package:xkd/pages/home/home_page.dart';
import 'package:xkd/pages/user/user_page.dart';

/// 应用路由配置
/// 使用 GetX 路由管理
class AppRoutes {
  // 路由名称常量
  static const String home = '/home';
  static const String user = '/user';
  static const String example = '/example';
  
  // 路由页面映射
  static List<GetPage<dynamic>>  routes = [
    // 路由配置在 main.dart 中使用 GetMaterialApp 的 getPages 配置
    GetPage(name: home, page: () => const HomePage()),
    GetPage(name: user, page: () => const UserPage()),
    GetPage(name: example, page: () => const ExamplePage()),
 
  ];
}

